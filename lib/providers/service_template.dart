import 'package:flutter/foundation.dart';
import 'package:isar_community/isar.dart';
import '../models/service_template.dart';
import '../services/isar_service.dart';

class ServiceTemplateProvider extends ChangeNotifier {
  final Isar _isar = IsarService.instance;

  List<ServiceTemplate> _services = [];
  bool _isLoading = false;

  List<ServiceTemplate> get services => _services;
  List<ServiceTemplate> get popularServices =>
      _services.where((s) => s.isPopular).toList();

  bool get isLoading => _isLoading;

  ServiceTemplateProvider() {
    loadServices();
  }

  Future<void> loadServices() async {
    _isLoading = true;
    notifyListeners();

    _services = await _isar.serviceTemplates
        .where()
        .sortByName()
        .findAll();

    _isLoading = false;
    notifyListeners();
  }

  // Rechercher un service
  Future<List<ServiceTemplate>> searchServices(String query) async {
    if (query.isEmpty) return _services;

    return await _isar.serviceTemplates
        .filter()
        .nameContains(query, caseSensitive: false)
        .findAll();
  }

  // Obtenir services par catégorie
  List<ServiceTemplate> getByCategory(String category) {
    return _services.where((s) => s.category == category).toList();
  }

  // Ajouter un service personnalisé
  Future<void> addCustomService(ServiceTemplate service) async {
    await _isar.writeTxn(() async {
      await _isar.serviceTemplates.put(service);
    });
    await loadServices();
  }
}