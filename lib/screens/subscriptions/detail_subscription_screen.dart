

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/enum/billing_cycle.dart';
import '../../models/subscription.dart';
import '../../providers/subscription_provider.dart';

class DetailSubscriptionScreen extends StatefulWidget {
  final int subscriptionId;

  const DetailSubscriptionScreen({
    super.key,
    required this.subscriptionId,
  });

  @override
  State<DetailSubscriptionScreen> createState() =>
      _DetailSubscriptionScreenState();

}
class _DetailSubscriptionScreenState extends State<DetailSubscriptionScreen> {
  static const Color _backgroundColor = Color(0xFFF5F2FF);
  static const Color _accentPurple = Color(0xFF8F4CFF);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _monthlyPriceController = TextEditingController();
  final TextEditingController _yearlyPriceController = TextEditingController();

  late final SubscriptionProvider _provider;
  late Future<Subscription?> _subscriptionFuture;

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _provider = context.read<SubscriptionProvider>();
    _subscriptionFuture = _provider.getSubscriptionById(widget.subscriptionId);
  }

  @override
  void dispose() {
    _serviceNameController.dispose();
    _monthlyPriceController.dispose();
    _yearlyPriceController.dispose();
    super.dispose();
  }

  DateTime _nextBillingDate(Subscription subscription) {
    final now = DateTime.now();
    DateTime next = subscription.startDate;
    while (!next.isAfter(now)) {
      next = subscription.billingCycle == BillingCycle.monthly
          ? DateTime(next.year, next.month + 1, next.day)
          : DateTime(next.year + 1, next.month, next.day);
    }
    return next;
  }

  Future<void> _handleEditAction(Subscription subscription) async {
    if (_isEditing) {
      if (!_formKey.currentState!.validate()) return;
      final updatedName = _serviceNameController.text.trim();
      final monthly =
      _parsePrice(_monthlyPriceController.text, subscription.monthlyPrice);
      final yearly =
      _parsePrice(_yearlyPriceController.text, subscription.yearlyPrice);

      subscription
        ..serviceName = updatedName
        ..price = monthly;

      await _provider.updateSubscription(subscription);
      if (!mounted) return;
      FocusScope.of(context).unfocus();
      _reloadSubscription(resetEditing: true);
      return;
    }

    setState(() => _isEditing = true);
  }

