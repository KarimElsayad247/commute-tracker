import 'package:commute_tracker/NewRoute.dart';
import 'package:flutter/material.dart';
import 'Styles.dart';

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
          DropdownButton(items: const [
            DropdownMenuItem(
              value: "1",
              child: Text("Route 1"),
            ),
            DropdownMenuItem(
              value: "2",
              child: Text("Route 2"),
            ),
          ], onChanged: dropdownCallback, value: _dropdownValue),
        ],
      ),
    );
  }

  void _addNewRoute() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => NewRoute())
    );
  }
}
