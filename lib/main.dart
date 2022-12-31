import 'package:commute_tracker/DatabaseProvider.dart';
import 'package:commute_tracker/TypeSelector.dart';
import 'package:commute_tracker/models/CommuteRoutesWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as Path;
import 'package:sqflite/sqflite.dart';
import 'Styles.dart';
import 'TypeSelector.dart';
import 'TimerWidget.dart';
import 'models/CommuteRoutes.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider(
    create: (context) => CommuteRoutes(),
    child: const MyApp(),
  ));
}

// void initDb() async {
//   // Open the database and store the reference.
//   final database = openDatabase(
//     // Set the path to the database. Note: Using the `join` function from the
//     // `path` package is best practice to ensure the path is correctly
//     // constructed for each platform.
//     Path.join(await getDatabasesPath(), 'commute_tracker.db'),
//
//     onCreate: (db, version) {
//       // Run the CREATE TABLE statement on the database.
//       return db.execute(
//         'CREATE TABLE routes(id INTEGER PRIMARY KEY AUTO, title TEXT, description TEXT)',
//       );
//     },
//
//     // Set the version. This executes the onCreate function and provides a
//     // path to perform database upgrades and downgrades.
//     version: 1,
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Commute Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isTracking = false;

  void startTracking() {
    setState(() {
      _isTracking = true;
    });
  }

  void stopTracking() {
    setState(() {
      _isTracking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: _pushViewRoutes,
            icon: const Icon(Icons.list),
            tooltip: "View and edit routes",
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            widgetSeparator(),
            TypeSelector(),
            widgetSeparator(),
            TimerWidget(active: _isTracking),
            Spacer(),
            _isTracking ? buildStopButton() : buildStartButton(),
            widgetSeparator(),
          ],
        ),
      ),
    );
  }

  void _pushViewRoutes() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CommuteRoutesWidget()));
  }

  ElevatedButton buildBigButton(
      VoidCallback callback, String text, Color backgroundColor) {
    ButtonStyle style = Styles.veryBigButton(backgroundColor);
    return ElevatedButton(style: style, onPressed: callback, child: Text(text));
  }

  ElevatedButton buildStartButton() {
    return buildBigButton(
        startTracking, "Start Tracking", Theme.of(context).primaryColor);
  }

  ElevatedButton buildStopButton() {
    return buildBigButton(stopTracking, "Stop Tracking", Colors.red);
  }

  SizedBox widgetSeparator() {
    return const SizedBox(height: 10);
  }
}
