import 'dart:async';
import 'package:commute_tracker/DatabaseProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as Path;
import 'package:sqflite/sqflite.dart';
import 'CommuteRoute.dart';

class CommuteRoutes extends ChangeNotifier {
  create({required title, description}) async {
    CommuteRoute route = CommuteRoute(title: title, description: description);
    await insertRoute(route);
    notifyListeners();
  }

  Future<List<CommuteRoute>> all() async {
    final db = await DatabaseProvider.open();
    final List<Map<String, dynamic>> maps = await db.query('routes');
    db.close();
    return List.generate(maps.length, (index) {
      return fromMap(maps[index]);
    });
  }

  Future<CommuteRoute?> get(int id) async {
    final db = await DatabaseProvider.open();
    List<Map<String, dynamic>> maps =
        await db.query('routes', where: 'id = ?', whereArgs: [id]);
    db.close();
    if (maps.isNotEmpty) {
      return fromMap(maps.first);
    }
    return null;
  }

  Future<void> insertRoute(CommuteRoute route) async {
    String path = Path.join(await getDatabasesPath(), 'commute_tracker.db');
    print(path);
    final db = await openDatabase(
        Path.join(await getDatabasesPath(), 'commute_tracker.db'));

    await db.insert('routes', route.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  CommuteRoute fromMap(Map<String, dynamic> map) {
    return CommuteRoute(
        id: map['id'], title: map['title'], description: map['description']);
  }
}
