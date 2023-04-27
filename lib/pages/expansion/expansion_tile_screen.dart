import 'package:flutter/material.dart';

class ExpansionTileScreen extends StatefulWidget {
  @override
  _ExpansionTileScreenState createState() => _ExpansionTileScreenState();
}

class _ExpansionTileScreenState extends State<ExpansionTileScreen> {
  final List<String> _fruitList = [
    'Apple',
    'Banana',
    'Orange',
    'Mango',
    'Grapes',
    'Pineapple',
    'Watermelon',
    'Strawberry',
    'Cherry',
    'Peach',
    'Pear',
  ];
  final List<String> _vegetableList = [
    'Carrot',
    'Potato',
    'Tomato',
    'Onion',
    'Garlic',
    'Ginger',
    'Cucumber',
    'Broccoli',
    'Cabbage',
    'Spinach',
    'Lettuce',
    'Pumpkin',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ExpansionTile(
                title: const Text('Fruits'),
                leading: const Icon(Icons.food_bank),
                children: _fruitList.map<Widget>((fruit) {
                  return ListTile(
                    title: Text(fruit),
                  );
                }).toList(),
              ),
              ExpansionTile(
                title: const Text('Vegetables'),
                leading: const Icon(Icons.food_bank),
                children: _vegetableList.map<Widget>((vegetable) {
                  return ListTile(
                    title: Text(vegetable),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
