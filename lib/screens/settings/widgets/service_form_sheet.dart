import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/service_template.dart';
import '../../../providers/category_provider.dart';
import '../../../core/enum/billing_cycle.dart';

class ServiceFormSheet extends StatefulWidget {
  final ServiceTemplate? service;
  final ValueChanged<ServiceTemplate> onSaved;

  const ServiceFormSheet({
    super.key,
    this.service,
    required this.onSaved,
  });

  @override
  State<ServiceFormSheet> createState() => _ServiceFormSheetState();
}

class _ServiceFormSheetState extends State<ServiceFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  BillingCycle _selectedCycle = BillingCycle.monthly;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    final s = widget.service;
    _nameController = TextEditingController(text: s?.name ?? '');
    _priceController = TextEditingController(
        text: s?.suggestedPrice?.toStringAsFixed(2) ?? '');
    _selectedCycle = s?.suggestedCycle ?? BillingCycle.monthly;
    _selectedCategory = s?.category;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = context.watch<CategoryProvider>().getCategoryNames();
    final isEdit = widget.service != null;

    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    isEdit ? 'Modifier le service' : 'Ajouter un service',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Name
                  TextFormField(
                    controller: _nameController,
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Nom requis' : null,
                    decoration: InputDecoration(
                      labelText: 'Nom du service',
                      hintText: 'Ex: Netflix',
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Price
                  TextFormField(
                    controller: _priceController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return null; // prix optionnel
                      final n = double.tryParse(v.replaceAll(',', '.'));
                      return n == null ? 'Prix invalide' : null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Prix',
                      prefixText: '€ ',
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Cycle toggle
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedCycle = BillingCycle.monthly),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _selectedCycle == BillingCycle.monthly ? const Color(0xFF8F4CFF) : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: Text(
                                'Mensuel',
                                style: TextStyle(
                                  color: _selectedCycle == BillingCycle.monthly ? Colors.white : Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedCycle = BillingCycle.yearly),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _selectedCycle == BillingCycle.yearly ? const Color(0xFF8F4CFF) : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: Text(
                                'Annuel',
                                style: TextStyle(
                                  color: _selectedCycle == BillingCycle.yearly ? Colors.white : Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Category dropdown
                  DropdownButtonFormField<String>(
                    initialValue: _selectedCategory,
                    decoration: InputDecoration(
                      labelText: 'Catégorie',
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('Aucune')),
                      ...categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                    ],
                    onChanged: (v) => setState(() => _selectedCategory = v),
                  ),

                  const SizedBox(height: 18),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8F4CFF),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                    ),
                    onPressed: _save,
                    child: Text(isEdit ? 'Enregistrer' : 'Ajouter le service', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final priceText = _priceController.text.trim();
    final price = priceText.isEmpty ? null : double.tryParse(priceText.replaceAll(',', '.'));

    final service = widget.service ?? ServiceTemplate();
    service
      ..name = name
      ..suggestedPrice = price
      ..suggestedCycle = _selectedCycle
      ..category = _selectedCategory;

    widget.onSaved(service);
  }
}
