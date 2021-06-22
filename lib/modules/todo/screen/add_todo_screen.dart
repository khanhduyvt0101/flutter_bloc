
import 'package:bloc_example/modules/authenticate/login/login_bloc/login_bloc.dart';
import 'package:bloc_example/modules/authenticate/login/screens/login_screen.dart';
import 'package:bloc_example/modules/todo/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodoScreen extends StatefulWidget {
  final String userId;

  const AddTodoScreen({Key key, this.userId}) : super(key: key);
  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  var todoBloc;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    todoBloc = BlocProvider.of<TodoBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            children: [
              SizedBox(
                height: 0,
              ),
              LoginTextField(
                hint: 'Title',
                controller: titleController,
              ),
              SizedBox(
                height: 20,
              ),
              LoginTextField(
                hint: 'Description',
                controller: descController,
              ),
              SizedBox(
                height: 15,
              ),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return state is SignInErrorState
                      ? Center(
                          child: Text(
                            state.error,
                            style: TextStyle(color: Colors.red, fontSize: 18),
                          ),
                        )
                      : state is SigningInState
                          ? CircularProgressIndicator(
                              backgroundColor: Colors.black,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.orange),
                            )
                          : Container();
                },
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      fillColor: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                        todoBloc.add(AddTodoEvent(
                            widget.userId,
                            titleController.text.trim(),
                            descController.text.trim()));
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              return Text(
                                'ADD',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              );
                            },
                          )),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
