import 'package:path/path.dart' as Path;
import 'package:sqflite/sqflite.dart';

mixin DatabaseProvider {
  static Future<Database> open() async {
    // Open the database and store the reference.
    return openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      Path.join(await getDatabasesPath(), 'commute_tracker.db'),

      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE routes(id INTEGER PRIMARY KEY, title TEXT, description TEXT)',
        );
      },

      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }
}