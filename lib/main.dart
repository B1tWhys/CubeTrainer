import 'package:cubetrainer/model/scrambler.dart';
import 'package:cubetrainer/model/settings.dart';
import 'package:cubetrainer/model/timerState.dart';
import 'package:cubetrainer/widgets/settingsWidget.dart';
import 'package:cubetrainer/widgets/timerWidget.dart';
import 'package:cubetrainer/widgets/scrambleWidget.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SolveState()),
        ChangeNotifierProvider(create: (context) => Scrambler()),
        Provider(create: (context) => Settings())
      ],
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            children: [
              ScrambleWidget(),
              TimerWidget(),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        drawer: Drawer(
          child: SettingsWidget(),
        ),
      ),
    );
  }
}
