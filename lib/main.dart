import 'package:flutter/material.dart';
import 'package:fourxgame/diplomacy.dart';
import 'package:fourxgame/game_map.dart';
import 'package:fourxgame/people.dart';
import 'package:fourxgame/production.dart';
import 'navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Four X Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            //primary: Colors.black12,
            brightness: Brightness.dark
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Four X Game'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  int _currentIndex = 0;
  void onItemTapped (int index) {
    setState(() {
      _currentIndex = index;
      debugPrint("$_currentIndex");
    });
  }

  People peopleMet = People(people: []);

  void addPerson(String person) {
    setState(() {
      peopleMet.people.add(person);
    });
  }

  final List<Widget> _widgetOptions = [];


  @override
  void initState() {
    super.initState();
    _widgetOptions.addAll([
      const GameMapPage(), //if you want them to know the _currentIndex, you can add them to the classes' constructors
      DiplomacyPage(peopleMet ,addPerson),
      const ProductionPage()
    ]);
    addPerson("Example1"); //TODO show
  }

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);


  //Widget navigationBar = NavigationWidget(onItemTapped);



  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(widget.title),
      ),
      //drawer: const NavigationWidget(),
      //bottomNavigationBar: navigationBar,
      bottomNavigationBar: NavigationWidget(onItemTapped),

      body: _widgetOptions[_currentIndex],
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       const Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headlineMedium,
      //       ),
      //       Text("Current Index: $_currentIndex"),
      //       _widgetOptions[_currentIndex],
      //     ],
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}