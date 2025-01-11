import 'package:flutter/material.dart';

Widget buildDashboardItem(DashboardItem item) {
  return Material(
    elevation: 1,
    color: item.color,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
    ),
    child: InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        item.icon,
        color: Colors.white,
      ),
    ),
  );
}


class DashboardItem {
  final String title;
  final String icon;
  final Color color;
  final Function() onTap;

  DashboardItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}