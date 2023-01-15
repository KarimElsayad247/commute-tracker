import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'models.g.dart';

// this will generate a table for us. The rows of that table
// will be represented by a class with name "CommuteRoute"
// Notice class name is plural, while data class name is singular.
class CommuteRoutes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1)();
  TextColumn get description => text()();
}

class CommuteRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get route => integer()();
}

class RouteSegments extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text().withLength(min: 1)();
  IntColumn get route => integer()();
}

@DriftDatabase(tables: [CommuteRoutes, CommuteRecords, RouteSegments])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 5) {
          await m.createTable(routeSegments);
        }
      }
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    const dbFolder = "/data/data/com.sayad.commute_tracker/databases";
    final file = File(p.join(dbFolder, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}