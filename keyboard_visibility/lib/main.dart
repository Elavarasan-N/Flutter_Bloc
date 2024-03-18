import 'package:flutter/material.dart';
import 'package:keyboard_visibility/CustomKeyboard.dart';
import 'package:keyboard_visibility/MyLoading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
      
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 final TextEditingController _text = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 45,
        width: MediaQuery.of(context).size.width / 2,
        margin: const EdgeInsets.only(),
          child: TextField(
            controller: _text,
            keyboardType: TextInputType.text,
            autofocus: true,
            onTap: () {
               showKeyboard(context);
               print(' ontap = '+_text.text);
               },
               onChanged: (value) {
                 
               },
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              labelText: "Enter Text",
              labelStyle: TextStyle(color: Colors.black),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
      ),
    );
  }

 void showKeyboard(BuildContext context) {
  CustomOverlay.start(
    context,
    Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (BuildContext context) {
            return Positioned(
              bottom: 0,
              left: 0,
              child: Material(
                child: Container(
                  height: 350,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blue,
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return CustomKeyboard(
                        backgroundColor: Colors.blue,
                        bottomPaddingColor: Colors.blue,
                        bottomPaddingHeight: 5,
                        keyboardHeight: 345,
                        keyboardWidth: MediaQuery.of(context).size.width,
                        onChange: (value) {
                          setState(() {
                            _text.text = value;
                          });
                          print('key onchange = ' + value);
                        },
                        onTapColor: Colors.lightBlue,
                        textColor: Colors.black,
                        keybordButtonColor: Colors.blue,
                        elevation: MaterialStateProperty.all(5),
                        controller: _text,
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}


}
