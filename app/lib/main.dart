import 'package:app/core/services/background_services.dart';
import 'package:app/core/utils/notification.dart';
import 'package:app/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import "package:permission_handler/permission_handler.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();

  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }

  initializeBackgroundService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soil Moisture Monitor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
