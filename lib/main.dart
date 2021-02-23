import 'package:cubetrainer/model/scrambler.dart';
import 'package:cubetrainer/model/settings.dart';
import 'package:cubetrainer/model/inMemorySolveHistoryImpl.dart';
import 'package:cubetrainer/model/solveHistory.dart';
import 'package:cubetrainer/model/timerState.dart';
import 'package:cubetrainer/screens/timerScreen.dart';
import 'package:cubetrainer/widgets/settingsWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // Future<int> initialize() async {
  //   await Future.delayed(Duration(seconds: 2));
  //   return 5;
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cube Timer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          builder: (context, snapshot) {
            // if (snapshot.hasError) {
            //   return Center(
            //       child: Text("Something went wrong. Please reload :/"));
            // }

            // if (snapshot.connectionState == ConnectionState.done) {
            //   return MyHomePage(title: 'Cube Timer');
            // }
            if (snapshot.data != null) {
              return MyHomePage(title: 'Cube Timer');
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
          future: _initialization,
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SolveState()),
        ChangeNotifierProvider(create: (context) => Scrambler()),
        Provider(create: (context) => Settings()),
        ChangeNotifierProvider<SolveHistoryInterface>(
            create: (_) => InMemorySolveHistoryImpl()),
      ],
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: TimerScreen(),
        drawer: Drawer(
          child: SettingsWidget(),
        ),
      ),
    );
  }
}
