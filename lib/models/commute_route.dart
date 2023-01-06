class CommuteRoute {
  int? id;
  String _title;
  String description;

  CommuteRoute({
    required title,
    this.description = '',
    this.id,
  })  : _title = title;

  String get title => _title;

  set title(String newTitle) {
    if (newTitle.isEmpty) {
      throw ArgumentError(["New title must not be blank"]);
    }

    _title = newTitle;
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "title": _title, "description": description};
  }

  @override
  String toString() {
    return 'Route(id: $id, title: $title)';
  }
}
