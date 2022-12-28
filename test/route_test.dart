import 'package:commute_tracker/models/route.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Creates route when passed a title but no description", () {
    String requiredName = "First route";
    Route route = Route(title: requiredName);
    expect(route.title, requiredName);
  });

  test("Contains correct route AND description", () {
    String requiredName = "First route";
    String description = "This is the first route from A to B";
    Route route = Route(title: requiredName, description: description);
    expect(route.title, requiredName);
    expect(route.description, description);
  });
}