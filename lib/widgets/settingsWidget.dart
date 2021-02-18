import 'package:cubetrainer/model/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({Key key}) : super(key: key);

  Widget intInputWidget(
          Function(Object) callback, String settingName, int currentValue) =>
      Expanded(
        child: TextFormField(
          initialValue: currentValue.toString(),
          onChanged: (String newValue) => callback(int.parse(newValue)),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.right,
        ),
      );

  Widget boolInputWidget(
          Function(Object) callback, String settingName, bool currentValue) =>
      Align(
        child: Switch(
          value: currentValue,
          onChanged: callback,
        ),
        alignment: Alignment.centerRight,
      );

  Widget floatInputWidget(
          Function(Object) callback, String settingName, double currentValue) =>
      Expanded(
        child: TextFormField(
          initialValue: currentValue.toString(),
          textAlign: TextAlign.right,
          onChanged: (String newValue) => callback(double.parse(newValue)),
        ),
      );

  Widget settingWidget(Function(Object) callback, Setting setting) {
    Widget inputWidget;
    switch (setting.value.runtimeType) {
      case int:
        inputWidget =
            intInputWidget(callback, setting.displayName, setting.value);
        break;
      case bool:
        inputWidget =
            boolInputWidget(callback, setting.displayName, setting.value);
        break;
      default:
        return Container(
          color: Colors.red,
          child: SizedBox(width: 100, height: 30),
        );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 3, top: 3),
      child: Row(
        children: [
          Text(setting.displayName + ":"),
          SizedBox(width: 10),
          inputWidget,
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(builder: (context, settings, _) {
      return ListView(
        children: settings.entries
            .map((MapEntry e) => settingWidget(
                  (Object newVal) => settings[e.key] = newVal,
                  e.value,
                ))
            .toList(),
        padding: EdgeInsets.all(10),
      );
    });
  }
}
