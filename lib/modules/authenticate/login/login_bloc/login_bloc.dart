import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_example/modules/authenticate/login/api_provider/login_repository.dart';
import 'package:bloc_example/modules/authenticate/login/model/login_model.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());
  LoginRepository loginRepository = LoginRepository();
  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    switch (event.runtimeType) {
      //
      ///SIGN IN
      case SignInEvent:
        yield SigningInState();
        var login =
            await loginRepository.signIn(event.props[0], event.props[1]);
        if (login != null) {
          yield SignedInState(login);
        } else
          yield SignInErrorState('Sign in Error');
        break;

      ////
      ///SIGN UP
      case SignUpEvent:
        yield SigningInState();
        var signUp =
            await loginRepository.signUp(event.props[0], event.props[1]);
        if (signUp != null) {
          yield SignedInState(signUp);
        } else
          yield SignInErrorState('Sign up Error');
        break;

      default:
    }
  }
}
