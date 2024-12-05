import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fourxgame/diplomacy.dart';
import 'package:fourxgame/game_map.dart';
import 'package:fourxgame/people.dart';
import 'package:fourxgame/point.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'navigation_bar.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final String saveData = await rootBundle.loadString("local_data/data.json");
  await prefs.setString('jsonFile', saveData);
  runApp(const MyApp());
}
final prefs = SharedPreferences.getInstance();
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

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  // int _counter = 0;

  AnimationController? controller;
  Animation<double>? animation;
  final Map<String, Point> pointMap = {};

  final List<Widget> _widgetOptions = [];
  int _currentIndex = 0;

  void onItemTapped (int index) {
    setState(() {
      _currentIndex = index;
      debugPrint("$_currentIndex");
      controller?.value = 0;
      controller?.reset();
      controller?.forward();
    });
  }

  void addPerson(String person) {
    setState(() {
      peopleMet.people.add(person);
    });
  }

  void readJson() async {
    final prefs = await SharedPreferences.getInstance();
    final String saveData = prefs.getString("jsonFile")!;
    //debugPrint("saveData is $saveData");
    Map<String, dynamic> parsedSaveData = await jsonDecode(saveData);

    //debugPrint(parsedSaveData.toString());
    setState(() {
      pointMap.clear();
      parsedSaveData.forEach((key, value) {
        //debugPrint("foreach $key $value");
        Map<String, dynamic> adjacency = value["adjacency"];
        Map<String, bool> adjacencyParsed = {};
        adjacency.forEach((direction, boolean) {adjacencyParsed[direction] = boolean;});
        Map<String, dynamic> coordinates = value["coordinates"];
        Map<String, int> coordinatesParsed = {};
        //debugPrint("coordinates: $coordinates");
        coordinates.forEach((axis, value) {coordinatesParsed[axis] = int.parse(value.toString());});
        String owner = value["owner"];
        int level = value["level"];
        pointMap[key] = Point(onPress: buttonPress,size: 50, pointLocation: coordinatesParsed, owner: owner, adjacency: adjacencyParsed, baseLevel: level);
      });
      _widgetOptions[0] = GameMapPage(readJson, pointMap: pointMap,);
      controller?.value = 0;
      controller?.reset();
      controller?.forward();
      //buttonPress(_pointMap["point 0 0"]!.adjacency, _pointMap["point 0 0"]!, _pointMap);
      //debugPrint(_pointMap.toString());
    });
  }


  void buttonPress(Map<String, bool> adjacency, Map<String, int> currentCoordinates) async {
    final prefs = await SharedPreferences.getInstance();


    for (int x = -1; x < 3; x += 2) {
      //debugPrint("point ${currentCoordinates["x"]! + x} ${currentCoordinates["y"]}");
      //pointMap["point ${currentCoordinates["x"]! + x} ${currentCoordinates["y"]}"];
      try {
        Point adjacentPoint = pointMap["point ${currentCoordinates["x"]! + x} ${currentCoordinates["y"]}"]!;
        //debugPrint(adjacentPoint.toString());
        final String saveData = prefs.getString("jsonFile")!;
        Map<String, dynamic> parsedSaveData = await jsonDecode(saveData);
        debugPrint("point ${currentCoordinates["x"]! + x} ${currentCoordinates["y"]}, current point $currentCoordinates");
        parsedSaveData["point ${currentCoordinates["x"]} ${currentCoordinates["y"]}"]["level"] =
        1;
        parsedSaveData["point ${currentCoordinates["x"]} ${currentCoordinates["y"]}"]["owner"] = "Codesyth";
        parsedSaveData["point ${currentCoordinates["x"]! + x} ${currentCoordinates["y"]}"]["owner"] = "Codesyth";
        String jsonString = jsonEncode(parsedSaveData);
        //File("local_data/data.json").writeAsString(jsonEncode(parsedSaveData));
        await prefs.setString('jsonFile', jsonString);
        //debugPrint("parsed saved data: ${parsedSaveData.toString()} jsonString:$jsonString");
        readJson();
        setState(() {
          //readJson();
        });
      }
      catch (e) {
        //debugPrint("no point in current direction, choosing new direction");
      }
    }
    for (int y = -1; y < 3; y += 2) {
      //debugPrint("point ${currentCoordinates["x"]! + x} ${currentCoordinates["y"]}");
      //pointMap["point ${currentCoordinates["x"]! + x} ${currentCoordinates["y"]}"];
      try {
        Point adjacentPoint = pointMap["point ${currentCoordinates["x"]} ${currentCoordinates["y"]! + y}"]!;
        //debugPrint(adjacentPoint.toString());
        final String saveData = prefs.getString("jsonFile")!;
        Map<String, dynamic> parsedSaveData = await jsonDecode(saveData);
        debugPrint("point ${currentCoordinates["x"]} ${currentCoordinates["y"]! + y}, current point $currentCoordinates");
        parsedSaveData["point ${currentCoordinates["x"]} ${currentCoordinates["y"]}"]["level"] =
        1;
        parsedSaveData["point ${currentCoordinates["x"]} ${currentCoordinates["y"]}"]["owner"] =
        "Codesyth";
        parsedSaveData["point ${currentCoordinates["x"]} ${currentCoordinates["y"]! +
            y}"]["owner"] = "Codesyth";
        String jsonString = jsonEncode(parsedSaveData);
        //File("local_data/data.json").writeAsString(jsonEncode(parsedSaveData));
        await prefs.setString('jsonFile', jsonString);
        //debugPrint("parsed saved data: ${parsedSaveData.toString()} jsonString:$jsonString");
        readJson();
        setState(() {
          //readJson();
        });
      }
      catch (e) {
        //debugPrint("no point in current direction, choosing new direction");
      }
    }
  }
  People peopleMet = People(people: [], onPress: () async {
    final prefs = await SharedPreferences.getInstance();
    final String saveData = await rootBundle.loadString("local_data/data.json");
    prefs.setString('jsonFile', saveData);
  },);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    controller?.forward();
    if(controller != null) {
      animation = Tween<double>(begin: 0.01, end: 1).animate(controller!)
        ..addListener(() {
          setState(() {
            // The state that has changed here is the animation object's value.
          });
        });
    }
    readJson();
    _widgetOptions.addAll([
      //const CircularProgressIndicator(),
      GameMapPage(readJson, pointMap: pointMap,), //if you want them to know the _currentIndex, you can add them to the classes' constructors
      DiplomacyPage(peopleMet ,addPerson),
      const SizedBox(
         height: double.infinity,
          width: double.infinity,
          child: Image(image: AssetImage('images/image2.png'), fit: BoxFit.cover)),
    ]);
    addPerson("Reset Map");
  }

  //const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);


  //Widget navigationBar = NavigationWidget(onItemTapped);



  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(widget.title),
      ),
      //drawer: const NavigationWidget(),
      //bottomNavigationBar: navigationBar,
      bottomNavigationBar: NavigationWidget(onItemTapped),

      body: SizedBox(
          width: _currentIndex != 0 ? (animation?.value ?? 1) * w : null,
          child: [
            //const CircularProgressIndicator(),
            GameMapPage(readJson, pointMap: pointMap,), //if you want them to know the _currentIndex, you can add them to the classes' constructors
            DiplomacyPage(peopleMet ,addPerson),
            const SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image(image: AssetImage('images/image2.png'), fit: BoxFit.cover)),
          ][_currentIndex]
      ),
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