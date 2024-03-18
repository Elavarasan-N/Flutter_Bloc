import 'package:bloc_crud/app_view.dart';
import 'package:bloc_crud/bloc/authenication_bloc/authentication_bloc.dart';
import 'package:bloc_crud/data/repository/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(
				userRepository: userRepository
			),
      child: MyAppView(userRepository: userRepository),
    );
  }
}