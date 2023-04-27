// ignore_for_file: use_build_context_synchronously

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:mad_combined_tasks/pages/login_page.dart';
import 'package:mad_combined_tasks/providers/counter_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mad_combined_tasks/providers/theme_provider.dart';
import 'package:mad_combined_tasks/services/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: "mad_channel",
            channelName: "mad_notifications",
            channelDescription: "Notification channel for MAD Final Assignment")
      ],
      debug: true);
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) {
            return themeChangeProvider;
          }),
          ChangeNotifierProvider(
            create: (_) => CounterProvider(),
          ),
        ],
        child: Consumer<DarkThemeProvider>(
          builder: (context, value, child) {
            return MaterialApp(
              title: 'MAD Combined Tasks',
              theme: Styles.themeData(themeChangeProvider.darkTheme, context),
              debugShowCheckedModeBanner: false,
              debugShowMaterialGrid: false,
              home: const LoginPage(),
            );
          },
        ));
  }
}
