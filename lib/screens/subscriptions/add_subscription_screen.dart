// dart
import 'package:flutter/material.dart';
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

  Color _colorFromName(String name) {
    final hash = name.codeUnits.fold(0, (a, b) => a + b);
    final hue = (hash % 360).toDouble();
    return HSVColor.fromAHSV(1, hue, 0.45, 0.85).toColor();
  }

  String _initial(String name) => (name.isNotEmpty ? name[0].toUpperCase() : '?');

  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.watch<CategoryProvider>();
    final serviceProvider = context.watch<ServiceTemplateProvider>();

    // si la catégorie par défaut est disponible dans le provider, l'utiliser
    _selectedCategory = _selectedCategory.isEmpty
        ? (categoryProvider.getCategoryNames().isNotEmpty ? categoryProvider.getCategoryNames().first : 'Autres')
        : _selectedCategory;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Nouvel abonnement')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // 1) Barre de recherche (autocomplete) - premier élément
            Autocomplete<ServiceTemplate>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) return const Iterable<ServiceTemplate>.empty();
                return serviceProvider.services.where((s) =>
                    s.name.toLowerCase().contains(textEditingValue.text.toLowerCase()));
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
                  decoration: InputDecoration(
                    hintText: 'Rechercher un service (ex: Netflix)',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  ),
                  onChanged: (v) => _serviceController.text = v,
                );
              },
            ),

            SizedBox(height: 12),

            // 2) Services suggérés horizontaux
            SizedBox(
              height: 110,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: serviceProvider.popularServices.length,
                separatorBuilder: (_, _) => SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final svc = serviceProvider.popularServices[index];
                  final isSelected = _selectedTemplate?.id == svc.id;
                  final bg = _colorFromName(svc.name);
                  return InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      setState(() {
                        _selectedTemplate = svc;
                        _serviceController.text = svc.name;
                        _priceController.text = svc.suggestedPrice?.toString() ?? '';
                        _selectedCycle = svc.suggestedCycle;
                        _selectedCategory = svc.category ?? _selectedCategory;
                      });
                    },
                    child: Container(
                      width: 88,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue.shade50 : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: isSelected ? Border.all(color: Colors.blue, width: 1.5) : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: bg,
                            child: Text(_initial(svc.name), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(height: 8),
                          Flexible(
                            child: Text(
                              svc.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 16),

            // 3) Formulaire simple
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Nom
                  TextFormField(
                    controller: _serviceController,
                    decoration: InputDecoration(
                      labelText: 'Nom du service',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.business),
                    ),
                    validator: (v) => (v == null || v.isEmpty) ? 'Veuillez entrer un nom' : null,
                  ),
                  SizedBox(height: 12),

                  // Prix
                  TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(
                      labelText: 'Prix',
                      suffixText: '€',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.euro),
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Veuillez entrer un prix';
                      if (double.tryParse(value.replaceAll(',', '.')) == null) return 'Prix invalide';
                      return null;
                    },
                  ),
                  SizedBox(height: 12),

                  // Catégorie affichée non modifiable
                  TextFormField(
                    initialValue: _selectedCategory,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Catégorie',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.category),
                      suffixIcon: Icon(Icons.lock, size: 18),
                    ),
                  ),
                  SizedBox(height: 12),

                  // Récurrence (ChoiceChip)
                  Text('Fréquence', style: Theme.of(context).textTheme.bodyMedium),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: BillingCycle.values.map((cycle) {
                      final selected = cycle == _selectedCycle;
                      return ChoiceChip(
                        label: Text(_getCycleLabel(cycle)),
                        selected: selected,
                        onSelected: (on) {
                          if (on) setState(() => _selectedCycle = cycle);
                        },
                        selectedColor: Colors.blue.shade100,
                        backgroundColor: Colors.grey.shade200,
                        labelStyle: TextStyle(color: selected ? Colors.blue.shade900 : Colors.black87),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 12),

                  // Date de début
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Date de début'),
                    subtitle: Text('${_startDate.day}/${_startDate.month}/${_startDate.year}'),
                    leading: Icon(Icons.calendar_today),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: Colors.grey.shade300)),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _startDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (date != null) setState(() => _startDate = date);
                    },
                  ),

                  SizedBox(height: 20),

                  FilledButton.icon(
                    onPressed: _saveSubscription,
                    icon: Icon(Icons.save),
                    label: Text('Enregistrer'),
                    style: FilledButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 14)),
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

    // Demander au provider des renewal events de rafraîchir (Isar watch ou notifyListeners gérera)
    try {
      await context.read<RenewalEventProvider>().refresh();
    } catch (_) {}

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Abonnement ajouté'), backgroundColor: Colors.green),
      );
    }
  }
}
