part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class SigningInState extends LoginState {}

class SignedInState extends LoginState {
  final LoginModel login;
  SignedInState(this.login);
}

class SignInErrorState extends LoginState {
  final String error;
  SignInErrorState(this.error);
}
