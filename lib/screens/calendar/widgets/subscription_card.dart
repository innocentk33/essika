import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/renewal_event.dart';

class SubscriptionCard extends StatelessWidget {
  final RenewalEvent event;
  final String serviceName;

  const SubscriptionCard({
    super.key,
    required this.event,
    required this.serviceName,
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
    final logoColor = _colorFromName(serviceName);
    final dateFormat = DateFormat('d MMM yyyy', 'fr_FR');

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0x08000000),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 14,right: 14,top: 12),
        child: Column(
          spacing: 6,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo en haut à gauche
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: logoColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  _initial(serviceName),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),

            // Nom du service
            Text(
              serviceName,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            // Montant
            Text(
              '${event.amount.toStringAsFixed(2)} €',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF8F4CFF),
              ),
            ),

            // Date de paiement
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    dateFormat.format(event.renewalDate),
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

