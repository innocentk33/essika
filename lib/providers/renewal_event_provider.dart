import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:isar_community/isar.dart';

import '../models/renewal_event.dart';
import '../services/isar_service.dart';

class RenewalEventProvider extends ChangeNotifier {
  final Isar _isar = IsarService.instance;

  DateTime _focusedDate = DateTime.now();
  Map<DateTime, List<RenewalEvent>> _monthlyEvents = {};
  Map<DateTime, List<RenewalEvent>> _weeklyEvents = {};

  StreamSubscription<dynamic>? _isarSub;

  RenewalEventProvider() {
    // Abonnement aux changements en base (Isar)
    _isarSub = _isar.renewalEvents.watchLazy().listen((_) {
      // Quand la DB change, on recharge automatiquement la plage pertinente
      refresh();
    });

    // Chargement initial (non awaitable dans le ctor)
    refresh();
  }

  DateTime get focusedDate => _focusedDate;
  Map<DateTime, List<RenewalEvent>> get monthlyEvents => _monthlyEvents;
  Map<DateTime, List<RenewalEvent>> get weeklyEvents => _weeklyEvents;

  /// Change la date focalisée et recharge les données
  Future<void> setFocusedDate(DateTime date) async {
    _focusedDate = date;
    await loadMonthlyEvents();
    await loadWeeklyEvents();
  }

  /// Charge les événements du mois entier
  Future<void> loadMonthlyEvents() async {
    final startOfMonth = DateTime(_focusedDate.year, _focusedDate.month, 1);
    final endOfMonth = DateTime(_focusedDate.year, _focusedDate.month + 1, 0, 23, 59, 59);

    final events = await _isar.renewalEvents
        .filter()
        .renewalDateBetween(startOfMonth, endOfMonth)
        .findAll();

    _monthlyEvents = _groupEventsByDate(events);
    notifyListeners();
  }

  /// Charge les événements de la semaine (lundi à dimanche)
  Future<void> loadWeeklyEvents() async {
    final weekday = _focusedDate.weekday;
    final startOfWeek = DateTime(
      _focusedDate.year,
      _focusedDate.month,
      _focusedDate.day - (weekday - 1),
    );
    final endOfWeek = DateTime(
      startOfWeek.year,
      startOfWeek.month,
      startOfWeek.day + 6,
      23,
      59,
      59,
    );

    final events = await _isar.renewalEvents
        .filter()
        .renewalDateBetween(startOfWeek, endOfWeek)
        .findAll();

    _weeklyEvents = _groupEventsByDate(events);
    notifyListeners();
  }

  /// Récupère les événements pour un jour spécifique.
  /// Priorise les events hebdo (utile pour une vue semaine), sinon tombe sur mensuel.
  List<RenewalEvent> getEventsForDate(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    if (_weeklyEvents[normalizedDate]?.isNotEmpty ?? false) {
      return _weeklyEvents[normalizedDate]!;
    }
    return _monthlyEvents[normalizedDate] ?? [];
  }

  /// Vérifie si un jour a des événements (considère d'abord la semaine)
  bool hasEventsOnDate(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    if (_weeklyEvents[normalizedDate]?.isNotEmpty ?? false) return true;
    return _monthlyEvents[normalizedDate]?.isNotEmpty ?? false;
  }

  /// Calcule le total des paiements pour un jour
  double getTotalForDate(DateTime date) {
    final events = getEventsForDate(date);
    return events.fold(0.0, (sum, event) => sum + event.amount);
  }

  /// Calcule le total mensuel
  double getMonthlyTotal() {
    double total = 0.0;
    for (var events in _monthlyEvents.values) {
      total += events.fold(0.0, (sum, event) => sum + event.amount);
    }
    return total;
  }

  /// Calcule le total hebdomadaire
  double getWeeklyTotal() {
    double total = 0.0;
    for (var events in _weeklyEvents.values) {
      total += events.fold(0.0, (sum, event) => sum + event.amount);
    }
    return total;
  }

  /// Recharge toutes les données
  Future<void> refresh() async {
    await loadMonthlyEvents();
    await loadWeeklyEvents();
  }

  /// Groupe les événements par date normalisée
  Map<DateTime, List<RenewalEvent>> _groupEventsByDate(List<RenewalEvent> events) {
    final grouped = <DateTime, List<RenewalEvent>>{};

    for (var event in events) {
      final normalizedDate = DateTime(
        event.renewalDate.year,
        event.renewalDate.month,
        event.renewalDate.day,
      );

      (grouped[normalizedDate] ??= []).add(event);
    }

    return grouped;
  }

  @override
  void dispose() {
    _isarSub?.cancel();
    super.dispose();
  }
}
