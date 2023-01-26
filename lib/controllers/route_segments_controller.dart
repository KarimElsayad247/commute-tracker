import 'package:commute_tracker/controllers/base_controller.dart';
import 'package:commute_tracker/models/models.dart';
import 'package:drift/drift.dart';

class RouteSegmentsController
    extends BaseController<$RouteSegmentsTable, RouteSegment> {
  @override
  TableInfo<$RouteSegmentsTable, RouteSegment> get table => db.routeSegments;
  

}