// language: dart
// File: `lib/screens/subscriptions/detail_subscription_screen.dart`

  Future<void> _cancelSubscription(Subscription subscription) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Annuler l\'abonnement'),
        content: const Text('Souhaitez‑vous annuler cet abonnement ? Les futurs renouvellements seront supprimés.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Non')),
          TextButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('Oui')),
        ],
      ),
    );

    if (confirm != true) return;
    if (!subscription.isActive) return;

    // Place l'abonnement en inactive -> updateSubscription régénère/supprime les renewalEvents
    subscription.isActive = false;
    await _provider.updateSubscription(subscription);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Abonnement annulé')),
    );
    _reloadSubscription(resetEditing: true);
  }

  Future<void> _deleteSubscription(Subscription subscription) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Supprimer l\'abonnement'),
        content: const Text('Cette action supprimera l\'abonnement et tous ses événements de renouvellement. Continuer ?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Annuler')),
          TextButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('Supprimer')),
        ],
      ),
    );

    if (confirm != true) return;

    await _provider.deleteSubscription(subscription.id);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Abonnement supprimé')),
    );
    Navigator.of(context).pop(); // ferme la page de détail
  }

  void _reloadSubscription({bool resetEditing = false}) {
    if (!mounted) return;
    setState(() {
      _subscriptionFuture = _provider.getSubscriptionById(widget.subscriptionId);
      if (resetEditing) _isEditing = false;
    });
  }

  double _parsePrice(String value, double fallback) {
    final normalized = value.replaceAll(',', '.');
    return double.tryParse(normalized) ?? fallback;
  }

  String? _nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nom obligatoire';
    }
    return null;
  }

  String? _priceValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Champ requis';
    }
    final normalized = value.replaceAll(',', '.');
    if (double.tryParse(normalized) == null) {
      return 'Format invalide';
    }
    return null;
  }

  void _ensureControllers(Subscription subscription) {
    if (_isEditing) return;
    _serviceNameController.text = subscription.serviceName;
    _monthlyPriceController.text = subscription.monthlyPrice.toStringAsFixed(2);
    _yearlyPriceController.text = subscription.yearlyPrice.toStringAsFixed(2);
  }

  Widget _buildEditablePriceField(
      String label,
      TextEditingController controller,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              )),
          const SizedBox(height: 6),
          SizedBox(
            height: 52,
            child: TextFormField(
              controller: controller,
              validator: _priceValidator,
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                prefixText: '€ ',
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: _accentPurple),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: _accentPurple,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Détails de l'abonnement",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<Subscription?>(
        future: _subscriptionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final subscription = snapshot.data;
          if (subscription == null) {
            return const Center(child: Text("Abonnement introuvable"));
          }
          return _buildContent(subscription);
        },
      ),
    );
  }

  Widget _buildContent(Subscription subscription) {
    final isMonthly = subscription.billingCycle == BillingCycle.monthly;
    final price = isMonthly ? subscription.monthlyPrice : subscription.yearlyPrice;
    final pricePeriod = isMonthly ? 'par mois' : 'par an';
    final recurrenceLabel = isMonthly ? 'Tous les mois' : 'Une fois par an';
    final formatter = NumberFormat.currency(locale: 'fr_FR', symbol: '€');
    final formattedPrice = formatter.format(price);
    final nextBilling = _nextBillingDate(subscription);
    final formattedNext = DateFormat('d MMM yyyy', 'fr_FR').format(nextBilling);
    final reminder = nextBilling.subtract(const Duration(days: 3));
    final reminderLabel = 'Rappel ${DateFormat('d MMM', 'fr_FR').format(reminder)}';

    _ensureControllers(subscription);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 8),
            CircleAvatar(
              radius: 42,
              backgroundColor: Colors.white,
              child: Text(
                subscription.serviceName.isNotEmpty
                    ? subscription.serviceName.substring(0, 1).toUpperCase()
                    : '?',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _isEditing
                ? TextFormField(
              controller: _serviceNameController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Nom du service',
              ),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              validator: _nameValidator,
            )
                : Text(
              subscription.serviceName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subscription.category,
              style: TextStyle(
                fontSize: 16,
                color: Colors.brown.shade400,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildCycleTab('Mensuel', isMonthly)),
                      Expanded(child: _buildCycleTab('Annuel', !isMonthly)),
                    ],
                  ),
                  if (_isEditing) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildEditablePriceField(
                            'Mensuel',
                            _monthlyPriceController,
                          ),
                        ),
                        Expanded(
                          child: _buildEditablePriceField(
                            'Annuel',
                            _yearlyPriceController,
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 16),
                  Text(
                    formattedPrice,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: _accentPurple,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pricePeriod,
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildDetailRow(
                    Icons.calendar_today,
                    'Prochaine facture',
                    formattedNext,
                  ),
                  const Divider(),
                  _buildDetailRow(
                    Icons.repeat,
                    'Récurrence',
                    recurrenceLabel,
                  ),
                  const Divider(),
                  _buildDetailRow(
                    Icons.notifications,
                    'Rappels',
                    reminderLabel,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _handleEditAction(subscription),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accentPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: Text(
                  _isEditing ? 'Enregistrer' : 'Modifier',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (subscription.isActive) ...[
              TextButton(
                onPressed: _isEditing
                    ? null
                    : () => _cancelSubscription(subscription),
                style: TextButton.styleFrom(
                  foregroundColor: _accentPurple,
                ),
                child: const Text(
                  'Annuler l\'abonnement',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ] else ...[
              Text(
                'Abonnement annulé',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () => _deleteSubscription(subscription),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: _accentPurple),
                  foregroundColor: _accentPurple,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'Supprimer l\'abonnement',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildCycleTab(String label, bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: active ? Colors.transparent : Colors.grey.shade300,
        ),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: active ? _accentPurple : Colors.grey,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.brown.shade400),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
