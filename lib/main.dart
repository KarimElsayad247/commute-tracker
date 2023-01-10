import 'dart:async';

import 'package:commute_tracker/components/type_selector.dart';
import 'package:commute_tracker/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import 'components/type_selector.dart';
import 'controllers/commute_routes_controller.dart';
import 'screens/commute_routes_widget.dart';
import 'utils/styles.dart';

final commuteRoutesProvider = ChangeNotifierProvider<CommuteRoutesController>((ref) {
  return CommuteRoutesController();
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
    notificationIcon: AndroidResource(name: 'background_icon', defType: 'drawable'),
  );
  bool success = await FlutterBackground.initialize(androidConfig: androidConfig);

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
  Duration duration = const Duration();

  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 10), (_) => addTime());
  }

  void stopTimer() {
    timer?.cancel();
  }

  void addTime() {
    const millisecondsToAdd = 10;
    final newMilliseconds = duration.inMilliseconds + millisecondsToAdd;
    setDuration(Duration(milliseconds: newMilliseconds));
  }

  void startTracking() {
    FlutterBackground.enableBackgroundExecution();
    setState(() {
      timer = Timer.periodic(const Duration(milliseconds: 10), (_) => addTime());
      _isTracking = true;
    });
  }

  void stopTracking() {
    FlutterBackground.disableBackgroundExecution();
    print(duration.inSeconds);
    timer?.cancel();
    setState(() {
      _isTracking = false;
    });
  }

  void setDuration(Duration newDuration) {
    setState(() {
      duration = newDuration;
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
            const TypeSelector(),
            widgetSeparator(),
            buildTimerBox(),
            const Spacer(),
            _isTracking ? buildStopButton() : buildStartButton(),
            widgetSeparator(),
          ],
        ),
      ),
    );
  }

  void _pushViewRoutes() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const CommuteRoutesWidget()));
  }

  Widget buildTimerBox() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    final milliseconds = twoDigits(duration.inMilliseconds.remainder(1000) ~/ 10);

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

  SizedBox widgetSeparator() {
    return const SizedBox(height: 10);
  }
}
