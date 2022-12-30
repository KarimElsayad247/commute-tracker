class CommuteRoute {
  String _title;
  String? _description;

  CommuteRoute({required title, description})
      : _title = title,
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
}
