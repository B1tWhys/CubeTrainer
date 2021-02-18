import 'package:cubetrainer/model/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({Key key}) : super(key: key);

  Widget intInputWidget(Setting<int> setting) => Expanded(
        child: TextFormField(
          initialValue: setting.value.toString(),
          onChanged: (String newValue) {
            try {
              setting.value = int.parse(newValue);
            } on FormatException {
              return;
            }
          },
          keyboardType: TextInputType.number,
          textAlign: TextAlign.right,
        ),
      );

  Widget boolInputWidget(Setting<bool> setting) => Align(
        child: Switch(
          value: setting.value,
          onChanged: (bool newValue) => setting.value = newValue,
        ),
        alignment: Alignment.centerRight,
      );

  Widget settingWidget(Setting setting) {
    Widget inputWidget;
    switch (setting.value.runtimeType) {
      case int:
        inputWidget = intInputWidget(setting);
        break;
      case bool:
        inputWidget = boolInputWidget(setting);
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
    Settings settings = Provider.of<Settings>(context);
    return ListView(
      children: settings.settings.entries.map((MapEntry<String, Setting> e) {
        Setting setting = e.value;
        return ChangeNotifierProvider.value(
          value: setting,
          child: Consumer<Setting>(
            builder: (_, setting, child) => settingWidget(setting),
          ),
        );
      }).toList(),
      padding: EdgeInsets.all(10),
    );
  }
}
