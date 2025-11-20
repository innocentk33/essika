import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/settings_provider.dart';
import 'widgets/setting_tile.dart';
import 'widgets/setting_switch_tile.dart';
import 'widgets/setting_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();

    return  SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          // Header
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text(
              'Paramètres',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Section Gestion
          SettingSection(
            children: [
              SettingTile(
                icon: Icons.apps_outlined,
                title: 'Gérer les services',
                onTap: () {
                  Navigator.pushNamed(context, '/manage-services');
                },
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Section Préférences
          SettingSection(
            children: [
              SettingSwitchTile(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                value: settingsProvider.notificationsEnabled,
                onChanged: (_) {
                  settingsProvider.toggleNotifications();
                },
              ),
              SettingSwitchTile(
                icon: Icons.dark_mode_outlined,
                title: 'Mode claire/sombre',
                value: settingsProvider.isDarkMode,
                onChanged: (_) {
                  settingsProvider.toggleDarkMode();
                },
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Section Données
          SettingSection(
            children: [
              SettingTile(
                icon: Icons.import_export_outlined,
                title: 'Import / Export',
                onTap: () {
                  Navigator.pushNamed(context, '/import-export');
                },
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Section Informations
          SettingSection(
            children: [
              SettingTile(
                icon: CupertinoIcons.info,
                title: 'A propos',
                onTap: () {
                  _showAboutDialog(context);
                },
              ),
            ],
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Essika',
      applicationVersion: '1.0.0',
      applicationIcon: const FlutterLogo(size: 48),
      children: [
        const Text('Gérez vos abonnements facilement et suivez vos dépenses mensuelles.'),
      ],
    );
  }
}
