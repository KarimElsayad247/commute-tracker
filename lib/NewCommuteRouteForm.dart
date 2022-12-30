// Define a custom Form widget.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:commute_tracker/models/CommuteRoutes.dart';
import 'package:provider/provider.dart';

class NewCommuteRouteForm extends StatefulWidget {
  const NewCommuteRouteForm({super.key});

  @override
  NewCommuteRouteFormState createState() {
    return NewCommuteRouteFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class NewCommuteRouteFormState extends State<NewCommuteRouteForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
                CommuteRoutes routes = context.watch<CommuteRoutes>();
                routes.create(title: "First route", description: "my firend");
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
