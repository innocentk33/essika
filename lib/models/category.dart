import 'package:isar_community/isar.dart';

part 'category.g.dart';

@Collection()
class Category {
  Id id = Isar.autoIncrement;
  final String name;
  String? description;
  String? imagePath;
  bool defaultCategory = false;

  Category({required this.name});
}

extension CategoryExtension on Category {
  Category copyWith({
    String? name,
    String? description,
    String? imagePath,
  }) {
    return Category(
      name: name ?? this.name,
    )
      ..description = description ?? this.description
      ..imagePath = imagePath ?? this.imagePath;
  }
}
