import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../providers/renewal_event_provider.dart';
import 'week_day_cell.dart';

class WeekCalendarWidget extends StatelessWidget {
  const WeekCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RenewalEventProvider>(
      builder: (context, provider, _) {
        final now = provider.focusedDate;
        final weekday = now.weekday;
        final startOfWeek = DateTime(
          now.year,
          now.month,
          now.day - (weekday - 1),
        );
        final weekDays = List.generate(
          7,
              (index) => startOfWeek.add(Duration(days: index)),
        );

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: weekDays.map((day) {
            final isToday = isSameDay(day, now);
            final hasEvent = provider.hasEventsOnDate(day);
            return WeekDayCell(
              day: day,
              isToday: isToday,
              hasEvent: hasEvent,
            );
          }).toList(),
        );
      },
    );
  }
}
