import 'package:flutter/material.dart';
import 'package:mad_combined_tasks/models/card_model.dart';
import 'package:mad_combined_tasks/widgets/custom_app_bar.dart';

class GridViewPage extends StatelessWidget {
  const GridViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: 'Grid View',
          actions: [],
        ),
        body: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 8.0,
            children: List.generate(cards.length, (index) {
              return Center(
                child: GridCard(card: cards[index]),
              );
            })));
  }
}

class GridCard extends StatelessWidget {
  const GridCard({super.key, required this.card});
  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.blueGrey[900],
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Icon(card.icon, size: 50.0, color: Colors.white)),
                Text(
                  card.title,
                )
              ]),
        ));
  }
}
