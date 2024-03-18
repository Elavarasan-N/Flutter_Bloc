import 'package:bloc_crud/bloc/authenication_bloc/authentication_bloc.dart';
import 'package:bloc_crud/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:bloc_crud/data/repository/user_repo.dart';
import 'package:bloc_crud/screen/home_screen.dart';
import 'package:bloc_crud/screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppView extends StatelessWidget {
  final UserRepository userRepository;
  const MyAppView({super.key, required  this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
			title: 'Firebase Auth',
      debugShowCheckedModeBanner: false,
			theme: ThemeData(
				colorScheme: const ColorScheme.light(
          background: Colors.white,
          onBackground: Colors.black,
          primary: Color.fromRGBO(206, 147, 216, 1),
          onPrimary: Colors.black,
          secondary: Color.fromRGBO(244, 143, 177, 1),
          onSecondary: Colors.white,
					tertiary: Color.fromRGBO(255, 204, 128, 1),
          error: Colors.red,
					outline: Color(0xFF424242)
        ),
			),
			home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
				builder: (context, state) {
					if(state.status == AuthenticationStatus.authenticated) {
						return BlocProvider(
							create: (context) => SignInBloc(
								userRepository: context.read<AuthenticationBloc>().userRepository
							),
							child: HomeScreen(userRepository: userRepository),
						);
					} else {
						return const WelcomeScreen();
					}
				}
			)
		);
  }
}