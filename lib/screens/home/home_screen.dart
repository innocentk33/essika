import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/subscription_provider.dart';
import '../calendar/widgets/week_calendar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SubscriptionProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.subscriptions.isEmpty) {
            return _buildEmptyState(context);
          }

          return Column(
            children: [
              // Stats card (isolé avec Consumer)
              _buildStatsCard(context),

              Row(
                children: [
                  Text('Cette semaine', style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              // Vue calendrier simplifiée sur une semaine
               WeekCalendarWidget(),

              Row(
                children: [
                  Text('Mes abonnement actifs', style: Theme.of(context).textTheme.titleMedium),
                ],
              ),

              // Liste
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: provider.subscriptions.length,
                  itemBuilder: (context, index) {
                    final sub = provider.subscriptions[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(sub.serviceName[0].toUpperCase()),
                        ),
                        title: Text(sub.serviceName),
                        subtitle: Text(
                          '${sub.price.toStringAsFixed(2)} € / ${sub.billingCycle.name}',
                        ),
                        trailing: Icon(
                          sub.isActive ? Icons.check_circle : Icons.cancel,
                          color: sub.isActive ? Colors.green : Colors.grey,
                        ),
                        onTap: () {
                          // Navigation vers le détail
                          Navigator.pushNamed(
                            context,
                            '/subscription-detail',
                            arguments: {'id': sub.id},
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // Navigation vers ajout
          await Navigator.pushNamed(context, '/add-subscription');
          // Optionnel : refresh après retour (si besoin)
          // context.read<SubscriptionProvider>().loadSubscriptions();
        },
        icon: Icon(Icons.add),
        label: Text('Ajouter'),
      ),
    );
  }

  Widget _buildStatsCard(BuildContext context) {
    return Consumer<SubscriptionProvider>(
      builder: (context, provider, _) {
        return Card(
          margin: EdgeInsets.all(16),
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  context,
                  'Total mensuel',
                  '${provider.totalMonthlyStartedThisMonth.toStringAsFixed(2)} €',
                  Icons.euro,
                ),
                _buildStatItem(
                  context,
                  'Total annuel',
                  '${provider.totalYearly.toStringAsFixed(2)}€',
                  Icons.calendar_month_rounded,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Theme.of(context).primaryColor),
        SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 100, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Aucun abonnement',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 8),
          Text(
            'Appuyez sur + pour commencer',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
