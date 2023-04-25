import 'package:flutter/material.dart';
import 'package:mad_combined_tasks/pages/login_page.dart';
import 'package:mad_combined_tasks/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mad_combined_tasks/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
