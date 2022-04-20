import 'package:flutter/material.dart';

import './mission.dart';

//*Görev datalarını tutacağım classı oluşturdum ve bu datalardaki değişiklikleri provider ile yayınlayabilmek için ChangeNotifier classını with ile ekledim.
class MissionData with ChangeNotifier {
  List<Mission> missions = [];

//*Görev kartının checkboxı için kullanacağımız statuyu değiştirmek için ilgili missiona ait değiştirme fonksiyonunu çağırdım.
  void missionStatus(int index) {
    missions[index].missionStatus();
    notifyListeners(); //*Bu fonksiyon çok önemli. Bu metod ile MissionData içinde değişiklik yaptığımız için sanki setState kullanır gibi bu fonksiyonu yazıyoruz ve o da dinleyenleri uyararak kendilerini güncellemelerini sağlıyor.
  }

  void addMission(String title) {
    missions.add(Mission(title));
    notifyListeners();
  }

  void deleteMission(int index) {
    missions.removeAt(index);
    notifyListeners();
  }
}
