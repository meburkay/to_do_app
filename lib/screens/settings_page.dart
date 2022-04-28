// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/models/my_theme_data.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Color Picker',
          style: Theme.of(context).textTheme.headline3,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*.05,),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Provider.of<MyThemeData>(context).themeColor,
                ),
              ),
              ElevatedButton(
                  onPressed: () => pickColor(context),
                  child: Text('Pick Color'))
            ],
          ),
        ),
      ),
    );
  }

  pickColor(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Pick Your Color'),
            content: Column(
              children: [
                ColorPicker(enableAlpha: false,//*Saydamlık ayarlama özelliğini kapatıyor.
                
                  onColorChanged: (Color value) {
                    Provider.of<MyThemeData>(context, listen: false)
                        .changeThemeColor(value);

                    
                  },
                  pickerColor: Provider.of<MyThemeData>(context).themeColor,
                ),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('SELECT')),
              ],
            ),
          ));
}
