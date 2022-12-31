class CommuteRoute {
  int? id;
  String _title;
  String? _description;

  CommuteRoute({
    required title,
    description,
    this.id,
  })  : _title = title,
        _description = description;

  String get title => _title;

  set title(String newTitle) {
    if (newTitle.isEmpty) {
      throw ArgumentError(["New title must not be blank"]);
    }

    _title = newTitle;
  }

  String? get description => _description;

  set description(String? newDesc) {
    _description = newDesc;
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "title": _title, "description": _description};
  }

  @override
  String toString() {
    return 'Route(id: $id, title: $title)';
  }
}
