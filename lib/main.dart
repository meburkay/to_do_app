// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/home_page.dart';
import '../models/mission_data.dart';
import 'models/my_theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyThemeData().spCreate();

//*MultiProvider kullandım. Bu şekilde istediğim kadar providerı listeye ekleyerek kullanabiliyorum.
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<MissionData>(
        create: (BuildContext context) => MissionData()),
    ChangeNotifierProvider<MyThemeData>(create: (context) => MyThemeData())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    /*Provider.of<MyThemeData>(context).spGet();
    
    Provider.of<MyThemeData>(context)
        .changeThemeColor(Provider.of<MyThemeData>(context).themeColor);  */

    return MaterialApp(
      debugShowCheckedModeBanner: false,

//*theme olarak ayrı bir class oluşturdum ve orada tanımladım. daha sonra bu tanımladığım ThemeData'yı provider vasıtası ile buraya aktardım. Ayrıca yine aynı yerde bu ThemeData'nın renk özelliğini değiştirmek için bir metod tanımladım ve bu metod çalıştığında notifylisteners diyerek tüm programa bahse konu bilginin dağıtılmasını sağladım. İlerde istersem başka theme özelliklerini değiştirmek için de aynı classı kullanabilirim.
      theme: Provider.of<MyThemeData>(context).myThemeData,
      home: HomePage(),
    );
  }
}
