// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyThemeData with ChangeNotifier {
  Color themeColor = Colors.green;

  ThemeData myThemeData = ThemeData(
     inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
           borderSide: BorderSide(color: Colors.green)
        ),), 

    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.green),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(primary: Colors.green),
    ),
    primaryColor: Colors.green, //*Ana renk olarak seçiyoruz.
    /* primarySwatch:
        Colors.green, */ //*Uygulamada genel olarka bu rengi kullanıcam dedim.
    //!accent color ile tuş renklerini ayarladı ama kalkmış kullanımdan yeni yöntemi nasıl kullanıcam anlamadım bakıcam.
    scaffoldBackgroundColor: Colors.green,
    appBarTheme: AppBarTheme(color: Colors.green),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      subtitle1: TextStyle(color: Colors.white),
      headline3: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      headline4: TextStyle(color: Colors.white),
    ),
  );

  void changeThemeColor(Color themeColor) {
    myThemeData = ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: themeColor)),
      ), 
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(primary: themeColor),
      ),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: themeColor),
      primaryColor: themeColor, //*Ana renk olarak seçiyoruz.
      //primarySwatch:themeColor, //*Uygulamada genel olarka bu rengi kullanıcam dedim.
      //!accent color ile tuş renklerini ayarladı ama kalkmış kullanımdan yeni yöntemi nasıl kullanıcam anlamadım bakıcam.
      scaffoldBackgroundColor: themeColor,
      appBarTheme: AppBarTheme(color: themeColor),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        subtitle1: TextStyle(color: Colors.white),
        headline3: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        headline4: TextStyle(color: Colors.white),
      ),
    );
    this.themeColor = themeColor;
    notifyListeners();
  }
}
