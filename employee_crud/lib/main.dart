import 'package:employee_crud/service/user_service.dart';
import 'package:employee_crud/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

const appId = "application-fikyi";

void main() {
  final App atlasApp = App(AppConfiguration(appId));
  final UserService userService = UserService(atlasApp);
   runApp(MyApp(
    userService: userService
   ));
}

class MyApp extends StatelessWidget {
  final UserService userService;
  const MyApp({super.key, required this.userService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Login',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: SplashScreen(
        userService: userService
        ),
    );
  }
}
