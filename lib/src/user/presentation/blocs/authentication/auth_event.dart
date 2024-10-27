part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class SignUpEvent extends AuthEvent {
  final String username;
  final String email;
  final String password;
  final String? fullName;

  SignUpEvent({
    required this.username,
    required this.email,
    required this.password,
    this.fullName,
  });
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({
    required this.email,
    required this.password,
  });
}

class LogoutEvent extends AuthEvent {}

class CheckAuthStatusEvent extends AuthEvent {}
