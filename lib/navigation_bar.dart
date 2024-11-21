import 'package:flutter/material.dart';

class NavigationWidget extends StatelessWidget {
  const NavigationWidget({super.key});
  //asdf
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: NavigationDrawer(
        //TODO remove me - just a test comment to test push
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
