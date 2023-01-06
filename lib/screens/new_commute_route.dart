import 'package:commute_tracker/models/commute_route.dart';
import 'package:flutter/material.dart';

import 'new_commute_route_form.dart';

class NewCommuteRoute extends StatelessWidget {
  const NewCommuteRoute({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    CommuteRoute newRoute = CommuteRoute(title: '');
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Route"),
      ),
      body: NewCommuteRouteForm(route: newRoute),
    );
  }
}