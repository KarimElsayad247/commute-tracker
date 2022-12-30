import 'package:commute_tracker/models/CommuteRoutes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Creates and saves a new route with given title", () {
    String requiredName = "First route";
    CommuteRoutes.create(title: requiredName);
    expect(CommuteRoutes.all().length, 1);
    expect(CommuteRoutes.get(0)?.title, requiredName);
  });
}