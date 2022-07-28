class Task {
  final int? id;
  final String? title;
  final String? descreption;
  Task({this.id, this.title, this.descreption});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": descreption,
    };
  }
}
