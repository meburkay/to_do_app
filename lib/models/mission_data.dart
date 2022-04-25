import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './mission.dart';

//*Görev datalarını tutacağım classı oluşturdum ve bu datalardaki değişiklikleri provider ile yayınlayabilmek için ChangeNotifier classını with ile ekledim.
class MissionData with ChangeNotifier {
  List<Mission> missions = [];
  static SharedPreferences? _sp;

  MissionData() {
    spGet();
  }

//*Görev kartının checkboxı için kullanacağımız statuyu değiştirmek için ilgili missiona ait değiştirme fonksiyonunu çağırdım.
  void missionStatus(int index) {
    missions[index].missionStatus();
    spSet();
    notifyListeners(); //*Bu fonksiyon çok önemli. Bu metod ile MissionData içinde değişiklik yaptığımız için sanki setState kullanır gibi bu fonksiyonu yazıyoruz ve o da dinleyenleri uyararak kendilerini güncellemelerini sağlıyor.
  }

  void addMission(String title) {
    missions.add(Mission(title));
    spSet();
    notifyListeners();
  }

  void deleteMission(int index) {
    missions.removeAt(index);
    spSet();
    notifyListeners();
  }

//*SHAREDPREFERENCES METODLARI

  Future<void> spCreate() async {
    _sp = await SharedPreferences.getInstance();
  }

  void spGet() {
    List<String>? cevirici = _sp?.getStringList('jsonString');
    if (cevirici != null) {
      for (var item in cevirici) {
        Map setMap = jsonDecode(item);
        missions.add(Mission(setMap['title'], isDone: setMap['isDone']));
      }
    }
  }

  void spSet() {
    List<String> cevirici = [];
    for (var map in missions) {
      Map missionMap = {'title': map.title, 'isDone': map.isDone};
      cevirici.add(jsonEncode(missionMap));
    }
    _sp?.setStringList('jsonString', cevirici);
  }
}
