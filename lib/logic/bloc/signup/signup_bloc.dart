import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:listz_app/core/exceptions.dart';
import 'package:listz_app/data/repositories/repository.dart';
import 'package:meta/meta.dart';
part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final Repository _repository;

  SignUpBloc(this._repository) : super(SignUpInitial());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    yield SignUpInitial();
    try {
      if (event is SignUp) {
        bool result = await _repository.signUp(
            event.username, event.password, event.email);
        if (result == true) {
          yield SignUpSuccess();
        } else {
          yield SignUpFailure(error: 'Criação de usuário falhou');
        }
      }
    } on ServerException catch (e) {
      yield SignUpFailure(error: "error");
    } catch (err) {
      String message = err.toString();
      yield SignUpFailure(error: message);
    }
  }
}
