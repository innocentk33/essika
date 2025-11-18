import 'package:isar_community/isar.dart';

import '../core/enum/billing_cycle.dart';

part 'subscription.g.dart';

@Collection()
class Subscription {
  Id id = Isar.autoIncrement;

  late String serviceName; // Netflix, Spotify, etc.
  late double price;

  @enumerated
  late BillingCycle billingCycle;

  late DateTime startDate;
  DateTime? endDate;

  String? description;

  @Index() // Index pour filtrage rapide
  late String category; // 'Divertissement', 'Sport', etc.

  String? logoUrl; // Path vers le logo

  @Index()
  late bool isActive;

  // Computed property
  @ignore
  double get monthlyPrice {
    switch (billingCycle) {
      case BillingCycle.monthly:
        return price;
      case BillingCycle.yearly:
        return price / 12;
      case BillingCycle.weekly:
        return price * 4.33; // Moyenne plus précise
    }
  }

  @ignore
  double get yearlyPrice => monthlyPrice * 12;
}
// facilitate the copyWith method

extension SubscriptionExtension on Subscription {
  Subscription copyWith({
    String? serviceName,
    double? price,
    BillingCycle? billingCycle,
    DateTime? startDate,
    DateTime? endDate,
    String? description,
    String? category,
    String? logoUrl,
    bool? isActive,
  }) {
    return Subscription()
      ..id = id
      ..serviceName = serviceName ?? this.serviceName
      ..price = price ?? this.price
      ..billingCycle = billingCycle ?? this.billingCycle
      ..startDate = startDate ?? this.startDate
      ..endDate = endDate ?? this.endDate
      ..description = description ?? this.description
      ..category = category ?? this.category
      ..logoUrl = logoUrl ?? this.logoUrl
      ..isActive = isActive ?? this.isActive;
  }
}
