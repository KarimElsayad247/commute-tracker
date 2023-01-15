import 'dart:async';

import 'package:commute_tracker/controllers/base_controller.dart';
import 'package:commute_tracker/main.dart';
import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import '../models/models.dart';

class CommuteRoutesController extends BaseController {
  static const String tableName = 'routes';

  Future<void> create({required title, description}) async {
    CommuteRoutesCompanion route = CommuteRoutesCompanion(
        title: Value(title), description: Value(description));
    db.into(db.commuteRoutes).insert(route);
    notifyListeners();
  }

  Future<List<CommuteRoute>> all() async {
    return db.select(db.commuteRoutes).get();
  }

  Future<CommuteRoute?> get(int id) async {
    final query = db.select(db.commuteRoutes)
      ..where((route) => route.id.equals(id));
    return query.getSingle();
  }

  Future<void> updateRoute(int id, String title, String description) async {
    CommuteRoute route =
        CommuteRoute(id: id, title: title, description: description);
    db.update(db.commuteRoutes).replace(route);
    notifyListeners();
  }

  Future<void> deleteRoute(int id) async {
    final deleteQuery = db.delete(db.commuteRoutes)
      ..where((route) => route.id.equals(id));
    deleteQuery.go();
    notifyListeners();
  }

  Future<void> addSegmentToRoute(routeId, segmentDescription) async {
    RouteSegmentsCompanion segment = RouteSegmentsCompanion(
      description: Value(segmentDescription),
      route: Value(routeId),
    );
    db.into(db.routeSegments).insert(segment);
    notifyListeners();
  }

  CommuteRoute fromMap(Map<String, dynamic> map) {
    return CommuteRoute(
        id: map['id'], title: map['title'], description: map['description']);
  }
}
