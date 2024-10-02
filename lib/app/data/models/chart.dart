import 'package:flutter/material.dart';

class ChartData {
  final String category;
  final double percentage;
  final Color color;
  final IconData icon;

  ChartData({
    required this.category,
    required this.percentage,
    required this.color,
    required this.icon,
  });
}
