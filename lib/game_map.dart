import 'dart:convert';
import 'package:flutter/material.dart';
import 'point.dart';



class GameMapPage extends StatefulWidget {
  const GameMapPage(this.updateFunction, {super.key, required this.pointMap, });

  final Map<String, Point> pointMap;
  final Function updateFunction;

  @override
  State<GameMapPage> createState() => _GameMapPageState();
}

class _GameMapPageState extends State<GameMapPage> {
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    debugPrint(widget.pointMap.toString());
  }

  @override
  Widget build(BuildContext context) {
    widget.updateFunction();
    List<Widget> pointDisplay = [];
    widget.pointMap.forEach((pointName, point) {if (point.owner == "Codesyth") {pointDisplay.add(
      ListTile(title: point.displayPoint(), leading: Text(pointName, style: TextStyle(fontSize: 25),),));

    }});

    //debugPrint(pointDisplay.toString());
    //for (Point point in pointDisplay) {}


    return ListView(children: pointDisplay);
        //[widget.pointMap["point 0 0"]!.displayPoint()],
  }
}
