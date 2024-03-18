import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

import 'service/employee_service.dart';
import 'service/user_service.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  final UserService userService;

  const SplashScreen({Key? key, required this.userService}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool obscurePassword = true;
  IconData iconPassword = CupertinoIcons.eye_fill;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.admin_panel_settings_rounded,
                size: 100,
                color: Colors.blueAccent,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text('ADMIN',
              style: TextStyle(
                fontSize: 20, 
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
              ),  
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Email', 
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Password', 
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                      obscurePassword = !obscurePassword;
                      if(obscurePassword) {
                      iconPassword = CupertinoIcons.eye_fill;
                      } else {
                        iconPassword = CupertinoIcons.eye_slash_fill;
                      }
                      });
                    },
                    icon: Icon(iconPassword)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        final navigator = Navigator.of(context);
                        User user = await widget.userService.loginUser(
                          emailController.text, passwordController.text);
                          navigator.pushReplacement(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return WelcomeScreen(
                                user: user,
                                employeeService: EmployeeService(user),
                                userService: widget.userService,
                              );
                            }));
                      } on RealmException catch (e) {
                        if (kDebugMode) {
                          print('Error during login ${e.message}');
                        }
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.message))
                          );
                        }
                      }
                    }, 
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      ),
                  ),
                  const SizedBox(
                    width: 400,
                  ),
                  const Text('Don\'t have an account?',
                  style: TextStyle(
                    fontSize: 20,
                  ),),
                  ElevatedButton(
                    onPressed: () {}, 
                    child: const Text(
                      'Signup',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ),
    );
  }
}