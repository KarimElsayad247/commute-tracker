import 'dart:async';

import 'package:commute_tracker/controllers/base_controller.dart';
import 'package:drift/drift.dart';

import '../models/models.dart';

class CommuteRoutesController
    extends BaseController<$CommuteRoutesTable, CommuteRoute> {
  @override
  TableInfo<$CommuteRoutesTable, CommuteRoute> get table => db.commuteRoutes;

  Future<void> create({required title, description}) async {
    CommuteRoutesCompanion route = CommuteRoutesCompanion(
        title: Value(title), description: Value(description));
    db.into(db.commuteRoutes).insert(route);
    notifyListeners();
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
}
