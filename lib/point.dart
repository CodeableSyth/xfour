import 'package:flutter/material.dart';

class Point {
  int height;
  int column;
  double size;
  String? owner;
  List<String> adjacency;
  int baseLevel; // 0 is unclaimed, 1 is claimed and requires owner, 2 is the same as below but with a shipyard built, and 3 is a garrison, also needs the requirements of 1

  Point({required this.size, required this.height, required this.column, this.owner, this.baseLevel = 0, this.adjacency = const ["Left","Right","Up","Down"]});

  Widget displayPoint () {
    Icon? baseIcon;
    if (baseLevel == 0) {
      baseIcon = const Icon(Icons.circle_outlined);
    } else if (baseLevel == 1 || owner != null) {
      baseIcon = const Icon(Icons.circle);
    } else if (baseLevel == 2 || owner != null) {
      baseIcon = const Icon(Icons.add_circle);
    } else if (baseLevel == 3 || owner != null) {
      baseIcon = const Icon(Icons.indeterminate_check_box);
    } else {
      baseLevel = 0;
    }
    return SizedBox(
      width: size,
      height: size,
      child: IconButton(onPressed: () {}, icon: baseIcon!, iconSize: size,),
    );
  }
}