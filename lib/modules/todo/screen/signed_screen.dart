import 'package:bloc_example/modules/authenticate/login/screens/login_screen.dart';
import 'package:bloc_example/modules/todo/bloc/todo_bloc.dart';
import 'package:bloc_example/modules/todo/model/todo_model.dart';
import 'package:bloc_example/modules/todo/screen/add_todo_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignedScreen extends StatefulWidget {
  final String userId;

  const SignedScreen({Key key, this.userId}) : super(key: key);

  @override
  _SignedScreenState createState() => _SignedScreenState();
}

class _SignedScreenState extends State<SignedScreen> {
  var todoBloc;
  @override
  void initState() {
    super.initState();
    todoBloc = BlocProvider.of<TodoBloc>(context);
    todoBloc.add(LoadTodoEvent(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          // title: Text('Todo App'),
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.exit_to_app_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                todoBloc.add(RemoveTodoEvent());
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            )
          ],
        ),
        body: Container(
          width: size.width,
          padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
          color: Colors.white,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Hero(
                  tag: Key('header_text'),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: Colors.black, fontSize: size.width * 0.1),
                        children: [
                          TextSpan(
                              text: 'Todo',
                              style: TextStyle(fontWeight: FontWeight.w900)),
                          TextSpan(text: 'List')
                        ]),
                  ),
                ),
                Spacer(),
                RawMaterialButton(
                  fillColor: Colors.orange,
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => AddTodoScreen(
                                  userId: widget.userId,
                                )));
                  },
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            Expanded(
              child: BlocConsumer<TodoBloc, TodoState>(
                listener: (context, state) {
                  // if (state is AddedTodoState) {
                  //   todoBloc.add(LoadTodoEvent(widget.userId));
                  // }
                },
                builder: (context, state) {
                  if (state is LoadingTodoState) {
                    return Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                width: 40,
                                height: 40,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.black,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.orange),
                                )),
                          ],
                        ),
                      ),
                    );
                  } else if (state is LoadedTodoState) {
                    return ListViewTodo(
                      todo: state.todo,
                      checkTodo: (val, id) {
                        todoBloc.add(CheckTodoEvent(id, widget.userId));
                      },
                    );
                  } else if (state is ReloadTodoState) {
                    return ListViewTodo(
                      todo: state.todo,
                      checkTodo: (val, id) {
                        todoBloc.add(CheckTodoEvent(id, widget.userId));
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class ListViewTodo extends StatelessWidget {
  final List<Todo> todo;
  final Function(bool, String) checkTodo;

  const ListViewTodo({Key key, this.todo, this.checkTodo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: todo.length,
        itemBuilder: (context, index) {
          return todo[index].done
              ? Container()
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black87,
                  ),
                  padding: EdgeInsets.all(30),
                  margin: EdgeInsets.all(6),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            todo[index].title,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            todo[index].note,
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      RawMaterialButton(
                        onPressed: () {
                          checkTodo(true, todo[index].id);
                        },
                        child: Text(
                          'Done',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        fillColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      )
                    ],
                  ),
                );
        });
  }
}
