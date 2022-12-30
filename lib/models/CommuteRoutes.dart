import 'CommuteRoute.dart';

class CommuteRoutes {
  static final _routesList = <int, CommuteRoute>{};

  static create({required title, description}) {
    _routesList.addAll({_routesList.length: CommuteRoute(title: title, description: description)});
  }

  static Map<int, CommuteRoute> all() {
    return Map.unmodifiable(_routesList);
  }

  static CommuteRoute? get(int id) {
    return _routesList[id];
  }
}