import 'package:flutter/material.dart';
class WeekDayCell extends StatelessWidget {
  final DateTime day;
  final bool isToday;
  final bool hasEvent;

  const WeekDayCell({
    super.key,
    required this.day,
    required this.isToday,
    required this.hasEvent,
  });

  @override
  Widget build(BuildContext context) {
    final dayName = _getDayName(day.weekday);

    return Container(
      width: 45,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isToday ? const Color(0xFF6A5ACD) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            dayName,
            style: TextStyle(
              fontSize: 12,
              color: isToday ? Colors.white : Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${day.day}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isToday ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          if (hasEvent)
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: isToday ? Colors.white : const Color(0xFF6A5ACD),
                shape: BoxShape.circle,
              ),
            )
          else
            const SizedBox(height: 6),
        ],
      ),
    );
  }

  String _getDayName(int weekday) {
    const days = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
    return days[weekday - 1];
  }
}
