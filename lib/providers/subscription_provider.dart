import 'package:flutter/foundation.dart';
import 'package:isar_community/isar.dart';
import '../core/enum/billing_cycle.dart';
import '../models/renewal_event.dart';
import '../models/subscription.dart';
import '../services/isar_service.dart';

class SubscriptionProvider extends ChangeNotifier {
  final Isar _isar = IsarService.instance;

  List<Subscription> _subscriptions = [];
  bool _isLoading = false;

  List<Subscription> get subscriptions => _subscriptions;

  bool get isLoading => _isLoading;

  // Stats calculées
  double get totalMonthly => _subscriptions
      .where((s) => s.isActive)
      .fold(0.0, (sum, s) => sum + s.monthlyPrice);

  double get totalYearly => totalMonthly * 12;

  int get activeCount => _subscriptions.where((s) => s.isActive).length;

  double get totalMonthlyStartedThisMonth {
    final now = DateTime.now();
    return _subscriptions
        .where(
          (s) =>
              s.isActive &&
              s.startDate.year == now.year &&
              s.startDate.month == now.month,
        )
        .fold(0.0, (sum, s) => sum + s.monthlyPrice);
  }

  SubscriptionProvider() {
    loadSubscriptions();
    initializeRenewalEvents(); // Initialisation des événements de renouvellement
    _listenToChanges(); // Watch en temps réel
  }

  // Chargement initial
  Future<void> loadSubscriptions() async {
    _isLoading = true;
    notifyListeners();

    _subscriptions = await _isar.subscriptions
        .where()
        .sortByStartDateDesc()
        .findAll();

    _isLoading = false;
    notifyListeners();
  }

  // Écoute les changements en temps réel (bonus Isar)
  void _listenToChanges() {
    _isar.subscriptions.watchLazy().listen((_) {
      loadSubscriptions();
    });
  }

  // CRUD Operations
  Future<void> addSubscription(Subscription subscription) async {
    await _isar.writeTxn(() async {
      await _isar.subscriptions.put(subscription);
    });
    await _regenerateRenewals(subscription);
    notifyListeners();
  }
  // Read
  Future<Subscription?> getSubscriptionById(int id) async {
    return await _isar.subscriptions.get(id);
  }
  // Update
  Future<void> updateSubscription(Subscription subscription) async {
    await _isar.writeTxn(() async {
      await _isar.subscriptions.put(subscription);
    });
    await _regenerateRenewals(subscription);
    notifyListeners();
  }
  // Delete
  Future<void> deleteSubscription(int id) async {
    await _isar.writeTxn(() async {
      await _isar.subscriptions.delete(id);
      await _isar.renewalEvents.filter().subscriptionIdEqualTo(id).deleteAll();
    });
    notifyListeners();
  }

  Future<void> toggleActive(int id) async {
    final sub = await _isar.subscriptions.get(id);
    if (sub != null) {
      sub.isActive = !sub.isActive;
      await updateSubscription(sub);
    }
  }

  // Recherche (exemple de query Isar)
  Future<List<Subscription>> searchByName(String query) async {
    return await _isar.subscriptions
        .filter()
        .serviceNameContains(query, caseSensitive: false)
        .findAll();
  }

  // Filtrer par catégorie
  List<Subscription> getByCategory(String category) {
    return _subscriptions.where((s) => s.category == category).toList();
  }

  // ===== NOUVELLES MÉTHODES POUR LE CALENDRIER =====

