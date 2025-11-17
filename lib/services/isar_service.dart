import 'package:essika/models/subscription.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/category.dart';

class IsarService {
  static late Isar isar;

  static Future<void> initDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([
      CategorySchema,
      SubscriptionSchema,
    ], directory: dir.path);
  }

  // Ajout d'un getter pour accéder à l'instance Isar
  static Isar get instance => isar;
}
