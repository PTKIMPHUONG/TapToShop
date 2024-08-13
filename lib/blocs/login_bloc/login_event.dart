import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginWithEmail extends LoginEvent {
  final String email;
  final String password;

  LoginWithEmail({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LoginWithGoogle extends LoginEvent {}

class CheckLoginStatus extends LoginEvent {}

class LogoutRequested extends LoginEvent {}
