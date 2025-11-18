import 'package:isar_community/isar.dart';

part 'category.g.dart';

@Collection()
class Category {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String name;

  String? iconName; // Nom de l'icône
  String? colorHex; // Couleur en hex

  bool isDefault; // Catégorie système non supprimable

  Category({
    this.name = '',
    this.iconName,
    this.colorHex,
    this.isDefault = false,
  });
}

extension CategoryExtension on Category {
  Category copyWith({
    String? name,
    String? iconName,
    String? colorHex,
    bool? isDefault,
  }) {
    return Category(
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
      colorHex: colorHex ?? this.colorHex,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
