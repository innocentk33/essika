import '../core/enum/billing_cycle.dart';
import '../models/subscription.dart';

extension SubscriptionDateUtils on Subscription {
  /// Ajoute un cycle à la date
  DateTime addCycle(DateTime date) {
    switch (billingCycle) {
      case BillingCycle.monthly:
        final newMonth = date.month + 1;
        final newYear = newMonth > 12 ? date.year + 1 : date.year;
        final actualMonth = newMonth > 12 ? 1 : newMonth;
        // Gérer les jours invalides (31 → 30/28)
        final lastDayOfMonth = DateTime(newYear, actualMonth + 1, 0).day;
        final day = date.day > lastDayOfMonth ? lastDayOfMonth : date.day;

        return DateTime(newYear, actualMonth, day);
      case BillingCycle.yearly:
        return DateTime(date.year + 1, date.month, date.day);
    }
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
