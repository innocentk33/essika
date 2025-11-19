import 'package:isar_community/isar.dart';

import '../core/enum/billing_cycle.dart';

part 'service_template.g.dart';

@collection
class ServiceTemplate {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String name;

  String? logoUrl; // URL du logo ou asset path
  String? category;
  double? suggestedPrice; // Prix suggéré

  @enumerated
  late BillingCycle suggestedCycle;

  bool isPopular; // Pour trier les plus utilisés
  bool isDefault; // Pour ne pas supprimer

  ServiceTemplate({
    this.name = '',
    this.logoUrl,
    this.category,
    this.suggestedPrice,
    this.suggestedCycle = BillingCycle.monthly,
    this.isPopular = false,
    this.isDefault = false,
  });
}
extension ServiceTemplateExtension on ServiceTemplate {
  ServiceTemplate copyWith({
    String? name,
    String? logoUrl,
    String? category,
    double? suggestedPrice,
    BillingCycle? suggestedCycle,
    bool? isPopular,
    bool? isDefault,
  }) {
    return ServiceTemplate(
      name: name ?? this.name,
      logoUrl: logoUrl ?? this.logoUrl,
      category: category ?? this.category,
      suggestedPrice: suggestedPrice ?? this.suggestedPrice,
      suggestedCycle: suggestedCycle ?? this.suggestedCycle,
      isPopular: isPopular ?? this.isPopular,
      isDefault: isDefault?? this.isDefault,
    );
  }
}