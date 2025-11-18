import 'package:essika/screens/calendar/widgets/calendar_widget.dart';
import 'package:essika/screens/calendar/widgets/month_stats.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../models/renewal_event.dart';
import '../../providers/renewal_event_provider.dart';
import '../../providers/subscription_provider.dart';
import 'package:flutter/material.dart';

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

    // Charge les données initiales
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RenewalEventProvider>().setFocusedDate(_focusedDay);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SubscriptionProvider>();

    if (provider.isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Calendrier')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return FutureBuilder<_CalendarData>(
      future: _loadCalendarData(provider),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: const Text('Calendrier')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final data = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Calendrier'),
            actions: [
              IconButton(
                icon: const Icon(Icons.today),
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
              MonthStatsWidget(
                focusedDay: _focusedDay,
                monthlyTotal: data.monthlyTotal,
              ),
              CalendarWidget(
                focusedDay: _focusedDay,
                selectedDay: _selectedDay,
                calendarFormat: _calendarFormat,
                renewalsByMonth: data.renewalsByMonth,
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
              ),
            ],
          ),
        );
      },
    );
  }

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
}

class _CalendarData {
  final Map<DateTime, List<RenewalEvent>> renewalsByMonth;
  final double monthlyTotal;

  _CalendarData(this.renewalsByMonth, this.monthlyTotal);
}
