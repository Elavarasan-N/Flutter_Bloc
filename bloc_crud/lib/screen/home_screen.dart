import 'package:bloc_crud/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:bloc_crud/data/repository/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final UserRepository userRepository;
  const HomeScreen({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    String? name;
    if (user != null) {
      name = user.email!.split('@')[0];
    }
    return Scaffold(
			appBar: AppBar(
				title: Text(
					'Hi ${name?.toUpperCase()}'
				),
				actions: [
					IconButton(
						onPressed: () {
							context.read<SignInBloc>().add(const SignOutRequired());
						},
						icon: const Icon(Icons.login)
					)
				],
			),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.network('https://wallpapercave.com/wp/wp1842459.jpg',
          fit: BoxFit.cover,
          ),
        ),
      ),
		);
  }
}