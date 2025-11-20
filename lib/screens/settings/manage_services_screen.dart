import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/service_template.dart';
import '../../../providers/service_template.dart';
import 'package:essika/screens/settings/widgets/service_form_sheet.dart';

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
          IconButton(onPressed: _showAddSheet, icon: const Icon(Icons.add)),
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
                        onEdit: () => _showEditSheet(service),
                        onDelete: () => _confirmDelete(service),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showAddSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => ServiceFormSheet(
        onSaved: (service) {
          context.read<ServiceTemplateProvider>().addCustomService(service);
          Navigator.of(ctx).pop();
        },
      ),
    );
  }

  void _showEditSheet(ServiceTemplate service) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => ServiceFormSheet(
        service: service,
        onSaved: (updated) {
          // met à jour en place
          service
            ..name = updated.name
            ..suggestedPrice = updated.suggestedPrice
            ..category = updated.category
            ..suggestedCycle = updated.suggestedCycle;
          context.read<ServiceTemplateProvider>().updateService(service);
          Navigator.of(ctx).pop();
        },
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          _ServiceLogo(service: service),
          const SizedBox(width: 14),
          Expanded(
            child: _ServiceInfo(service: service),
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

class _ServiceLogo extends StatelessWidget {
  final ServiceTemplate service;

  const _ServiceLogo({required this.service});

  @override
  Widget build(BuildContext context) {
    final hasLogo = service.logoUrl != null && service.logoUrl!.isNotEmpty;

    if (hasLogo) {
      return Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.asset(
          service.logoUrl!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _InitialLogo(serviceName: service.name);
          },
        ),
      );
    }

    return _InitialLogo(serviceName: service.name);
  }
}

class _InitialLogo extends StatelessWidget {
  final String serviceName;

  const _InitialLogo({required this.serviceName});

  @override
  Widget build(BuildContext context) {
    final hash = serviceName.codeUnits.fold(0, (a, b) => a + b);
    final hue = (hash % 360).toDouble();
    final color = HSVColor.fromAHSV(1, hue, 0.45, 0.85).toColor();
    final initial = serviceName.isNotEmpty ? serviceName[0].toUpperCase() : '?';

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          initial,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class _ServiceInfo extends StatelessWidget {
  final ServiceTemplate service;

  const _ServiceInfo({required this.service});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
