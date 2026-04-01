
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'Services/InventoryProvider.dart';
import 'Services/Notification.dart';
import 'Services/ShiftProvider.dart';
import 'Services/firebase_config.dart';
import 'Services/notification_provider.dart' as notification_provider;
import 'homepage.dart';
import 'meal_ticket_provider.dart';


// Initialize Flutter Local Notifications
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await FirebaseConfig.initialize();

  // Android Initialization Settings
  const AndroidInitializationSettings androidInitializationSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
  InitializationSettings(android: androidInitializationSettings);

  // Initialize Notifications
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => InventoryProvider()..initialize()), // Initialize inventory provider
          ChangeNotifierProvider(create: (context) => MealTicketProvider()), // Meal Ticket Provider
          ChangeNotifierProvider(create: (context) => ShiftProvider()),
          ChangeNotifierProvider(create: (context) => NotificationProvider()), // Old Notification Provider
          ChangeNotifierProvider(create: (context) => notification_provider.NotificationProvider()),// New Notification Provider
        ],
        child: const MyApp(),
      ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cleaners App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(), // Your existing homepage
    );
  }
}
