import 'package:flutter/material.dart';
import 'package:mad_combined_tasks/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:mad_combined_tasks/pages/firebase_crud/firebase_index.dart';
import 'package:mad_combined_tasks/widgets/custom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              child: CircleAvatar(
                foregroundImage: NetworkImage(
                  "https://avatars.githubusercontent.com/u/78255759?v=4",
                  scale: .8,
                ),
              ),
            ),
            ListTile(
              title: const Text('Home Page'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Firebase CRUD'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FirebaseIndex()));
              },
            ),
            ListTile(
              title: const Text('Settings Page'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: const CustomAppBar(title: "Home Page", actions: []),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Click this switch to change theme:',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Switch(
                    value: themeProvider.darkTheme,
                    onChanged: (bool value) {
                      themeProvider.darkTheme = value;
                    })
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Open Drawer to see all the tasks completed in this app!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
