import 'package:flutter/material.dart';
import 'package:fourxgame/people.dart';


class DiplomacyPage extends StatefulWidget {
  const DiplomacyPage(this.metPeople, this.currentPeople, {super.key});

  final People metPeople;
  final Function currentPeople;


  @override
  State<DiplomacyPage> createState() => _DiplomacyPageState();
}

class _DiplomacyPageState extends State<DiplomacyPage> {
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  String explanationText = "";


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    widget.metPeople.color = Theme.of(context).cardTheme.color;
    List<Card> peopleCards = [];

    if (widget.metPeople.people.isEmpty) {
      explanationText = "This is were (if you've met anyone inside of the game) you can make trade deals, wage war, and otherwise communicate with other players who play the game.";
    } else {
      explanationText = "";
    }
    for (String person in widget.metPeople.people) {
      peopleCards = widget.metPeople.cardGenerator(cardWidth: width*0.9);
    }
    return Scaffold(body:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(child: Text("Diplomacy", style: optionStyle,)),
            Text(explanationText, textAlign: TextAlign.center,),
            const Divider(height: 10),
            Expanded(child:
              ListView(
                children: peopleCards,
                //physics: ScrollPhysics(parent: Scro),
              ),
            )

          ],
        ),
      ),
    );
  }
}
