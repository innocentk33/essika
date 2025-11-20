import 'package:essika/core/const/app_routes.dart';
import 'package:essika/navigation/app_navigation.dart';
import 'package:essika/providers/category_provider.dart';
import 'package:essika/providers/renewal_event_provider.dart';
import 'package:essika/providers/service_template.dart';
import 'package:essika/providers/settings_provider.dart';
import 'package:essika/providers/subscription_provider.dart';
import 'package:essika/screens/home/home_screen.dart';
import 'package:essika/screens/settings/settings_screen.dart';
import 'package:essika/screens/settings/manage_services_screen.dart';
import 'package:essika/screens/subscriptions/add_subscription_screen.dart';
import 'package:essika/screens/subscriptions/detail_subscription_screen.dart';
import 'package:essika/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:essika/core/themes/theme_essika.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarService.initDatabase();
  await initializeDateFormatting('fr', null);
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => IsarService.instance),
        ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ServiceTemplateProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => RenewalEventProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Essika',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: AppRoutes.initial,
      routes: {
        '/': (context) => AppNavigation(),
        '/home': (context) => const HomeScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/add-subscription': (context) => const AddSubscriptionScreen(),
        '/manage-services': (context) => const ManageServicesScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.subscriptionDetail) {
          final args = settings.arguments as Map<String, dynamic>;
          final subscriptionId = args['id'] as int;
          return MaterialPageRoute(
            builder: (context) => DetailSubscriptionScreen(
              subscriptionId: subscriptionId,
            ),
          );
        }
        return null;
      },
    );
  }
}
