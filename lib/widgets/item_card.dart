// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  String title;
  bool isDone;
  Function(bool?)
      missionStatus; //*null safety özelliği nedeniyle bool? şeklinde tanımlamamız gerekiyor. Çünkü bu fonksiyonu onChanged özelliğinde kullanıcaz ve onun tanımında aynen bu şekilde yazıyor zaten. Yoksa hata veriyor.
  Function(DismissDirection) deleteMission;

  ItemCard(this.title, this.isDone, this.missionStatus, this.deleteMission,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
//*itemcardların sola çekilerek listeden kaldırılabilmesi için dismissible ile sarmaladık ve key value olarak title'ı vererek tanımladık.
    return Dismissible(
      //*Başka bir yöntem olarak gesturededector ile sarmalayıp da istediğimiz tarz sildirme işlemleri yaptırabiliriz.
      onDismissed: deleteMission,
      //key: Key(title),===>>>>Bu şekilde vermiştik ama bu sefer iki aynı isimli görev olunca program patlıyor. O yüzden aşağıdaki gibi güncelledik.
//*Bu şekilde Flutter otomatik olarak her görev için kendisi sadece o göreve özel bir anahtar oluşturuyor. Bu şekilde hiçbir karışıklık olmadan kartlar tanımlanmış oluyor.
      key: UniqueKey(),
      child: Card(
        color: isDone ? Theme.of(context).primaryColorLight : Colors.white,
        shadowColor: Theme.of(context).primaryColor,
        elevation: isDone ? 1 : 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
                color: Colors.black,
                decoration: isDone
                    ? TextDecoration.lineThrough
                    : null), //*görev tamamlandığında üstüne çizgi çekiyor.
          ),
          trailing: Checkbox(
            activeColor: Theme.of(context).primaryColor,
            onChanged: missionStatus,
            value: isDone,
          ),
        ),
      ),
    );
  }
}
