import 'package:essika/core/const/app_routes.dart';
import 'package:essika/navigation/app_navigation.dart';
import 'package:essika/providers/category_provider.dart';
import 'package:essika/providers/service_template.dart';
import 'package:essika/providers/settings_provider.dart';
import 'package:essika/providers/subscription_provider.dart';
import 'package:essika/screens/home/home_screen.dart';
import 'package:essika/screens/subscriptions/add_subscription_screen.dart';
import 'package:essika/screens/subscriptions/detail_subscription_screen.dart';
import 'package:essika/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarService.initDatabase();
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_)=>IsarService.instance),
        ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ServiceTemplateProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Essika',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.white)),
      initialRoute: AppRoutes.initial,
      routes: {
        '/': (context) => AppNavigation(),
        '/home': (context) => const HomeScreen(),
        '/add-subscription': (context) => const AddSubscriptionScreen(),
        '/subscription-detail': (context) => const DetailSubscriptionScreen(),
      },
    );
  }
}
