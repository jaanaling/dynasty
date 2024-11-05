import 'package:dynasty_dive/ui_kit/app_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(children: [
      AppTile(title: "title"),
      AppTile(title: "title", subtitle: Text("subtitle"),),
      AppTile(title: "title", subtitle: Text("subtitle"), trailing: Icon(Icons.add, size: 30),),
    ],);
  }
}