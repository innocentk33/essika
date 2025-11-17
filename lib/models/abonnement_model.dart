import 'package:essika/core/enum/frequence.dart';
import 'package:isar_community/isar.dart';

part 'abonnement_model.g.dart';

@Collection()
class AbonnementModel {
  Id id = Isar.autoIncrement;
  final String name;
  final double amount;
  DateTime billingDate = DateTime.now();
  bool isActive = false;
  String? imagePath;

  @enumerated
  final Frequency frequency;

  AbonnementModel({
    required this.name,
    required this.amount,
    required this.frequency,
  });
}
