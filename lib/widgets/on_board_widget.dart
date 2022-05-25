import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/screens/home_page.dart';
import 'package:to_do_app/screens/signin_page.dart';

import '../services/auth.dart';

//*Uygulamaya ilk girişte kişinin online olup olmadığını kontrol edebilmek için bu widgetı statefull olarak oluşturdum.
class OnBoardWidget extends StatefulWidget {
  OnBoardWidget({Key? key}) : super(key: key);

  @override
  State<OnBoardWidget> createState() => _OnBoardWidgetState();
}

class _OnBoardWidgetState extends State<OnBoardWidget> {
  @override
  Widget build(BuildContext context) {
//*Auth servisime bağlanabilmek için bir auth nesnesi oluşturdum providerla.
    Auth _auth = Provider.of<Auth>(context, listen: false);

//*StreamBuilder ile Auth servisimde oluşturduğum stream fonksiyonuna bağlandım stream propertisi ile. Daha sonra builder ile bu streamden gelen bilginin bağlantı durumuna göre hangi ekrana geçeceğimi ayarladım. BU ŞEKİLDE DEĞİLDE YUKARIDA INITSTATE İÇİNDE DİREK NESNE OLUŞTURARAK DA YAPABİLİYORUZ AMA BU YÖNTEM DAHA DOĞRU.
    return StreamBuilder(
      stream: _auth.authStatus(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return snapshot.data == null ? const SignIn() : HomePage();
        } else {
          return const SizedBox(
              height: 100, width: 100, child: CircularProgressIndicator());
        }
      },
    );
  }
}
