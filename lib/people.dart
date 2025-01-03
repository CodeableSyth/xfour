import 'package:flutter/material.dart';

class People {
  People({required this.people, this.color = Colors.red, required this.onPress});
  List<String> people;
  Color? color;
  final Function onPress;

  List<Card> cardGenerator({required double cardWidth, double cardHeight = 50}) {
    List<Card> returnItem = [];
    for (String person in people) {
      returnItem.add(
        Card(
          //child: SizedBox(width: cardWidth, height: cardHeight,
          child: ListTile(
            title: Text(person, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold,), textAlign: TextAlign.center),
            trailing: const SizedBox(width: 50,),
            leading: const Icon(Icons.person, size: 50,),
            tileColor: color,
            onTap: () {
              onPress();
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          //),
        )
      );
    }
    return returnItem;
  }
}