import 'package:cubetrainer/scrambleWidget.dart';
import 'package:cubetrainer/scrambler.dart';
import 'package:cubetrainer/timer.dart';
import 'package:cubetrainer/timerState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cube Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Cube Timer'),
    );
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => SolveState()),
            ChangeNotifierProvider(create: (context) => ScrambleGenerator())
          ],
          builder: (context, _) => Column(
            children: [
              ScrambleWidget(),
              TimerWidget(),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}
