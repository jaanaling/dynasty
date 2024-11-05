import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppTile extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final Widget? subtitle;
  final Widget? trailing;
  bool? generateColor;
  int? id;
  Color? color;

  AppTile({
    super.key,
    this.onTap,
    required this.title,
    this.subtitle,
    this.trailing,
    this.generateColor = false,
    this.color,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    if (color == null) {
      generateColor = true;
    }
    if (color == null && generateColor == true) {
      int index = id! % 17;
      color = Colors.primaries[index]; // Используем asciiSum как индекс
    }
    return Container(
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.99, -0.16),
          end: const Alignment(-0.99, 0.16),
          colors: [color!, color!.withOpacity(0.5)],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(21),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 17, vertical: subtitle != null ? 14 : 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    height: 0,
                  ),
                ),
                Gap(5),
                subtitle ?? Container(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 30),
            child: trailing ?? Container(),
          ),
        ],
      ),
    );
  }
}
