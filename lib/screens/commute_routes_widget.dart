import 'package:commute_tracker/main.dart';
import 'package:commute_tracker/screens/commute_routes/commute_route_screen.dart';
import 'package:commute_tracker/screens/edit_commute_route.dart';
import 'package:commute_tracker/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'new_commute_route.dart';
import '../models/models.dart';

class CommuteRoutesWidget extends ConsumerWidget {
  const CommuteRoutesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void _addNewRoute() {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const NewCommuteRoute()));
    }

    ref.watch(commuteRoutesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Routes"),
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
              onTap: () => navigateToRouteScreen(context, route),
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
        onPressed: _addNewRoute,
        child: const Icon(Icons.add),
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

  void navigateToRouteScreen(BuildContext context, CommuteRoute route) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CommuteRouteScreen(route: route)));
  }
}
