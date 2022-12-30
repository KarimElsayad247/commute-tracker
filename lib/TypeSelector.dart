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
            DropdownButton<String>(
                items: map2dropdown(context.read<CommuteRoutes>().all()),
                onChanged: dropdownCallback,
                value: _dropdownValue),
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

List<DropdownMenuItem<String>> map2dropdown(Map<int, CommuteRoute> map) {
  return map.entries.map((e) {
    return DropdownMenuItem(
        value: e.key.toString(), child: Text(e.value.title));
  }).toList();
}
