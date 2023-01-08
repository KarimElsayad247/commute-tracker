import 'package:commute_tracker/main.dart';
import 'package:commute_tracker/models/models.dart';
import 'package:flutter/cupertino.dart';

class BaseController extends ChangeNotifier {
  Database get db => getIt<Database>();
}