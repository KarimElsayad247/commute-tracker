import 'package:commute_tracker/Styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CommuteRoute.dart';
import 'CommuteRoutes.dart';

class CommuteRoutesWidget extends StatelessWidget {
  const CommuteRoutesWidget({
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CommuteRoutes>(builder: (context, routes, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Routes"),
        ),
        body: FutureBuilder<List<CommuteRoute>>(
          future: context.read<CommuteRoutes>().all(),
          builder: (BuildContext context,
              AsyncSnapshot<List<CommuteRoute>> snapshot) {
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
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: _deleteRoute,
                ),
              );
            });
            final divided = tiles.isNotEmpty
                ? ListTile.divideTiles(tiles: tiles, context: context).toList()
                : <Widget>[];
            return ListView(children: divided,);
          },
        ),
      );
    });
  }

  void _deleteRoute() {
    print("deleting");
  }
}
