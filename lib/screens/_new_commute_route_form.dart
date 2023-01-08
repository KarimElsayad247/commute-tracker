// Define a custom Form widget.
import 'package:commute_tracker/main.dart';
import 'package:commute_tracker/controllers/commute_routes_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';


class NewCommuteRouteForm extends ConsumerStatefulWidget {
  const NewCommuteRouteForm({
    super.key,
    this.id,
    this.title = '',
    this.description = '',
  });

  final int? id;
  final String title;
  final String description;

  @override
  NewCommuteRouteFormState createState() {
    return NewCommuteRouteFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class NewCommuteRouteFormState extends ConsumerState<NewCommuteRouteForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title;
    descriptionController.text = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              // The validator receives the text that the user has entered.
              validator: notEmptyValidator,
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            widgetSeparator(),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const Spacer(),
            Center(
              child: buildSubmitButton(_formKey),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
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

  ElevatedButton buildSubmitButton(
      GlobalKey<FormState> formKey) {
    bool isNewRoute = widget.id == null;
    // ButtonStyle style = Styles.veryBigButton(Theme.of(context).primaryColor);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        minimumSize: const Size(300, 60),
      ),
      onPressed: () {
        // Validate returns true if the form is valid, or false otherwise.
        if (formKey.currentState!.validate()) {
          String message = isNewRoute ? "Created new route!" : "Updated route";

          // If the form is valid, display a snackbar.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
          // Save new route
          CommuteRoutesController commuteRoutes = ref.read(commuteRoutesProvider.notifier);

          if (isNewRoute) {
            commuteRoutes.create(
                title: titleController.text,
                description: descriptionController.text
            );
            Navigator.pop(context);
          }
          else {
            commuteRoutes.updateRoute(
              widget.id!, // a route is not new -> id is not null
              titleController.text,
              descriptionController.text
            );
          }
        }
      },
      child: Text(isNewRoute ? 'Create' : 'Update'),
    );
  }
}
