class Blog {
  int id;
  String title;
  String note;

  Blog(Map<String, dynamic> json){
    id = json["id"];
    title = json["title"];
    note = json["note"];
  }
}