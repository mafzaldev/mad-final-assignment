import 'package:flutter/material.dart';
import 'package:mad_combined_tasks/widgets/custom_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Home Page", actions: []),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
