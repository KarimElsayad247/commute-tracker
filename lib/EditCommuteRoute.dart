import 'package:commute_tracker/models/CommuteRoute.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'NewCommuteRoute.dart';
import 'NewCommuteRouteForm.dart';
import 'models/CommuteRoutes.dart';

class EditCommuteRoute extends StatelessWidget {
  const EditCommuteRoute({
    Key? key,
    required this.route,
  });

  final CommuteRoute route;

  final String confirmDeleteDialogContent =
      "Are you sure you want to delete this route? "
      "this can't be undone and all related data will be lost";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Route"),
        actions: [buildDeleteIconButton(context, route)],
      ),
      body: NewCommuteRouteForm(route: route),
    );
  }

  IconButton buildDeleteIconButton(BuildContext context, CommuteRoute route) {
    return IconButton(
      icon: const Icon(Icons.delete),
      tooltip: "Delete this route",
      onPressed: () async {
        (await confirm(
          context,
          title: const Text("Delete route"),
          content: Text(confirmDeleteDialogContent),
        ))
            ? _deleteRoute(context, route.id)
            : null;
      },
    );
  }

  void _deleteRoute(BuildContext context, int? routeId) {
    if (routeId == null) {
      throw ArgumentError(
          "It should be impossible for route id to be null here");
    }
    context.read<CommuteRoutes>().deleteRoute(routeId);
    Navigator.pop(context);
  }
}
