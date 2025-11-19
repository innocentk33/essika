import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../models/renewal_event.dart';
import 'day_cell.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime focusedDay;
  final DateTime selectedDay;
  final CalendarFormat calendarFormat;
  final Map<DateTime, List<RenewalEvent>> renewalsByMonth;
  final Function(DateTime selectedDay, DateTime focusedDay) onDaySelected;
  final Function(DateTime focusedDay) onPageChanged;

  const CalendarWidget({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.calendarFormat,
    required this.renewalsByMonth,
    required this.onDaySelected,
    required this.onPageChanged,
  });

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(DateTime.now().year + 30, 12, 31),
      focusedDay: widget.focusedDay,
      selectedDayPredicate: (day) => isSameDay(widget.selectedDay, day),
      calendarFormat: widget.calendarFormat,
      locale: 'fr_FR',
      calendarStyle: CalendarStyle(
        markersMaxCount: 1,
        markerDecoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        todayDecoration: const BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
      ),

      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        formatButtonShowsNext: false,
        formatButtonDecoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(20),
        ),
        formatButtonTextStyle: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),

      onDaySelected: widget.onDaySelected,
      onPageChanged: widget.onPageChanged,

      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, _) => DayCellWidget(
          day: day,
          events: widget.renewalsByMonth[DateTime(day.year, day.month, day.day)] ?? [],
        ),
        todayBuilder: (context, day, _) => DayCellWidget(
          day: day,
          events: widget.renewalsByMonth[DateTime(day.year, day.month, day.day)] ?? [],
          isToday: true,
        ),
        selectedBuilder: (context, day, _) => DayCellWidget(
          day: day,
          events: widget.renewalsByMonth[DateTime(day.year, day.month, day.day)] ?? [],
          isSelected: true,
        ),
      ),
    );
  }
}
