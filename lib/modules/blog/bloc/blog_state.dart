part of 'blog_bloc.dart';

abstract class BlogState {
  const BlogState();
}

class BlogInitial extends BlogState {}

class LoadingBlogState extends BlogState {}

class LoadedBlogState extends BlogState {
   List<Blog> blog;

  LoadedBlogState(this.blog);
}

class ReloadBlogState extends BlogState {
  final List<Blog> blog;

  ReloadBlogState(this.blog);
}

class AddedBlogState extends BlogState {}
