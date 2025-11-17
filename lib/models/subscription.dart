import 'package:essika/core/enum/frequence.dart';
import 'package:isar_community/isar.dart';

part 'subscription.g.dart';

@Collection()
class Subscription {
  Id id = Isar.autoIncrement;
  final String name;
  final double amount;
  DateTime startDate = DateTime.now();
  DateTime nextPaymentDate = DateTime.now();
  bool isActive = false;
  String? imagePath;

  @enumerated
  final Frequency frequency;

  Subscription({
    required this.name,
    required this.amount,
    required this.frequency,
  });
}
// facilitate the copyWith method

extension SubscriptionExtension on Subscription {
  Subscription copyWith({
    String? name,
    double? amount,
    DateTime? startDate,
    DateTime? nextPaymentDate,
    bool? isActive,
    String? imagePath,
    Frequency? frequency,
  }) {
    return Subscription(
        name: name ?? this.name,
        amount: amount ?? this.amount,
        frequency: frequency ?? this.frequency,
      )
      ..startDate = startDate ?? this.startDate
      ..nextPaymentDate = nextPaymentDate ?? this.nextPaymentDate
      ..isActive = isActive ?? this.isActive
      ..imagePath = imagePath ?? this.imagePath;
  }
}
