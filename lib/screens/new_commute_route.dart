import '../models/models.dart';
import 'package:flutter/material.dart';

import '_new_commute_route_form.dart';

class NewCommuteRoute extends StatelessWidget {
  const NewCommuteRoute({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("New Route"),
      ),
      body: const NewCommuteRouteForm(),
    );
  }
}