import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../models/renewal_event.dart';
import '../../providers/subscription_provider.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SubscriptionProvider>();

    if (provider.isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Calendrier')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return FutureBuilder<_CalendarData>(
      future: _loadCalendarData(provider),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: Text('Calendrier')),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final data = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: Text('Calendrier'),
            actions: [
              IconButton(
                icon: Icon(Icons.today),
                onPressed: () {
                  setState(() {
                    _focusedDay = DateTime.now();
                    _selectedDay = DateTime.now();
                  });
                },
                tooltip: 'Aujourd\'hui',
              ),
            ],
          ),
          body: Column(
            children: [
              _buildMonthStats(data.monthlyTotal),
              _buildCalendar(data.renewalsByMonth),
            ],
          ),
        );
      },
    );
  }

  /// Charge toutes les données nécessaires en une seule fois
  Future<_CalendarData> _loadCalendarData(SubscriptionProvider provider) async {
    final renewals = await provider.getRenewalsByMonth(
      _focusedDay.year,
      _focusedDay.month,
    );

    final total = await provider.getTotalForMonth(
      _focusedDay.year,
      _focusedDay.month,
    );

    return _CalendarData(renewals, total);
  }

  Widget _buildMonthStats(double monthlyTotal) {
    final monthName = DateFormat.yMMMM('fr_FR').format(_focusedDay);

    return Container(
      padding: EdgeInsets.all(16),
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                monthName,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                'Total des paiements',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${monthlyTotal.toStringAsFixed(2)} €',
              style: TextStyle(
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

  Widget _buildCalendar(Map<DateTime, List<RenewalEvent>> renewalsByMonth) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(DateTime.now().year + 30, 12, 31),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      calendarFormat: _calendarFormat,
      locale: 'fr_FR',

      calendarStyle: CalendarStyle(
        markersMaxCount: 1,
        markerDecoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
      ),

      headerStyle: HeaderStyle(
        formatButtonVisible: true,
        titleCentered: true,
        formatButtonShowsNext: false,
        formatButtonDecoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(20),
        ),
        formatButtonTextStyle: TextStyle(color: Theme.of(context).primaryColor),
      ),

      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },

      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },

      onPageChanged: (focusedDay) {
        setState(() {
          _focusedDay = focusedDay;
        });
      },

      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, _) =>
            _buildDayCell(day, renewalsByMonth),
        todayBuilder: (context, day, _) =>
            _buildDayCell(day, renewalsByMonth, isToday: true),
        selectedBuilder: (context, day, _) =>
            _buildDayCell(day, renewalsByMonth, isSelected: true),
      ),
    );
  }

  Widget _buildDayCell(
    DateTime day,
    Map<DateTime, List<RenewalEvent>> renewalsByMonth, {
    bool isToday = false,
    bool isSelected = false,
  }) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    final events = renewalsByMonth[normalizedDay] ?? [];
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
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
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

/// Classe helper pour stocker les données du calendrier
class _CalendarData {
  final Map<DateTime, List<RenewalEvent>> renewalsByMonth;
  final double monthlyTotal;

  _CalendarData(this.renewalsByMonth, this.monthlyTotal);
}
