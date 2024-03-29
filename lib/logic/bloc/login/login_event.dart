part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LogIn extends LoginEvent {
  final String? username;
  final String? password;

  LogIn({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}
