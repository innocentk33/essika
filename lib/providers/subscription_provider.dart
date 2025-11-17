import 'package:essika/services/isar_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:isar_community/isar.dart';

import '../models/subscription.dart';

class SubscriptionProvider extends ChangeNotifier {
  final Isar _isar = IsarService.instance;
  List<Subscription> _subscriptions = [];
  bool _isLoading = false;

  List<Subscription> get subscriptions => _subscriptions;
  bool get isLoading => _isLoading;

  // CRUD operations for AbonnementModel
  //Create
  Future<void> addSubscription(Subscription subscription) async {
    await _isar.writeTxn(() => _isar.subscriptions.put(subscription));
    notifyListeners();
  }

  //Read
  Future<List<Subscription>> getAllSubscriptions() async {
    return await _isar.subscriptions.where().findAll();
  }

  //Single Read
  Future<Subscription?> getSubscriptionById(Subscription subscription) async {
    return await _isar.subscriptions.get(subscription.id);
  }

  // Chargement initial des abonnements
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

  //Update
  Future<void> updateSubscription(Subscription subscription) async {
    await _isar.writeTxn(() => _isar.subscriptions.put(subscription));
    notifyListeners();
  }

  //Delete
  Future<void> deleteSubscription(int id) async {
    await _isar.writeTxn(() => _isar.subscriptions.delete(id));
    notifyListeners();
  }
}
