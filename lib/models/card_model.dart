import 'package:flutter/material.dart';

class CardModel {
  const CardModel({required this.title, required this.icon});
  final String title;
  final IconData icon;
}

const List<CardModel> cards = <CardModel>[
  CardModel(title: 'Camera', icon: Icons.camera_alt),
  CardModel(title: 'Setting', icon: Icons.settings),
  CardModel(title: 'Map', icon: Icons.map),
  CardModel(title: 'Contact', icon: Icons.contacts),
  CardModel(title: 'WiFi', icon: Icons.wifi),
  CardModel(title: 'Phone', icon: Icons.phone),
  CardModel(title: 'Album', icon: Icons.photo_album),
  CardModel(title: 'Home', icon: Icons.home),
  CardModel(title: 'Email', icon: Icons.email),
];
