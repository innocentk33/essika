import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthStatsWidget extends StatelessWidget {
  final DateTime focusedDay;
  final double monthlyTotal;

  const MonthStatsWidget({
    super.key,
    required this.focusedDay,
    required this.monthlyTotal,
  });

  @override
  Widget build(BuildContext context) {
    final monthName = DateFormat.yMMMM('fr_FR').format(focusedDay);

    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                monthName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Total des paiements',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${monthlyTotal.toStringAsFixed(2)} €',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
