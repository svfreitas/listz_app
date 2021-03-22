part of 'signup_bloc.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUp extends SignUpEvent {
  final String username;
  final String password;
  final String email;

  SignUp({required this.username, required this.password, required this.email});

  @override
  List<Object?> get props => [username, password, email];
}
