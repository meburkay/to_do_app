// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyThemeData with ChangeNotifier {
  Color themeColor = Colors.green;
  static SharedPreferences? sp;

  MyThemeData() {
//*SharedPreferences'dan bilgileri provider'ın create propertisinde MyThemeData initilize edilirken constructor vasıtası ile çektim ve bir sıkınıt çıkmadı bu şekilde.
    spGet();
  }

  Future<void> spCreate() async {
    log('spCreate çalıştı');

    sp = await SharedPreferences.getInstance();

    //spGet();
  }

  void spGet() {
    int themeColorInt = sp?.getInt('color') ?? Colors.green.value;
    themeColor = Color(themeColorInt);
    log(themeColor.toString(), name: 'getten sonra değişen renk');
    changeThemeColor(themeColor);
    notifyListeners();
    log('spGet çalıştı');
    log(themeColor.toString(), name: 'degisenRenk');
  }

  void spSet() {
    int themeColorInt = themeColor.value;

    sp?.setInt('color', themeColorInt);
    log(themeColor.toString(), name: 'setIntRenk');
  }

  ThemeData myThemeData = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
    ),

    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.green),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(primary: Colors.green),
    ),
    primaryColor: Colors.green, //*Ana renk olarak seçiyoruz.
    primaryColorLight: Colors.green[100],

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
    log('changethemecolor çalıştı');
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

/*You can use these helper methods to change it. Just replace

newHueValue: with any double btw 0 and 360
newSaturationValue: with any double btw 0 and 1
newLightnessValue: with any double btw 0 and 1
Color changeColorHue(Color color) => HSLColor.fromColor(color).withHue(newHueValue).toColor();

Color changeColorSaturation(Color color) => HSLColor.fromColor(color).withSaturation(newSaturationValue).toColor();

Color changeColorLightness(Color color) => HSLColor.fromColor(color).withLightness(newLightnessValue).toColor();

Similarly you can use: HSVColor for HSV (hue, saturation, value).

more: https://api.flutter.dev/flutter/painting/HSLColor-class.html*/

//*Gelen themeColor'ın lightness ayarını üstteki bilgileri kullanarak değiştirdim. Direk return kısmındaki kodu yazarak yapılabiliyor.
      primaryColorLight:
          HSLColor.fromColor(themeColor).withLightness(0.9).toColor(),
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
    spSet();
    notifyListeners();
  }
}
