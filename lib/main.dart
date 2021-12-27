import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'screens/home_screen.dart';

/* 
*Requesting currencies on the site
 */
const request =
    'https://api.hgbrasil.com/finance?format=json-cors&key=c6a82509';

void main() {
  /* print(json.decode(response.body)['results']['currencies']); */

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.amber,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.amber,
            ),
          ),
          hintStyle: TextStyle(
            color: Colors.amber,
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

Future<dynamic> getData() async {
  final response = await http.get(Uri.parse(request));
  return json.decode(response.body);
}
