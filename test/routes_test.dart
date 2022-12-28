import 'package:commute_tracker/models/routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Creates and saves a new route with given title", () {
    String requiredName = "First route";
    Routes.create(title: requiredName);
    expect(Routes.all().length, 1);
    expect(Routes.get(0).title, requiredName);
  });
}