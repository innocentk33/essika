import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/enum/billing_cycle.dart';
import '../../models/subscription.dart';
import '../../models/service_template.dart';
import '../../providers/service_template.dart';
import '../../providers/subscription_provider.dart';
import '../../providers/category_provider.dart';


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

    return Scaffold(
      appBar: AppBar(
        title: Text('Nouvel abonnement'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            // Services populaires (chips)
            Text('Services populaires', style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: serviceProvider.popularServices.map((service) {
                final isSelected = _selectedTemplate?.id == service.id;
                return FilterChip(
                  label: Text(service.name),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedTemplate = service;
                        _serviceController.text = service.name;
                        _priceController.text = service.suggestedPrice?.toString() ?? '';
                        _selectedCycle = service.suggestedCycle;
                        _selectedCategory = service.category ?? 'Autres';
                      } else {
                        _selectedTemplate = null;
                      }
                    });
                  },
                );
              }).toList(),
            ),

            Divider(height: 32),

            // Nom du service (avec autocomplete)
            Autocomplete<ServiceTemplate>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<ServiceTemplate>.empty();
                }
                return serviceProvider.services.where((service) {
                  return service.name
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
              },
              displayStringForOption: (ServiceTemplate service) => service.name,
              onSelected: (ServiceTemplate service) {
                setState(() {
                  _selectedTemplate = service;
                  _serviceController.text = service.name;
                  _priceController.text = service.suggestedPrice?.toString() ?? '';
                  _selectedCycle = service.suggestedCycle ?? BillingCycle.monthly;
                  _selectedCategory = service.category ?? 'Autres';
                });
              },
              fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                _serviceController.text = controller.text;
                return TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    labelText: 'Nom du service',
                    hintText: 'Netflix, Spotify...',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.business),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un nom';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _serviceController.text = value;
                  },
                );
              },
            ),
            SizedBox(height: 16),

            // Catégorie (dropdown)
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(
                labelText: 'Catégorie',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
              items: categoryProvider.getCategoryNames().map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedCategory = value;
                  });
                }
              },
            ),
            SizedBox(height: 16),

            // Prix
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Prix',
                hintText: '9.99',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.euro),
                suffixText: '€',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
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
            SizedBox(height: 16),

            // Fréquence
            DropdownButtonFormField<BillingCycle>(
              value: _selectedCycle,
              decoration: InputDecoration(
                labelText: 'Fréquence de paiement',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.repeat),
              ),
              items: BillingCycle.values.map((cycle) {
                return DropdownMenuItem(
                  value: cycle,
                  child: Text(_getCycleLabel(cycle)),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedCycle = value;
                  });
                }
              },
            ),
            SizedBox(height: 16),

            // Date de début
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Date de début'),
              subtitle: Text(
                '${_startDate.day}/${_startDate.month}/${_startDate.year}',
              ),
              leading: Icon(Icons.calendar_today),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey),
              ),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _startDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (date != null) {
                  setState(() {
                    _startDate = date;
                  });
                }
              },
            ),
            SizedBox(height: 32),

            // Bouton enregistrer
            FilledButton.icon(
              onPressed: _saveSubscription,
              icon: Icon(Icons.save),
              label: Text('Enregistrer'),
              style: FilledButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCycleLabel(BillingCycle cycle) {
    switch (cycle) {
      case BillingCycle.weekly:
        return 'Hebdomadaire';
      case BillingCycle.monthly:
        return 'Mensuel';
      case BillingCycle.yearly:
        return 'Annuel';
    }
  }

  Future<void> _saveSubscription() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

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

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Abonnement ajouté avec succès'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}