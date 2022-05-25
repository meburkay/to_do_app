// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/screens/signin_page.dart';
import 'package:to_do_app/widgets/on_board_widget.dart';
import '../screens/home_page.dart';
import '../models/mission_data.dart';
import 'models/my_theme_data.dart';
import 'services/auth.dart';

void main() async {
//*Eğer runApp'dan önce bir işlem gerçekleştireceksek aşağıdaki komutu yazarak belirtmemiz gerekiyor. Aksi takdirde hata veriyor.
  WidgetsFlutterBinding.ensureInitialized();

//*Firebase'i daha uygulama oluşturulmadan initialize ederek kullanmaya hazır hale getiriyoruz. Bunun için firebase_core paketini import etmemiz gerekiyor. Zaten Firebase özelliklerini kullanmak için öncelikle firebase_core paketini yüklüyoruz.
  await Firebase.initializeApp();//!Bu şekilde android telefonda çalışıyor. Fakat windows ve nette sıkıntı çıkarıyor. Options parametresini girmek gerekiyor anladığım kadarıyla. Firebase CLI diye bir şey var. Onu indirip configure yapınca otomatik options ayarlarını yapıyor galiba. O zaman "await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);" yazmak gerekiyor.

//*Provider kullanacağım classlardaki oluşturma metodlarını static yaptım. Bu şekilde direk çağırabiliyorum. Aynı şekilde SharedPreferences vasıtası ile alacağım bilgi için oluşturduğum get metodlarını da constructorlar içerisine koydum. Bu şekilde hiçbir hata vermeden hem sp initiliase ediliyor ve ilgili data direk çekiliyor.
  await MyThemeData().spCreate();
  await MissionData().spCreate();

//*MultiProvider kullandım. Bu şekilde istediğim kadar providerı listeye ekleyerek kullanabiliyorum.
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<MissionData>(
        create: (BuildContext context) => MissionData()),
    ChangeNotifierProvider<MyThemeData>(create: (context) => MyThemeData()),
//*Authentication işlemlerini ayrı bir servis klasörü içinde oluşturduğum auth classı üzerinden yaptığım için Provider oluşturdum.
    Provider<Auth>(create: (BuildContext context) => Auth()),
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

//*Kullanıcının online mı değil mi diye kontrolü için araya widget tanımladım. Bu widget kontrolü yapıp ya signin sayfasına ya da ana sayfaya yönlendirme yapıyor.       
      home: OnBoardWidget(),
    );
  }
}
