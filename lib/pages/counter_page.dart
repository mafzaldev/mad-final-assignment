import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mad_combined_tasks/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:mad_combined_tasks/providers/counter_provider.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    log("Whole screen rebuild");
    final countProvider = Provider.of<CounterProvider>(context, listen: false);

    return Scaffold(
      appBar: const CustomAppBar(title: "Counter using Provider", actions: []),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
              ),
              child:
                  Consumer<CounterProvider>(builder: (context, value, child) {
                log("Counter rebuild only");
                return Text(
                  value.count.toString(),
                  style: const TextStyle(fontSize: 30, color: Colors.white),
                );
              }),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
                "Click on the Floating Action Button to increase the counter, but it will not rebuild the whole screen, just because we are using Provider.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          countProvider.setCount();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
