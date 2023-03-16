import 'package:flutter/material.dart';

class CardContent {
  String title;
  String subtitle;
  IconData icon;
  VoidCallback onTap;

  CardContent({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });
}