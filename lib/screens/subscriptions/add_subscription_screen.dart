import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/enum/billing_cycle.dart';
import '../../models/subscription.dart';
import '../../models/service_template.dart';
import '../../providers/service_template.dart';
import '../../providers/subscription_provider.dart';
import '../../providers/category_provider.dart';
import '../../providers/renewal_event_provider.dart';

class AddSubscriptionScreen extends StatefulWidget {
  const AddSubscriptionScreen({super.key});

  @override
  State<AddSubscriptionScreen> createState() => _AddSubscriptionScreenState();
}

class _AddSubscriptionScreenState extends State<AddSubscriptionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _serviceController = TextEditingController();
  final _priceController = TextEditingController();

  String _selectedCategory = 'Autres';
  BillingCycle _selectedCycle = BillingCycle.monthly;
  DateTime _startDate = DateTime.now();
  ServiceTemplate? _selectedTemplate;

  @override
  void dispose() {
    _serviceController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.watch<CategoryProvider>();
    final serviceProvider = context.watch<ServiceTemplateProvider>();
    final theme = Theme.of(context);

    _selectedCategory = _selectedCategory.isEmpty
        ? (categoryProvider.getCategoryNames().isNotEmpty
        ? categoryProvider.getCategoryNames().first
        : 'Autres')
        : _selectedCategory;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouvel abonnement'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 20,
          children: [
            // Services suggérés avec logos
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: serviceProvider.popularServices.length,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final svc = serviceProvider.popularServices[index];
                  final isSelected = _selectedTemplate?.id == svc.id;

                  return ServiceSuggestionCard(
                    service: svc,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        _selectedTemplate = svc;
                        _serviceController.text = svc.name;
                        _priceController.text = svc.suggestedPrice?.toString() ?? '';
                        _selectedCycle = svc.suggestedCycle;
                        _selectedCategory = svc.category ?? _selectedCategory;
                      });
                    },
                  );
                },
              ),
            ),

            // Formulaire
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 20,
                children: [
                  // Nom du service avec autocompletion
                  Autocomplete<ServiceTemplate>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<ServiceTemplate>.empty();
                      }
                      return serviceProvider.services.where((s) =>
                          s.name.toLowerCase().contains(
                              textEditingValue.text.toLowerCase()));
                    },
                    displayStringForOption: (s) => s.name,
                    onSelected: (service) {
                      setState(() {
                        _selectedTemplate = service;
                        _serviceController.text = service.name;
                        _priceController.text = service.suggestedPrice?.toString() ?? '';
                        _selectedCycle = service.suggestedCycle;
                        _selectedCategory = service.category ?? _selectedCategory;
                      });
                    },
                    fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                      controller.text = _serviceController.text;
                      return TextFormField(
                        controller: controller,
                        focusNode: focusNode,
                        decoration: const InputDecoration(
                          labelText: 'Nom du service',
                          hintText: 'Ex: Netflix, Spotify...',
                        ),
                        onChanged: (v) => _serviceController.text = v,
                        validator: (v) => (v == null || v.isEmpty)
                            ? 'Veuillez entrer un nom'
                            : null,
                      );
                    },
                  ),

                  // Prix
                  TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Prix',
                      suffixText: '€',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un prix';
                      }
                      if (double.tryParse(value.replaceAll(',', '.')) == null) {
                        return 'Prix invalide';
                      }
                      return null;
                    },
                  ),

                  // Fréquence sur toute la ligne
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    children: [
                      Text(
                        'Fréquence',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        spacing: 12,
                        children: BillingCycle.values.map((cycle) {
                          final selected = cycle == _selectedCycle;
                          return Expanded(
                            child: ChoiceChip(
                              label: Center(
                                child: Text(_getCycleLabel(cycle)),
                              ),
                              selected: selected,
                              onSelected: (on) {
                                if (on) setState(() => _selectedCycle = cycle);
                              },
                              selectedColor: theme.primaryColor.withOpacity(0.2),
                              backgroundColor: theme.cardTheme.color,
                              labelStyle: TextStyle(
                                color: selected
                                    ? theme.primaryColor
                                    : theme.textTheme.bodyLarge?.color,
                                fontWeight: selected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: selected
                                      ? theme.primaryColor
                                      : theme.dividerColor,
                                  width: selected ? 2 : 1,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  // Date de début
                  InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _startDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (date != null) {
                        setState(() => _startDate = date);
                      }
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: theme.dividerColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: theme.primaryColor,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date de début',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  DateFormat('dd MMMM yyyy', 'fr_FR').format(_startDate),
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bouton
                  ElevatedButton(
                    onPressed: _saveSubscription,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text("Ajouter l'abonnement"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCycleLabel(BillingCycle cycle) {
    switch (cycle) {
      case BillingCycle.monthly:
        return 'Mensuel';
      case BillingCycle.yearly:
        return 'Annuel';
    }
  }

  Future<void> _saveSubscription() async {
    if (!_formKey.currentState!.validate()) return;

    final priceText = _priceController.text.replaceAll(',', '.');
    final price = double.parse(priceText);

    final subscription = Subscription()
      ..serviceName = _serviceController.text
      ..price = price
      ..billingCycle = _selectedCycle
      ..startDate = _startDate
      ..category = _selectedCategory
      ..isActive = true;

    await context.read<SubscriptionProvider>().addSubscription(subscription);

    try {
      await context.read<RenewalEventProvider>().refresh();
    } catch (_) {}

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(microseconds: 500),
          content: const Text('Abonnement ajouté'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
    }
  }
}

// Widget Stateless pour les cartes de suggestion
class ServiceSuggestionCard extends StatelessWidget {
  final ServiceTemplate service;
  final bool isSelected;
  final VoidCallback onTap;

  const ServiceSuggestionCard({
    super.key,
    required this.service,
    required this.isSelected,
    required this.onTap,
  });

  Color _colorFromName(String name) {
    final hash = name.codeUnits.fold(0, (a, b) => a + b);
    final hue = (hash % 360).toDouble();
    return HSVColor.fromAHSV(1, hue, 0.45, 0.85).toColor();
  }

  String _initial(String name) => (name.isNotEmpty ? name[0].toUpperCase() : '?');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasLogo = service.logoUrl != null && service.logoUrl!.isNotEmpty;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 80,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.primaryColor.withOpacity(0.1)
              : theme.cardTheme.color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? theme.primaryColor
                : theme.dividerColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: hasLogo ? Colors.grey.shade50 : _colorFromName(service.name),
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.antiAlias,
              child: hasLogo
                  ? Image.asset(
                service.logoUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Text(
                      _initial(service.name),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              )
                  : Center(
                child: Text(
                  _initial(service.name),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                service.name,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

