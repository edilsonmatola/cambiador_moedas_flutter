import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'screens/home_screen.dart';

/* 
*Requesting currencies from the webiste using api key
 */
const request =
    'https://api.hgbrasil.com/finance?format=json-cors&key=c6a82509';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        hintColor: Colors.blue.shade800,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue.shade800,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue.shade800,
            ),
          ),
          hintStyle: TextStyle(
            color: Colors.blue.shade800,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

Future<dynamic> getData() async {
  final response = await http.get(Uri.parse(request));
  return json.decode(response.body);
}
