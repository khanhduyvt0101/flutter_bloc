import 'package:bloc_example/modules/authenticate/login/login_bloc/login_bloc.dart';
import 'package:bloc_example/modules/authenticate/login/screens/login_screen.dart';
import 'package:bloc_example/modules/blog/bloc/blog_bloc.dart';
import 'package:bloc_example/modules/blog/screen/blog_screen.dart';
import 'package:bloc_example/modules/counter/cubit/counter_cubit.dart';
import 'package:bloc_example/modules/todo/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        // create: (context) => CounterCubit(),
        providers: [
          BlocProvider<CounterCubit>(
            create: (context) => CounterCubit(),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(),
          ),
          BlocProvider<TodoBloc>(
            create: (context) => TodoBloc(),
          ),
          BlocProvider<BlogBloc>(
            create: (context) => BlogBloc(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: BlogScreen(),
        ));
  }
}
