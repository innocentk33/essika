import 'package:essika/models/subscription.dart';
import 'package:flutter/rendering.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../core/const/default_data.dart';
import '../models/category.dart';
import '../models/service_template.dart';

class IsarService {
  static late Isar isar;

  static Future<void> initDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [CategorySchema, SubscriptionSchema, ServiceTemplateSchema],
      directory: dir.path,
      inspector: true,
    );

    // Initialiser les données par défaut au premier lancement
    await _initializeDefaultData();
  }

  // Ajout d'un getter pour accéder à l'instance Isar
  static Isar get instance => isar;

  /// Initialise les catégories et services par défaut
  static Future<void> _initializeDefaultData() async {
    // Vérifier si déjà initialisé
    final categoryCount = await isar.categorys.count();
    final serviceCount = await isar.serviceTemplates.count();

    if (categoryCount == 0) {
      await _seedCategories();
    }

    if (serviceCount == 0) {
      await _seedServiceTemplates();
    }
  }

  /// Ajoute les catégories par défaut
  static Future<void> _seedCategories() async {
    await isar.writeTxn(() async {
      await isar.categorys.putAll(defaultCategories);
    });

    debugPrint('${defaultCategories.length} catégories initialisées');
  }

  /// Ajoute les services populaires par défaut
  static Future<void> _seedServiceTemplates() async {
    await isar.writeTxn(() async {
      await isar.serviceTemplates.putAll(defaultServices);
    });

    debugPrint('${defaultServices.length} services initialisés');
  }

  /// Méthode pour réinitialiser les données (utile pour debug/tests)
  static Future<void> resetDefaultData() async {
    await isar.writeTxn(() async {
      await isar.categorys.where().deleteAll();
      await isar.serviceTemplates.where().deleteAll();
    });

    await _seedCategories();
    await _seedServiceTemplates();

    debugPrint('Données par défaut réinitialisées');
  }
}
