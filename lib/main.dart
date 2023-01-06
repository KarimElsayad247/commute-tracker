import 'package:commute_tracker/utils/DatabaseProvider.dart';
import 'package:commute_tracker/components/TypeSelector.dart';
import 'package:commute_tracker/models/CommuteRoutesWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as Path;
import 'package:sqflite/sqflite.dart';
import 'utils/Styles.dart';
import 'components/TypeSelector.dart';
import 'components/TimerWidget.dart';
import 'models/CommuteRoutes.dart';

final commuteRoutesProvider = ChangeNotifierProvider<CommuteRoutes>((ref) {
  return CommuteRoutes();
});

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();

  const androidConfig = FlutterBackgroundAndroidConfig(
    notificationTitle: "Commute Tracker",
    notificationText: "The app is currently tracking the time.",
    notificationImportance: AndroidNotificationImportance.Default,
    // Default is ic_launcher from folder mipmap
    notificationIcon: AndroidResource(name: 'background_icon', defType: 'drawable'),
  );
  bool success = await FlutterBackground.initialize(androidConfig: androidConfig);

  runApp(ProviderScope(
    child: const MyApp(),
  ));
}

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
    FlutterBackground.enableBackgroundExecution();
    setState(() {
      _isTracking = true;
    });
  }

  void stopTracking() {
    FlutterBackground.disableBackgroundExecution();
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
