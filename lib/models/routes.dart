import 'route.dart';

class Routes {
  static final _routesList = <Route>[];

  static create({required title, description}) {
    _routesList.add(Route(title: title, description: description));
  }

  static Iterable<Route> all() {
    return List.unmodifiable(_routesList);
  }

  static Route get(int id) {
    return _routesList[id];
  }
}