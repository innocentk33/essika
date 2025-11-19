import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/service_template.dart';
import '../../../providers/service_template.dart';
import '../../../core/enum/billing_cycle.dart';

class ManageServicesScreen extends StatefulWidget {
  const ManageServicesScreen({super.key});

  @override
  State<ManageServicesScreen> createState() => _ManageServicesScreenState();
}

class _ManageServicesScreenState extends State<ManageServicesScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ServiceTemplateProvider>();
    final services = _searchQuery.isEmpty
        ? provider.services
        : provider.services
            .where((s) =>
                s.name.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F2FF),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: _showAddDialog, icon: const Icon(Icons.add)),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: const Color(0xFF8F4CFF),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Gérer les services',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Barre de recherche
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
              decoration: InputDecoration(
                hintText: 'Rechercher un service...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),

          // Liste des services
          Expanded(
            child: services.isEmpty
                ? const Center(
                    child: Text(
                      'Aucun service trouvé',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      final service = services[index];
                      return _ServiceCard(
                        service: service,
                        onEdit: () => _showEditDialog(service),
                        onDelete: () => _confirmDelete(service),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showAddDialog() {
    _showServiceDialog(null);
  }

  void _showEditDialog(ServiceTemplate service) {
    _showServiceDialog(service);
  }

  void _showServiceDialog(ServiceTemplate? service) {
    final isEdit = service != null;
    final nameController = TextEditingController(text: service?.name ?? '');
    final priceController = TextEditingController(
      text: service?.suggestedPrice?.toString() ?? '',
    );
    final categoryController =
        TextEditingController(text: service?.category ?? '');
    BillingCycle selectedCycle = service?.suggestedCycle ?? BillingCycle.monthly;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text(isEdit ? 'Modifier le service' : 'Nouveau service'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nom du service',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: priceController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Prix suggéré',
                    border: OutlineInputBorder(),
                    suffixText: '€',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(
                    labelText: 'Catégorie',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<BillingCycle>(
                  value: selectedCycle,
                  decoration: const InputDecoration(
                    labelText: 'Cycle suggéré',
                    border: OutlineInputBorder(),
                  ),
                  items: BillingCycle.values.map((cycle) {
                    return DropdownMenuItem(
                      value: cycle,
                      child: Text(
                        cycle == BillingCycle.monthly ? 'Mensuel' : 'Annuel',
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setDialogState(() => selectedCycle = value);
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                final name = nameController.text.trim();
                if (name.isEmpty) return;

                final price = double.tryParse(
                  priceController.text.replaceAll(',', '.'),
                );
                final category = categoryController.text.trim();

                if (isEdit) {
                  service
                    ..name = name
                    ..suggestedPrice = price
                    ..category = category.isNotEmpty ? category : null
                    ..suggestedCycle = selectedCycle;
                  context.read<ServiceTemplateProvider>().updateService(service);
                } else {
                  final newService = ServiceTemplate()
                    ..name = name
                    ..suggestedPrice = price
                    ..category = category.isNotEmpty ? category : null
                    ..suggestedCycle = selectedCycle;
                  context.read<ServiceTemplateProvider>().addCustomService(newService);
                }

                Navigator.of(ctx).pop();
              },
              child: Text(isEdit ? 'Modifier' : 'Ajouter'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(ServiceTemplate service) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Supprimer le service'),
        content: Text('Voulez-vous supprimer "${service.name}" ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              context.read<ServiceTemplateProvider>().deleteService(service.id);
              Navigator.of(ctx).pop();
            },
            child: const Text(
              'Supprimer',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final ServiceTemplate service;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _ServiceCard({
    required this.service,
    required this.onEdit,
    required this.onDelete,
  });

  Color _colorFromName(String name) {
    final hash = name.codeUnits.fold(0, (a, b) => a + b);
    final hue = (hash % 360).toDouble();
    return HSVColor.fromAHSV(1, hue, 0.45, 0.85).toColor();
  }

  String _initial(String name) =>
      (name.isNotEmpty ? name[0].toUpperCase() : '?');

  @override
  Widget build(BuildContext context) {
    final bg = _colorFromName(service.name);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: bg,
            child: Text(
              _initial(service.name),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (service.category != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    service.category!,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
                if (service.suggestedPrice != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    '${service.suggestedPrice!.toStringAsFixed(2)} €',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, size: 20),
            color: const Color(0xFF8F4CFF),
            onPressed: onEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, size: 20),
            color: Colors.red.shade400,
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

