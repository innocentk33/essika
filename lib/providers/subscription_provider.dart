import 'package:flutter/foundation.dart';
import 'package:isar_community/isar.dart';
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
        .where((s) => s.isActive && s.startDate.year == now.year && s.startDate.month == now.month)
        .fold(0.0, (sum, s) => sum + s.monthlyPrice);
  }
  SubscriptionProvider() {
    loadSubscriptions();
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
    notifyListeners();
  }

  Future<void> updateSubscription(Subscription subscription) async {
    await _isar.writeTxn(() async {
      await _isar.subscriptions.put(subscription);
    });
    notifyListeners();
  }

  Future<void> deleteSubscription(int id) async {
    await _isar.writeTxn(() async {
      await _isar.subscriptions.delete(id);
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
}