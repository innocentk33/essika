import 'package:flutter/material.dart';

import '../../../models/renewal_event.dart';
class DayCellWidget extends StatelessWidget {
  final DateTime day;
  final List<RenewalEvent> events;
  final bool isToday;
  final bool isSelected;

  const DayCellWidget({
    super.key,
    required this.day,
    required this.events,
    this.isToday = false,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final total = events.fold(0.0, (sum, e) => sum + e.amount);

    Color? backgroundColor;
    Color textColor = Colors.black;

    if (isSelected) {
      backgroundColor = Theme.of(context).primaryColor;
      textColor = Colors.white;
    } else if (isToday) {
      backgroundColor = Colors.orange.withOpacity(0.3);
    } else if (events.isNotEmpty) {
      if (total < 20) {
        backgroundColor = Colors.green.withOpacity(0.3);
      } else if (total < 50) {
        backgroundColor = Colors.orange.withOpacity(0.4);
      } else {
        backgroundColor = Colors.red.withOpacity(0.5);
      }
    }

    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${day.day}',
              style: TextStyle(
                color: textColor,
                fontWeight: isSelected || isToday
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
            if (events.isNotEmpty)
              Text(
                '${total.toStringAsFixed(0)}€',
                style: TextStyle(
                  fontSize: 9,
                  color: textColor.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
