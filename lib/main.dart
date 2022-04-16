import 'package:flutter/material.dart';
import 'package:to_do_app/screens/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.green,//*Ana renk olarak seçiyoruz.
          primarySwatch: Colors.green,//*Uygulamada genel olarka bu rengi kullanıcam dedim.
          //!accent color ile tuş renklerini ayarladı ama kalkmış kullanımdan yeni yöntemi nasıl kullanıcam anlamadım bakıcam.
          scaffoldBackgroundColor: Colors.green,
          appBarTheme: AppBarTheme(color: Colors.green),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
              subtitle1: TextStyle(color: Colors.white),
              headline3: TextStyle(color: Colors.white))),
      home: HomePage(),
    );
  }
}
