import 'package:first_app/login.dart';
import 'package:first_app/secondpage.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(
       MaterialApp(
         home: login(),
         debugShowCheckedModeBanner: false,
        initialRoute: '/',
         routes: {
           '/secondpage':(context) => SecondPage(),
         }
       )
  );
}
