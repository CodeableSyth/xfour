import 'package:flutter/material.dart';

class GameMapPage extends StatefulWidget {
  const GameMapPage({super.key});

  @override
  State<GameMapPage> createState() => _GameMapPageState();
}

class _GameMapPageState extends State<GameMapPage> {
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// width: double.infinity,
// height: double.infinity,
// child: Container(
//   decoration: const BoxDecoration(
//     gradient: LinearGradient(
//       begin: Alignment.topLeft,
//       end: Alignment(0.8, 1),
//       colors: <Color>[
//         Color(0xff1f005c),
//         Color(0xff5b0060),
//         Color(0xff870160),
//         Color(0xffac255e),
//         Color(0xffca485c),
//         Color(0xffe16b5c),
//         Color(0xfff39060),
//         Color(0xffffb56b),
//       ], // Gradient from https://learnui.design/tools/gradient-generator.html
//       tileMode: TileMode.mirror,
//     ),
//   ),
//   child: const Text(
//     'Index 0: GameMap',
//     style: optionStyle,
//   ),
// ),