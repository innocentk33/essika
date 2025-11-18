import 'package:essika/models/category.dart';
import 'package:flutter/material.dart';
import 'package:isar_community/isar.dart';
import '../services/isar_service.dart';

class CategoryProvider extends ChangeNotifier {
  final Isar _isar = IsarService.instance;

  List<Category> _categories = [];
  bool _isLoading = false;

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;

  CategoryProvider() {
    loadCategories();
  }

  Future<void> loadCategories() async {
    _isLoading = true;
    notifyListeners();

    _categories = await _isar.categorys
        .where()
        .sortByName()
        .findAll();

    _isLoading = false;
    notifyListeners();
  }

  // Ajouter une catégorie personnalisée
  Future<void> addCategory(Category category) async {
    await _isar.writeTxn(() async {
      await _isar.categorys.put(category);
    });
    await loadCategories();
  }

  // Supprimer uniquement les catégories non-default
  Future<bool> deleteCategory(int id) async {
    final category = await _isar.categorys.get(id);

    if (category == null || category.isDefault) {
      return false; // Ne pas supprimer les catégories système
    }

    await _isar.writeTxn(() async {
      await _isar.categorys.delete(id);
    });
    await loadCategories();
    return true;
  }

  List<String> getCategoryNames() {
    return _categories.map((c) => c.name).toList();
  }
}