  /// Régénère tous les renouvellements (à appeler après ajout/modification)
  Future<void> _regenerateRenewals(Subscription subscription) async {
    await _isar.writeTxn(() async {
      // Supprime les anciens renouvellements de cet abonnement
      await _isar.renewalEvents
          .filter()
          .subscriptionIdEqualTo(subscription.id)
          .deleteAll();

      if (!subscription.isActive) return;

      // Génère les renouvellements a compter de la date de début jusqu'à 2 ans dans le futur a partir d'aujourd'hui en tenant compte du cycle de facturation
      final now = DateTime.now(); // Date actuelle
      final endDate = DateTime(
        now.year + 2,
        now.month,
        now.day,
      ); // 2 ans dans le futur
      DateTime subscriptionDate =
          subscription.startDate; // Date de début de l'abonnement
      final List<RenewalEvent> events = []; // événements  renouvellement
      switch (subscription.billingCycle) {
        case BillingCycle.monthly:
          while (subscriptionDate.isBefore(endDate)) {
            events.add(
              RenewalEvent()
                ..subscriptionId = subscription.id
                ..renewalDate = DateTime(
                  subscriptionDate.year,
                  subscriptionDate.month,
                  subscriptionDate.day,
                )
                ..amount = subscription.monthlyPrice
                ..year = subscriptionDate.year
                ..month = subscriptionDate.month,
            );

            subscriptionDate = DateTime(
              subscriptionDate.year,
              subscriptionDate.month + 1,
              subscriptionDate.day,
            );
          }
          break;
        case BillingCycle.yearly:
          while (subscriptionDate.isBefore(endDate)) {
            events.add(
              RenewalEvent()
                ..subscriptionId = subscription.id
                ..renewalDate = DateTime(
                  subscriptionDate.year,
                  subscriptionDate.month,
                  subscriptionDate.day,
                )
                ..amount = subscription.yearlyPrice
                ..year = subscriptionDate.year
                ..month = subscriptionDate.month,
            );

            subscriptionDate = DateTime(
              subscriptionDate.year + 1,
              subscriptionDate.month,
              subscriptionDate.day,
            );
          }
          break;
      }

      await _isar.renewalEvents.putAll(events);
    });
  }

  /// Récupère les renouvellements pour un mois (ULTRA RAPIDE)
  Future<Map<DateTime, List<RenewalEvent>>> getRenewalsByMonth(
    int year,
    int month,
  ) async {
    final events = await _isar.renewalEvents
        .where()
        .yearMonthEqualTo(year, month)
        .findAll();

    final grouped = <DateTime, List<RenewalEvent>>{};
    for (var event in events) {
      (grouped[event.renewalDate] ??= []).add(event);
    }

    return grouped;
  }

  /// Récupère les abonnements pour un jour donné
  Future<List<Subscription?>> getSubscriptionsForDay(DateTime day) async {
    final normalizedDay = DateTime(day.year, day.month, day.day);

    final events = await _isar.renewalEvents
        .where()
        .renewalDateEqualTo(normalizedDay)
        .findAll();

    final subIds = events.map((e) => e.subscriptionId).toSet();
    return await _isar.subscriptions.getAll(subIds.toList());
  }

  /// Calcule le total pour un jour (requête directe)
  Future<double> getTotalForDay(DateTime day) async {
    final normalizedDay = DateTime(day.year, day.month, day.day);

    final events = await _isar.renewalEvents
        .where()
        .renewalDateEqualTo(normalizedDay)
        .findAll();
    final amounts = await Future.wait(
      events.map((e) => Future.value(e.amount)),
    );
    return amounts.fold<double>(0.0, (sum, a) => sum + (a as double? ?? 0.0));
  }

  /// Calcule le total pour un mois (requête unique)
  Future<double> getTotalForMonth(int year, int month) async {
    final events = await _isar.renewalEvents
        .where()
        .yearMonthEqualTo(year, month)
        .findAll();

    final amounts = await Future.wait(
      events.map((e) => Future.value(e.amount)),
    );
    return amounts.fold<double>(0.0, (sum, a) => sum + (a as double? ?? 0.0));
  }

  /// Régénère tous les renouvellements pour tous les abonnements
  Future<void> regenerateAllRenewals() async {
    for (var subscription in _subscriptions) {
      await _regenerateRenewals(subscription);
    }
  }

  /// Appeler au premier lancement après migration
  Future<void> initializeRenewalEvents() async {
    final count = await _isar.renewalEvents.count();
    if (count == 0) {
      debugPrint('Initialisation des événements de renouvellement...');
      await regenerateAllRenewals();
    }
  }
}
