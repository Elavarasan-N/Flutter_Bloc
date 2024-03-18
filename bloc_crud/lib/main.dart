import 'package:bloc_crud/app.dart';
import 'package:bloc_crud/data/repository/firebase_user_repo.dart';
import 'package:bloc_crud/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await Firebase.initializeApp(
      options: const FirebaseOptions(
      apiKey: "AIzaSyDwnkYOo0pX7wOjcnDCWTUXTF5saYlNTP0",
      appId: "1:259424149491:web:87305d0c16a5d5c4eefc86",
      messagingSenderId: "259424149491",
      projectId: "processor-ec803")
  );
	Bloc.observer = SimpleBlocObserver();
  runApp(MyApp(FirebaseUserRepo()));
}