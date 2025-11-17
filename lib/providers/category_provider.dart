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

  // Load categories from database
  Future<void> loadCategories() async {
    _isLoading = true;
    notifyListeners();

    _categories = await _isar.categorys.where().findAll();

    _isLoading = false;
    notifyListeners();
  }

  // Add a new category
  Future<void> addCategory(Category category) async {
    await _isar.writeTxn(() => _isar.categorys.put(category));
    notifyListeners();
  }

  // Update an existing category
  Future<void> updateCategory(Category category) async {
    await _isar.writeTxn(() => _isar.categorys.put(category));
    notifyListeners();
  }

  // Delete a category
  Future<void> deleteCategory(Category category) async {
    final id = category.id;
    if (category.defaultCategory == true) {
      // Prevent deletion of default categories
      return;
    }

    await _isar.writeTxn(() => _isar.categorys.delete(id));
    notifyListeners();
  }
}
