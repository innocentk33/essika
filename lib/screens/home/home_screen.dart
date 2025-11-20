import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/subscription.dart';
import '../../providers/subscription_provider.dart';
import '../calendar/widgets/week_calendar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<SubscriptionProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
        
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  // Stats card (toujours affichée)
                  const StatsCard(),
        
                  // Section calendrier
                  Text(
                    'Cette semaine',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const WeekCalendarWidget(),
        
                  // Section abonnements actifs
                  Text(
                    'Mes abonnements actifs',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
        
                  // Liste ou état vide
                  provider.subscriptions.isEmpty
                      ? const SubscriptionsEmptyState()
                      : SubscriptionsList(subscriptions: provider.subscriptions),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await Navigator.pushNamed(context, '/add-subscription');
          },
          icon: const Icon(Icons.add),
          label: const Text('Ajouter'),
        ),
      ),
    );
  }
}

// Widget Stateless pour les statistiques
class StatsCard extends StatelessWidget {
  const StatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SubscriptionProvider>(
      builder: (context, provider, _) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StatItem(
                label: 'Total mensuel',
                value: '${provider.totalMonthlyStartedThisMonth.toStringAsFixed(2)} €',
                icon: Icons.euro_rounded,
              ),
              Container(
                width: 1,
                height: 60,
                color: Theme.of(context).dividerColor,
              ),
              StatItem(
                label: 'Total annuel',
                value: '${provider.totalYearly.toStringAsFixed(2)} €',
                icon: Icons.calendar_month_rounded,
              ),
            ],
          ),
        );
      },
    );
  }
}

// Widget Stateless pour un item de statistique
class StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const StatItem({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        Icon(icon, size: 24, color: Theme.of(context).primaryColor),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
              ),
        ),
      ],
    );
  }
}

// Widget Stateless pour l'état vide
class SubscriptionsEmptyState extends StatelessWidget {
  const SubscriptionsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        spacing: 16,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          Text(
            'Aucun abonnement',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          Text(
            'Ajoutez votre premier abonnement pour commencer',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Widget Stateless pour la liste des abonnements
class SubscriptionsList extends StatelessWidget {
  final List<Subscription> subscriptions;

  const SubscriptionsList({
    super.key,
    required this.subscriptions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: subscriptions
          .map((sub) => SubscriptionItem(subscription: sub))
          .toList(),
    );
  }
}

// Widget Stateless pour un item d'abonnement
class SubscriptionItem extends StatelessWidget {
  final Subscription subscription;

  const SubscriptionItem({
    super.key,
    required this.subscription,
  });

  Color _colorFromName(String name) {
    final hash = name.codeUnits.fold(0, (a, b) => a + b);
    final hue = (hash % 360).toDouble();
    return HSVColor.fromAHSV(1, hue, 0.45, 0.85).toColor();
  }

  @override
  Widget build(BuildContext context) {
    final hasLogo = subscription.logoUrl != null && subscription.logoUrl!.isNotEmpty;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/subscription-detail',
            arguments: {'id': subscription.id},
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Logo rectangulaire
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: hasLogo ? Colors.grey.shade50 : _colorFromName(subscription.serviceName),
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: hasLogo
                    ? Image.asset(
                        subscription.logoUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Text(
                              subscription.serviceName[0].toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          subscription.serviceName[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subscription.serviceName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${subscription.price.toStringAsFixed(2)} € / ${subscription.billingCycle.name}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                    ),
                  ],
                ),
              ),
              Icon(
                subscription.isActive ? Icons.check_circle : Icons.cancel,
                color: subscription.isActive
                    ? Colors.green
                    : Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
