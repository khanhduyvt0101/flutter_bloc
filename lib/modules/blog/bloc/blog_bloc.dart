import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_example/modules/blog/api/blog_api_provider.dart';
import 'package:bloc_example/modules/blog/model/blog_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  BlogBloc() : super(BlogInitial());
  List<Blog> blog = [];

  @override
  Stream<BlogState> mapEventToState(BlogEvent event) async* {
    switch (event.runtimeType) {

      ///LOAD TO DO
      case LoadBlogEvent:
        // print('load event');
        yield LoadingBlogState();
        if (blog.isEmpty) blog = await BlogApiProvider.loadBlog();
        yield LoadedBlogState(blog);
        break;
      default:
    }
  }
}
