import 'package:commute_tracker/components/shared/HeadedContainer.dart';
import 'package:commute_tracker/main.dart';
import 'package:commute_tracker/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/styles.dart';

class SegmentsWidget extends ConsumerWidget {
  final int routeId;

  const SegmentsWidget({
    Key? key,
    required this.routeId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return HeadedContainer(
        title: "Segments",
        icon: Icons.add,
        callback: _addSegment,
        child: FutureBuilder<List<RouteSegment>>(
          future: ref.read(commuteRoutesProvider).segmentsForRoute(routeId),
          builder: (BuildContext context,
              AsyncSnapshot<List<RouteSegment>> snapshot) {
            List<RouteSegment>? segments;
            if (snapshot.hasData) {
              segments = snapshot.data;
            }
            segments ??= [];
            final tiles = segments.map((segment) {
              return ListTile(
                title: Text(
                  segment.description,
                  style: Styles.largeFont,
                ),
              );
            });
            final divided = tiles.isNotEmpty
                ? ListTile.divideTiles(tiles: tiles, context: context).toList()
                : <Widget>[];
            return ListView(
              shrinkWrap: true,
              children: divided,
            );
          },
        ));
  }

  void _addSegment() {}
}
