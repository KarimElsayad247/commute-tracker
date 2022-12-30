import 'package:flutter/material.dart';

import 'NewCommuteRouteForm.dart';

class NewCommuteRoute extends StatelessWidget {
  
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