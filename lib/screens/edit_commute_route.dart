import 'package:commute_tracker/main.dart';
import '../models/models.dart';

import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '_new_commute_route_form.dart';

class EditCommuteRoute extends ConsumerWidget {
  const EditCommuteRoute({
    Key? key,
    required this.route,
  }) : super(key: key);

  final CommuteRoute route;

  final String confirmDeleteDialogContent =
      "Are you sure you want to delete this route? "
      "this can't be undone and all related data will be lost";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Route"),
        actions: [buildDeleteIconButton(context, ref, route)],
      ),
      body: NewCommuteRouteForm(
        id: route.id,
        title: route.title,
        description: route.description,
      ),
    );
  }

  IconButton buildDeleteIconButton(BuildContext context, WidgetRef ref, CommuteRoute route) {
    return IconButton(
      icon: const Icon(Icons.delete),
      tooltip: "Delete this route",
      onPressed: () async {
        (await confirm(
          context,
          title: const Text("Delete route"),
          content: Text(confirmDeleteDialogContent),
        ))
            ? _deleteRoute(context, ref, route.id)
            : null;
      },
    );
  }

  void _deleteRoute(BuildContext context, WidgetRef ref, int? routeId) {
    if (routeId == null) {
      throw ArgumentError(
          "It should be impossible for route id to be null here");
    }
    ref.read(commuteRoutesProvider.notifier).deleteRoute(routeId);
    Navigator.pop(context);
  }
}
