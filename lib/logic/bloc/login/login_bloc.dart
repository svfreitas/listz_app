import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:listz_app/core/exceptions.dart';
import 'package:listz_app/data/repositories/repository.dart';
import 'package:meta/meta.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Repository _repository;

  LoginBloc(this._repository) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    yield LoginInitial();
    try {
      if (event is LogIn) {
        String? token = await _repository.login(event.username, event.password);
        if (token != "") {
          yield LoginSuccess();
        } else {
          yield LoginFailure(error: 'Autenticação falhou');
        }
      }
    } on ServerException catch (e) {
      yield LoginFailure(error: "error");
    } catch (err) {
      String message = err.toString();
      yield LoginFailure(error: message);
    }
  }
}
