part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends LoginEvent {
  final String user, pass;

  SignInEvent({this.user, this.pass});

  @override
  List<Object> get props => [user, pass];
}

class SignUpEvent extends LoginEvent {
  final String user, pass;

  SignUpEvent({this.user, this.pass});

  @override
  List<Object> get props => [user, pass];
}
