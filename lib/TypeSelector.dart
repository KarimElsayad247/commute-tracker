import 'package:commute_tracker/NewCommuteRoute.dart';
import 'package:flutter/material.dart';
import 'Styles.dart';
import 'package:commute_tracker/models/CommuteRoute.dart';
import 'package:provider/provider.dart';
import 'models/CommuteRoutes.dart';

class TypeSelector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TypeSelectorState();
}

class _TypeSelectorState extends State<TypeSelector> {
  String? _dropdownValue;

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CommuteRoutes>(builder: (context, routes, child) {
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
              future: context.read<CommuteRoutes>().all(),
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
    });
  }

  void _addNewRoute() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => NewCommuteRoute()));
  }
}

List<DropdownMenuItem<String>> list2dropdown(List<CommuteRoute>? routes) {

  if (routes == null) {
    return [];
  }

  return routes.map((e) {
    return DropdownMenuItem(
        value: e.id.toString(), child: Text(e.title));
  }).toList();
}
