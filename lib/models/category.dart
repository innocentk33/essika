import 'package:isar_community/isar.dart';

part 'category.g.dart';

@Collection()
class Category {
  Id id = Isar.autoIncrement;
  final String name;
  String? description;
  String? imagePath;

  Category({required this.name});
}
