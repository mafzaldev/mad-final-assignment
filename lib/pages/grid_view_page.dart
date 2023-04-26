import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:mad_combined_tasks/models/card_model.dart';
import 'package:mad_combined_tasks/widgets/custom_app_bar.dart';

class GridViewPage extends StatefulWidget {
  const GridViewPage({super.key});

  @override
  State<GridViewPage> createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  triggerNotification(String title, String body, int notificationId) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: notificationId,
            channelKey: 'mad_channel',
            title: title,
            body: body));
  }

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
                child: GridCard(
                    card: cards[index],
                    onTap: (String title, String body) {
                      triggerNotification(title, body, index);
                    }),
              );
            })));
  }
}

class GridCard extends StatelessWidget {
  final CardModel card;
  final Function(String title, String body) onTap;

  const GridCard({super.key, required this.card, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(card.title, 'Notification from card ${card.title}'),
      child: Card(
          color: Colors.blueGrey[900],
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Icon(card.icon, size: 50.0, color: Colors.white)),
                ]),
          )),
    );
  }
}
