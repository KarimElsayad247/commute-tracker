// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// ignore_for_file: type=lint
class CommuteRoute extends DataClass implements Insertable<CommuteRoute> {
  final int id;
  final String title;
  final String description;
  const CommuteRoute(
      {required this.id, required this.title, required this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    return map;
  }

  CommuteRoutesCompanion toCompanion(bool nullToAbsent) {
    return CommuteRoutesCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
    );
  }

  factory CommuteRoute.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommuteRoute(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
    };
  }

  CommuteRoute copyWith({int? id, String? title, String? description}) =>
      CommuteRoute(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('CommuteRoute(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommuteRoute &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description);
}

class CommuteRoutesCompanion extends UpdateCompanion<CommuteRoute> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> description;
  const CommuteRoutesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
  });
  CommuteRoutesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String description,
  })  : title = Value(title),
        description = Value(description);
  static Insertable<CommuteRoute> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
    });
  }

  CommuteRoutesCompanion copyWith(
      {Value<int>? id, Value<String>? title, Value<String>? description}) {
    return CommuteRoutesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommuteRoutesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $CommuteRoutesTable extends CommuteRoutes
    with TableInfo<$CommuteRoutesTable, CommuteRoute> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommuteRoutesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title =
      GeneratedColumn<String>('title', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, description];
  @override
  String get aliasedName => _alias ?? 'commute_routes';
  @override
  String get actualTableName => 'commute_routes';
  @override
  VerificationContext validateIntegrity(Insertable<CommuteRoute> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CommuteRoute map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CommuteRoute(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
    );
  }

  @override
  $CommuteRoutesTable createAlias(String alias) {
    return $CommuteRoutesTable(attachedDatabase, alias);
  }
}

class CommuteRecord extends DataClass implements Insertable<CommuteRecord> {
  final int id;
  final int route;
  const CommuteRecord({required this.id, required this.route});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['route'] = Variable<int>(route);
    return map;
  }

  CommuteRecordsCompanion toCompanion(bool nullToAbsent) {
    return CommuteRecordsCompanion(
      id: Value(id),
      route: Value(route),
    );
  }

  factory CommuteRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommuteRecord(
      id: serializer.fromJson<int>(json['id']),
      route: serializer.fromJson<int>(json['route']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'route': serializer.toJson<int>(route),
    };
  }

  CommuteRecord copyWith({int? id, int? route}) => CommuteRecord(
        id: id ?? this.id,
        route: route ?? this.route,
      );
  @override
  String toString() {
    return (StringBuffer('CommuteRecord(')
          ..write('id: $id, ')
          ..write('route: $route')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, route);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommuteRecord &&
          other.id == this.id &&
          other.route == this.route);
}

class CommuteRecordsCompanion extends UpdateCompanion<CommuteRecord> {
  final Value<int> id;
  final Value<int> route;
  const CommuteRecordsCompanion({
    this.id = const Value.absent(),
    this.route = const Value.absent(),
  });
  CommuteRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int route,
  }) : route = Value(route);
  static Insertable<CommuteRecord> custom({
    Expression<int>? id,
    Expression<int>? route,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (route != null) 'route': route,
    });
  }

  CommuteRecordsCompanion copyWith({Value<int>? id, Value<int>? route}) {
    return CommuteRecordsCompanion(
      id: id ?? this.id,
      route: route ?? this.route,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (route.present) {
      map['route'] = Variable<int>(route.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommuteRecordsCompanion(')
          ..write('id: $id, ')
          ..write('route: $route')
          ..write(')'))
        .toString();
  }
}

class $CommuteRecordsTable extends CommuteRecords
    with TableInfo<$CommuteRecordsTable, CommuteRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommuteRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _routeMeta = const VerificationMeta('route');
  @override
  late final GeneratedColumn<int> route = GeneratedColumn<int>(
      'route', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, route];
  @override
  String get aliasedName => _alias ?? 'commute_records';
  @override
  String get actualTableName => 'commute_records';
  @override
  VerificationContext validateIntegrity(Insertable<CommuteRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('route')) {
      context.handle(
          _routeMeta, route.isAcceptableOrUnknown(data['route']!, _routeMeta));
    } else if (isInserting) {
      context.missing(_routeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CommuteRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CommuteRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      route: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}route'])!,
    );
  }

  @override
  $CommuteRecordsTable createAlias(String alias) {
    return $CommuteRecordsTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $CommuteRoutesTable commuteRoutes = $CommuteRoutesTable(this);
  late final $CommuteRecordsTable commuteRecords = $CommuteRecordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [commuteRoutes, commuteRecords];
}
