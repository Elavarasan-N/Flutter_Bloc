import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:employee_crud/service/user_service.dart';
import 'package:equatable/equatable.dart';

import '../schemas/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserService userService;
	late final StreamSubscription<User?> _userSubscription;

	AuthenticationBloc({
		required this.userService
	}) : super(const AuthenticationState.unknown()) {
    _userSubscription = userService.user.listen((user) {
			add(AuthenticationUserChanged(user));
		});
		on<AuthenticationUserChanged>((event, emit) {
			if(event.user != null) {
				emit(AuthenticationState.authenticated(event.user!));
			} else {
				emit(const AuthenticationState.unauthenticated());
			}
		});
  }
	
	@override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
