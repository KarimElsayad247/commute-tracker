// Define a custom Form widget.
import 'package:commute_tracker/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:commute_tracker/models/CommuteRoutes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'utils/Styles.dart';
import 'models/CommuteRoute.dart';

class NewCommuteRouteForm extends ConsumerStatefulWidget {
  const NewCommuteRouteForm({
    super.key,
    required this.route,
  });

  final CommuteRoute route;

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
    titleController.text = widget.route.title;
    descriptionController.text = widget.route.description;
  }

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
            Spacer(),
            Center(
              child: buildSubmitButton(_formKey, widget.route),
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
      GlobalKey<FormState> formKey, CommuteRoute route) {
    bool isNewRoute = widget.route.id == null;
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
          CommuteRoutes commuteRoutes = ref.read(commuteRoutesProvider.notifier);

          if (isNewRoute) {
            commuteRoutes.create(
                title: titleController.text,
                description: descriptionController.text
            );
          }
          else {
            CommuteRoute route = widget.route;
            route.title = titleController.text;
            route.description = descriptionController.text;
            commuteRoutes.updateRoute(route);
          }
        }
      },
      child: Text(isNewRoute ? 'Create' : 'Update'),
    );
  }
}
