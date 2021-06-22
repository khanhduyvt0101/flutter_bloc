class Todo {
  String id, userId;
  String title, note;
  bool done;

  Todo(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    note = json['note'];
    done = json['done'] == 'true';
  }
}
