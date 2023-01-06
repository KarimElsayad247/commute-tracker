import 'package:commute_tracker/models/commute_route.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Creates route when passed a title but no description", () {
    String requiredName = "First route";
    CommuteRoute route = CommuteRoute(title: requiredName);
    expect(route.title, requiredName);
  });

  test("Contains correct route AND description", () {
    String requiredName = "First route";
    String description = "This is the first route from A to B";
    CommuteRoute route = CommuteRoute(title: requiredName, description: description);
    expect(route.title, requiredName);
    expect(route.description, description);
  });
}