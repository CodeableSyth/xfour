import 'package:flutter/material.dart';

class NavigationWidget extends StatelessWidget {
  const NavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: NavigationDrawer(
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        elevation: 20,
        children: [
          SizedBox(
            height: 50,
            child: ListView(
              // shrinkWrap: true,
              children: const [ListTile(title: Text('test'),)],
            ),
          )
        ]
      ),
    );
  }
}
