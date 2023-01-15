import 'package:commute_tracker/main.dart';
import 'package:commute_tracker/screens/new_commute_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';

import '../utils/styles.dart';

class TypeSelector extends ConsumerStatefulWidget {
  const TypeSelector({Key? key, required this.onRouteChange})
      : super(key: key);

  final Function(int) onRouteChange;

  @override
  TypeSelectorState createState() => TypeSelectorState();
}

class TypeSelectorState extends ConsumerState<TypeSelector> {
  String? _dropdownValue;

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      widget.onRouteChange(int.parse(selectedValue));
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(commuteRoutesProvider);
    return Container(
      color: Styles.backgroundGray,
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Route",
                  style: Styles.mediumFont,
                ),
              ),
              ElevatedButton(
                  onPressed: _addNewRoute, child: const Icon(Icons.add))
            ],
          ),
          FutureBuilder<List<CommuteRoute>>(
            future: ref.read(commuteRoutesProvider).all(),
            builder: (BuildContext context,
                AsyncSnapshot<List<CommuteRoute>> snapshot) {
              List<CommuteRoute>? routes;
              if (snapshot.hasData) {
                routes = snapshot.data;
              }
              return DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text("Select route"),
                  items: list2dropdown(routes),
                  onChanged: dropdownCallback,
                  value: _dropdownValue);
            },
          ),
        ],
      ),
    );
  }

  void _addNewRoute() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const NewCommuteRoute()));
  }
}

List<DropdownMenuItem<String>> list2dropdown(List<CommuteRoute>? routes) {
  if (routes == null) {
    return [];
  }

  return routes.map((e) {
    return DropdownMenuItem(value: e.id.toString(), child: Text(e.title));
  }).toList();
}
