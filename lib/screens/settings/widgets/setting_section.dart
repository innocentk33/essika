import 'package:flutter/material.dart';

class SettingSection extends StatelessWidget {
  final List<Widget> children;

  const SettingSection({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: _buildChildrenWithDividers(),
      ),
    );
  }

  List<Widget> _buildChildrenWithDividers() {
    final List<Widget> widgets = [];

    for (int i = 0; i < children.length; i++) {
      widgets.add(children[i]);

      // Ajoute un divider entre les éléments (mais pas après le dernier)
      if (i < children.length - 1) {
        widgets.add(
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFF0F0F0),
            ),
          ),
        );
      }
    }

    return widgets;
  }
}

