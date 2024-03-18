import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_crud/data/repository/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
	late final StreamSubscription<User?> _userSubscription;

	AuthenticationBloc({
		required this.userRepository
	}) : super(const AuthenticationState.unknown()) {
    _userSubscription = userRepository.user.listen((user) {
			add(AuthenticationUserChanged(user));
		});
		on<AuthenticationUserChanged>((event, emit) {
			if(event.user != null) {
				emit(AuthenticationState.authenticated(event.user!));
        print('User email = ${event.user?.email}');
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