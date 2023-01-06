import 'dart:async';

import 'package:commute_tracker/utils/database_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';

import 'commute_route.dart';

class CommuteRoutes extends ChangeNotifier {

  static const String tableName = 'routes';

  create({required title, description}) async {
    CommuteRoute route = CommuteRoute(title: title, description: description);
    await insertRoute(route);
    notifyListeners();
  }

  Future<List<CommuteRoute>> all() async {
    final db = await DatabaseProvider.open();
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    db.close();
    return List.generate(maps.length, (index) {
      return fromMap(maps[index]);
    });
  }

  Future<CommuteRoute?> get(int id) async {
    final db = await DatabaseProvider.open();
    List<Map<String, dynamic>> maps =
    await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    db.close();
    if (maps.isNotEmpty) {
      return fromMap(maps.first);
    }
    return null;
  }

  Future<void> insertRoute(CommuteRoute route) async {
    final db = await DatabaseProvider.open();
    await db.insert(tableName, route.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.close();
    notifyListeners();
  }

  Future<void> updateRoute(CommuteRoute route) async {
    final db = await DatabaseProvider.open();
    await db.update(
        'routes',
        route.toMap(),
        where: 'id = ?',
        whereArgs: [route.id]
    );
    db.close();
    notifyListeners();
  }

  Future<void> deleteRoute(int id) async {
    final db = await DatabaseProvider.open();
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
    db.close();
    notifyListeners();
  }

  CommuteRoute fromMap(Map<String, dynamic> map) {
    return CommuteRoute(
        id: map['id'], title: map['title'], description: map['description']);
  }
}