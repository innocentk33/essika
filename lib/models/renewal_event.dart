import 'package:isar_community/isar.dart';

part 'renewal_event.g.dart';

@Collection()
class RenewalEvent {
  Id id = Isar.autoIncrement;

  /// ID de l'abonnement lié
  @Index()
  late int subscriptionId;

  /// Date du renouvellement (normalisée à minuit)
  @Index()
  late DateTime renewalDate;

  /// Prix à payer ce jour-là
  late double amount;

  /// Pour faciliter les requêtes par mois
  @Index(composite: [CompositeIndex('month')])
  late int year;

  late int month;
}
