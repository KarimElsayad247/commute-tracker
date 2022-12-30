import 'package:flutter/cupertino.dart';

import 'CommuteRoute.dart';

class CommuteRoutes extends ChangeNotifier {
  static final _routesList = <int, CommuteRoute>{};

  create({required title, description}) {
    _routesList.addAll({_routesList.length: CommuteRoute(title: title, description: description)});
    notifyListeners();
  }

  Map<int, CommuteRoute> all() {
    return Map.unmodifiable(_routesList);
  }

  CommuteRoute? get(int id) {
    return _routesList[id];
  }
}