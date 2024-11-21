import 'package:flutter/material.dart';

class NavigationWidget extends StatefulWidget {
  const NavigationWidget(this.onItemTapped, {super.key});
  final Function onItemTapped;
  @override
  State<NavigationWidget> createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      selectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary,),
      unselectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.outline,),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: "Game Map",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money),
          label: "Diplomacy",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: "Production",
        )
      ],
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
        widget.onItemTapped(_currentIndex);
      },
    );
  }
}






