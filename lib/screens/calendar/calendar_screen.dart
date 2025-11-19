import 'package:essika/screens/calendar/widgets/calendar_widget.dart';
import 'package:essika/screens/calendar/widgets/subscription_card.dart';
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
      const Center(child: CircularProgressIndicator());
    }

    return FutureBuilder<_CalendarData>(
      future: _loadCalendarData(provider),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data!;

        // Récupérer tous les événements du mois
        final allMonthEvents =
            data.renewalsByMonth.values.expand((list) => list).toList()
              ..sort((a, b) => a.renewalDate.compareTo(b.renewalDate));

        return Scaffold(
          appBar: AppBar(
            title: const Text('Calendrier'),
            centerTitle: false,
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                CalendarWidget(
                  focusedDay: _focusedDay,
                  selectedDay: _selectedDay,
                  calendarFormat: CalendarFormat.month,
                  renewalsByMonth: data.renewalsByMonth,
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Section titre pour les abonnements du mois
                if (allMonthEvents.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Paiement à venir (${data.monthlyTotal.toStringAsFixed(2)} €)',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 12),

                // GridView des cartes d'abonnements
                allMonthEvents.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(40),
                        child: Text(
                          'Aucun abonnement ce mois',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.85,
                            ),
                        itemCount: allMonthEvents.length,
                        itemBuilder: (context, index) {
                          final event = allMonthEvents[index];
                          final serviceName =
                              data.eventServiceNames[event.id] ??
                              'Service inconnu';
                          return SubscriptionCard(
                            event: event,
                            serviceName: serviceName,
                          );
                        },
                      ),
                const SizedBox(height: 20),
              ],
            ),
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

    // Récupérer tous les IDs uniques de subscriptions
    final allEvents = renewals.values.expand((list) => list).toList();
    final subscriptionIds = allEvents.map((e) => e.subscriptionId).toSet();

    // Créer un map event.id -> serviceName
    final eventServiceNames = <int, String>{};
    for (final id in subscriptionIds) {
      final subscription = await provider.getSubscriptionById(id);
      if (subscription != null) {
        // Trouver tous les events de cette subscription
        for (final event in allEvents.where((e) => e.subscriptionId == id)) {
          eventServiceNames[event.id] = subscription.serviceName;
        }
      }
    }

    return _CalendarData(renewals, total, eventServiceNames);
  }
}

class _CalendarData {
  final Map<DateTime, List<RenewalEvent>> renewalsByMonth;
  final double monthlyTotal;
  final Map<int, String> eventServiceNames; // event.id -> serviceName

  _CalendarData(
    this.renewalsByMonth,
    this.monthlyTotal,
    this.eventServiceNames,
  );
}
