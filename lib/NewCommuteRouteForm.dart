// Define a custom Form widget.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:commute_tracker/models/CommuteRoutes.dart';
import 'package:provider/provider.dart';

import 'Styles.dart';

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
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Title", style: Styles.largeFont),
            TextFormField(
              // The validator receives the text that the user has entered.
              validator: notEmptyValidator,
            ),
            widgetSeparator(),
            Text("Description (Optional)", style: Styles.largeFont),
            TextFormField(),
            Spacer(),
            Center(
              child: buildSubmitButton(_formKey),
            )
          ],
        ),
      ),
    );
  }

  SizedBox widgetSeparator() {
    return const SizedBox(height: 30);
  }

  String? notEmptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  ElevatedButton buildSubmitButton(GlobalKey<FormState> formKey) {
    // ButtonStyle style = Styles.veryBigButton(Theme.of(context).primaryColor);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        minimumSize: const Size(300, 60),
      ),
      onPressed: () {
        // Validate returns true if the form is valid, or false otherwise.
        if (formKey.currentState!.validate()) {
          // If the form is valid, display a snackbar.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Route created!')),
          );
          // Save new route
          context
              .read<CommuteRoutes>()
              .create(title: "First route", description: "my firend");
        }
      },
      child: const Text('Submit'),
    );
  }
}
