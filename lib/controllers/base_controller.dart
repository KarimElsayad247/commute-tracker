import 'package:commute_tracker/main.dart';
import 'package:commute_tracker/models/models.dart';
import 'package:drift/drift.dart' as d;
import 'package:flutter/cupertino.dart';

abstract class BaseController<T extends d.Table, D> extends ChangeNotifier {
  Database get db => getIt<Database>();

  d.TableInfo<T, D> get table;

  Future<List<D>> all() async {
    return db.select(table).get();
  }
}
