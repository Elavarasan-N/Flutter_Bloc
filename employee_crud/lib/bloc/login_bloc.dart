import 'package:bloc/bloc.dart';
import 'package:employee_crud/service/user_service.dart';
import 'package:equatable/equatable.dart';
import 'package:realm/realm.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserService userService;

  LoginBloc({required this.userService}) :
  super(LoginInitial()) {
    on<LoginRequired>((event, emit) async {
      emit(LoginProcess());
      try {
        emit(LoginSuccess());
      } on RealmException catch (e) {
        emit(LoginFailure(message: e.message));
      }
    });
    on<LogOutRequired>((event, emit) async {
      await userService.logoutUser();
    });
  }
}
