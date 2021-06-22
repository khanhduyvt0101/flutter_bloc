import 'package:bloc_example/modules/authenticate/login/login_bloc/login_bloc.dart';
import 'package:bloc_example/modules/todo/screen/signed_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var loginBloc;
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loginBloc = BlocProvider.of<LoginBloc>(context);
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
        // appBar: AppBar(
        //   backgroundColor: Colors.blue[900],
        //   title: Text(
        //     'Login',
        //     style: TextStyle(color: Colors.white),
        //   ),
        // ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Hero(
                tag: Key('header_text'),
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 30),
                      children: [
                        TextSpan(
                            text: 'Todo',
                            style: TextStyle(fontWeight: FontWeight.w900)),
                        TextSpan(text: 'List')
                      ]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              LoginTextField(
                hint: 'User name',
                controller: userController,
              ),
              SizedBox(
                height: 20,
              ),
              LoginTextField(
                hint: 'Password',
                controller: passController,
              ),
              SizedBox(
                height: 15,
              ),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is SignedInState) {
                    Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => SignedScreen(
                                  userId: state.login.id,
                                )));
                  }
                },
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
                        loginBloc.add(SignInEvent(
                            user: userController.text.trim(),
                            pass: passController.text.trim()));
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              return Text(
                                'Sign In',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              );
                            },
                          )),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have account? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      loginBloc.add(SignUpEvent(
                          user: userController.text.trim(),
                          pass: passController.text.trim()));
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  decoration: TextDecoration.underline),
                            );
                          },
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoginTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  const LoginTextField({Key key, this.hint, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey[200],
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black, width: 2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[200], width: 2))),
    );
  }
}
