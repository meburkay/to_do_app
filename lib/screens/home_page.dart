// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/models/my_theme_data.dart';
import 'package:to_do_app/screens/settings_page.dart';
import '../models/mission_data.dart';
import '../widgets/item_card.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

//*textController adında TextEditingController nesnesi oluşturduk. Bu nesne TextFieldları kontrol etmek için kullanılıyor. TextField'ın controller property'sine bu değişkeni atayarak kullanıyoruz.
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          log(Provider.of<MyThemeData>(context,listen: false).themeColor.toString());
//*Alttan çıkan menü gibi birşey. Bunun içine istediğin dizaynı yaparak kullanıyorsun. Sen ne oluşturursan alttan o geliyor.
          showModalBottomSheet(
//*bunu false yapınca klavyenin altında kalıyor kutu. Sebebini anlamadım.
            isScrollControlled: true,

//*alttan açıldığında arkaplanda kalan kısmı ayarlıyor. Devaultunda hafif karartma oluyor. Bu şekilde biz de direk ayarlayabiliyoruz.
            barrierColor: Theme.of(context).primaryColor.withOpacity(0.8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            context: context,
            builder: (context) => FractionallySizedBox(
//*Şu an isScrollControlled true iken fractional ile factor vererek ayarlama yapabiliyorum. Ama daha güzel bir çözüm bulunabilir.
//*Alttaki textbox max satır sayısını 1 yapınca sıkıntı çıkmıyor ama gerekli olursa diye fractional sarmalamasını kaldırmadım. factor vermeyince bir değişiklik yapmıyor zaten.
              //heightFactor: 0.7,
              child: Container(
//*klavye açıldığında altta kalmasın diye viewInsets ile alt taraftaki görüntü kadar boşluk ver diyoruz.
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
//*Bu sayede elevatedbutton iki yana yaslanarak ekranı kapladı.
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        //expands: true,
                        minLines: 1,
//*kaç satır yazarsak ekranda o kadar satır gösteriyor ama daha fazla yazılabiliyor. Ekranda görünmüyor sadece. Fakat bunu arttırdığımızda ekranda taşma sıkıntıları oluyor. O yüzden 1 olarak tutması daha mantıklı gibi. Ya da singlechildscrollview ile de sarmalanabilir çözüm olarak.
                        maxLines: 1,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        decoration: InputDecoration(
                          /* border: OutlineInputBorder(borderSide: BorderSide(
                                color: Provider.of<MyThemeData>(context)
                                    .themeColor),
                          ), */
                          labelText: 'Görev Ekleyin',
                          labelStyle: TextStyle(
                              color:
                                  Provider.of<MyThemeData>(context).themeColor),
                          hintText: '...',
                          hintStyle: TextStyle(
                              color:
                                  Provider.of<MyThemeData>(context).themeColor),
                          //helperText: 'Görev Ekleyin', //*textfield'în alt tarafına metin ekliyor.
                        ),
//*En üstte oluşturduğumuz control nesnesini burada atıyoruz.
                        controller: textController,
//*Açıldığı an imlecin üzerinde olmasını sağlıyor.
                        autofocus: true,
                        onChanged: (input) {},
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      ElevatedButton(
                        onPressed: () {
//*MissionData'daki addMission metodunu provider vasıtası ile tetikliyoruz. listen false yapıyoruz çünkü bu dinleyen değil iş yaptıran bir komut. bu metoda TextField'da yazılı olan metini yani textController.text'i atıyoruz.
                          Provider.of<MissionData>(context, listen: false)
                              .addMission(textController.text);
                          
//*Bu komutla TextField penceresindeki yazılan karakterleri temizliyoruz. Yoksa ikinci görev için tekrar açtığımızda aynı yazılar yeniden geliyor.
                          textController.clear();
//*göre eklemek için tuşa bastığımızda otomatik olarak ekranı kapatarak görevler ekranına dönülmesini sağlıyor.
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          'Add',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
//*Settings sayfasına geçmek için verilen Navigator komutu.
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SettingsPage()));
            },
            icon: Icon(
              color: Colors.white,
              Icons.settings,
              size: 40,
            ),
            padding: EdgeInsets.only(right: 30),
          )
        ],
        centerTitle: true,
        title: Text(
          'Get It Done',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                '${Provider.of<MissionData>(context).missions.length} Items',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Align(
                alignment: Alignment.topCenter,
                child: ListView.builder(
//*Son eklenen görevin üst tarafa gelmesi için reverse true yaptık ama bu sefer de görevler yukarıda değil altta oluyordu. Bu nedenle align ile sarmalayıp topcenter dedik. Ama bunun çalışması için shrinkwrap de true yapılmak zorunda. Yoksa işe yaramıyor.
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: Provider.of<MissionData>(context).missions.length,
                  itemBuilder: ((context, index) => ItemCard(
                        Provider.of<MissionData>(context).missions[index].title,
                        Provider.of<MissionData>(context)
                            .missions[index]
                            .isDone,
//*alttaki isimsiz fonksiyonu ItemCard'ta tanımladığımız 3. parametre bool alan bir fonksiyon olduğu için(onChanged de kullanıldığı için) aşağıdaki gibi bool değer alan bir fonksiyon şeklinde tanımladık ve o değeri kullanmadığımız için de _ koyarak geçtik.
                        (_) {
                          Provider.of<MissionData>(context, listen: false)
                              .missionStatus(index);
                        },
                        (_) {
                          Provider.of<MissionData>(context, listen: false)
                              .deleteMission(index);
                        },
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
