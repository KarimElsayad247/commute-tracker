import 'package:commute_tracker/screens/EditCommuteRoute.dart';
import 'package:commute_tracker/utils/Styles.dart';
import 'package:commute_tracker/main.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/NewCommuteRoute.dart';
import 'CommuteRoute.dart';
import 'CommuteRoutes.dart';

class CommuteRoutesWidget extends ConsumerWidget {
  const CommuteRoutesWidget({
    Key? key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void _addNewRoute() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => NewCommuteRoute()));
    }

    ref.watch(commuteRoutesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Routes"),
      ),
      body: FutureBuilder<List<CommuteRoute>>(
        future: ref.read(commuteRoutesProvider.notifier).all(),
        builder:
            (BuildContext context, AsyncSnapshot<List<CommuteRoute>> snapshot) {
          List<CommuteRoute>? routes;
          if (snapshot.hasData) {
            routes = snapshot.data;
          }
          routes ??= [];
          final tiles = routes.map((route) {
            return ListTile(
              title: Text(
                route.title,
                style: Styles.largeFont,
              ),
              trailing: buildEditIconButton(context, route),
            );
          });
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(tiles: tiles, context: context).toList()
              : <Widget>[];
          return ListView(
            children: divided,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add a new route",
        child: const Icon(Icons.add),
        onPressed: _addNewRoute,
      ),
    );
  }

  IconButton buildEditIconButton(BuildContext context, CommuteRoute route) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditCommuteRoute(route: route)));
      },
    );
  }
}
