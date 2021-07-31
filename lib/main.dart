import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rempahsis/home.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(RempahSIS());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent 
  ));
}

class RempahSIS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rempah SIS',
      theme: ThemeData(

        primarySwatch: Colors.brown,
        primaryColor: Color(0xffCE8D51),
        accentColor: Colors.white,
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
        
        inputDecorationTheme: InputDecorationTheme(
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.transparent,
          modalBackgroundColor: Colors.transparent,
        ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white)
        ),
      ),
      home: MyHomePage(),
    );
  }
}


