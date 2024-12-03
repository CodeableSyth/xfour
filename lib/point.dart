import 'package:flutter/material.dart';
import 'main.dart';

class Point {
  Map<String,int> pointLocation;
  double size;
  String? owner;
  Map<String, bool> adjacency;
  int baseLevel; // 0 is unclaimed, 1 is claimed and requires owner, 2 is the same as below but with a shipyard built, and 3 is a garrison, also needs the requirements of 1
  Function onPress;

  Point({required this.onPress, required this.size, required this.pointLocation, required this.owner, required this.adjacency, this.baseLevel = 0,});

  @override
  String toString() {
    return("{coordinates: $pointLocation, owner: $owner, adjacent: $adjacency, base level: $baseLevel}");
  }

  Widget displayPoint() {
    Icon? baseIcon;
    if (baseLevel == 0) {
      baseIcon = const Icon(Icons.circle_outlined);
    } else if (baseLevel == 1) {
      baseIcon = const Icon(Icons.circle);
    } else if (baseLevel == 2) {
      baseIcon = const Icon(Icons.add_circle);
    } else if (baseLevel == 3) {
      baseIcon = const Icon(Icons.indeterminate_check_box);
    }
    return IconButton(
      onPressed: () {
        //debugPrint();
        onPress(adjacency, pointLocation);
      },
      icon: baseIcon!,
      iconSize: size,
    );
  }
}
