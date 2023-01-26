import 'package:commute_tracker/components/segments_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/models.dart';

class CommuteRouteScreen extends ConsumerWidget {
  final CommuteRoute route;

  const CommuteRouteScreen({
    Key? key,
    required this.route,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(route.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(route.title),
            Text(route.description),
            SegmentsWidget(routeId: route.id),
          ],
        ),
      ),
    );
  }
}
