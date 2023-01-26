import 'dart:async';

import 'package:commute_tracker/components/type_selector.dart';
import 'package:commute_tracker/controllers/route_segments_controller.dart';
import 'package:commute_tracker/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import 'components/type_selector.dart';
import 'controllers/commute_routes_controller.dart';
import 'screens/commute_routes_widget.dart';
import 'utils/styles.dart';

final commuteRoutesProvider =
    ChangeNotifierProvider<CommuteRoutesController>((ref) {
  return CommuteRoutesController();
});

final routeSegmentsProvider =
    ChangeNotifierProvider<RouteSegmentsController>((ref) {
  return RouteSegmentsController();
});

final getIt = GetIt.instance;

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();

  getIt.registerSingleton<Database>(Database());

  const androidConfig = FlutterBackgroundAndroidConfig(
    notificationTitle: "Commute Tracker",
    notificationText: "The app is currently tracking the time.",
    notificationImportance: AndroidNotificationImportance.Default,
    // Default is ic_launcher from folder mipmap
    notificationIcon:
        AndroidResource(name: 'background_icon', defType: 'drawable'),
  );
  bool success =
      await FlutterBackground.initialize(androidConfig: androidConfig);

  runApp(const ProviderScope(
    child: MyApp(),
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
  Timer? timer;
  int? startingClock;
  int? currentClock;
  List<int> checkpoints = <int>[0];
  int? selectedRouteId;

  @override
  void initState() {
    super.initState();
  }

  void addTime() {
    setState(() {
      currentClock = DateTime.now().millisecondsSinceEpoch;
    });
  }

  void startTracking() {
    if (selectedRouteId == null) {
      _showMyDialog();
      return;
    }

    FlutterBackground.enableBackgroundExecution();
    setState(() {
      timer =
          Timer.periodic(const Duration(milliseconds: 10), (_) => addTime());
      startingClock = DateTime.now().millisecondsSinceEpoch;
      currentClock = startingClock;
      _isTracking = true;
    });
  }

  void pauseTimer() {
    timer?.cancel();
    startingClock = 0;
    currentClock = 0;
    _isTracking = false;
  }

  void stopTracking() {
    FlutterBackground.disableBackgroundExecution();
    setState(() {
      checkpoints.add(currentClock! - startingClock!);
      pauseTimer();
    });
  }

  void resetTime() {
    setState(() {
      pauseTimer();
      checkpoints = [0];
    });
  }

  void assignRoute(int routeId) {
    setState(() {
      selectedRouteId = routeId;
    });
  }

  Duration _clockToDuration(int? startingClock, int? endingClock) {
    if (startingClock == null || endingClock == null) {
      return Duration.zero;
    }

    int elapsedClocksSinceLastCheckpoint = endingClock - startingClock;
    int previousCheckpointsSum =
        checkpoints.reduce((value, element) => value + element);
    int totalDurationMillis =
        elapsedClocksSinceLastCheckpoint + previousCheckpointsSum;
    return Duration(milliseconds: totalDurationMillis);
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
            TypeSelector(onRouteChange: assignRoute),
            widgetSeparator(),
            buildTimerBox(),
            const Spacer(),
            buildResetButton(),
            _isTracking ? buildStopButton() : buildStartButton(),
            widgetSeparator(),
          ],
        ),
      ),
    );
  }

  void _pushViewRoutes() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const CommuteRoutesWidget()));
  }

  Widget buildTimerBox() {
    Duration duration = _clockToDuration(startingClock, currentClock);

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    final milliseconds =
        twoDigits(duration.inMilliseconds.remainder(1000) ~/ 10);

    return Container(
      color: Styles.backgroundGray,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: Center(
        child: Text(
          '$hours : $minutes : $seconds : $milliseconds',
          style: Styles.gigaFont,
        ),
      ),
    );
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

  ElevatedButton buildResetButton() {
    return buildBigButton(resetTime, "Reset", Colors.orangeAccent);
  }

  SizedBox widgetSeparator() {
    return const SizedBox(height: 10);
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('You must select a route!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text("You can't start tracking without selecting a route."),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
