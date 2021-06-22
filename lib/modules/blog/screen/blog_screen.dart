import 'package:bloc_example/modules/blog/bloc/blog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class BlogScreen extends StatefulWidget {
  const BlogScreen({Key key}) : super(key: key);

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  var blogBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blogBloc = BlocProvider.of<BlogBloc>(context);
    blogBloc.add(LoadBlogEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: BlocConsumer<BlogBloc,BlogState>(
            listener: (context, state) {
             // blogBloc.add(LoadBlogEvent());
            },
            builder: (context,state){
              if (state is LoadingBlogState) {
                return Center(
                  child: Container(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.orange),
                      )),
                );
              }
             else if(state is LoadedBlogState){
                return ListView.builder(
                    itemCount: state.blog.length,
                    itemBuilder: (_,index){
                      return Container(
                        height: 50,
                        width: 100,
                        color: Colors.amber,
                        child: Text( state.blog[index].title),
                      );
                    });
              }else {
                return Center(
                  child: Container(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.orange),
                      )),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
