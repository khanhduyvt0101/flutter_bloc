import 'dart:convert';

import 'package:bloc_example/modules/blog/model/blog_model.dart';

List<Map<String, dynamic>> listBlog = [
  {"id": 1, "title": "Blog 1", "note": "Note blog 1"},
  {"id": 2, "title": "Blog 2", "note": "Note blog 2"},
  {"id": 3, "title": "Blog 3", "note": "Note blog 3"},
  {"id": 4, "title": "Blog 4", "note": "Note blog 4"}
];

class BlogApiProvider {
  static Future<List<Blog>> loadBlog() async {
    List<Blog> list = [];
    listBlog.forEach((item) {
      list.add(Blog(item));
    });

    return list;
  }
}
