import 'package:cubetrainer/model/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsDialog extends StatelessWidget {
  final Settings settings;

  const SettingsDialog(this.settings, {Key key}) : super(key: key);

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
            enabled: setting.enabled),
      );

  Widget boolInputWidget(Setting<bool> setting) {
    Function onChanged =
        setting.enabled ? (bool newValue) => setting.value = newValue : null;
    return Align(
      child: Switch(
        value: setting.value,
        onChanged: onChanged,
      ),
      alignment: Alignment.centerRight,
    );
  }

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

    return Row(
      children: [
        Text(setting.displayName + ":"),
        SizedBox(width: 10),
        inputWidget,
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(5),
      children: [
        ...settings.settings.entries.expand((MapEntry<String, Setting> e) {
          Setting setting = e.value;
          return [
            ChangeNotifierProvider.value(
              value: setting,
              child: Consumer<Setting>(
                builder: (_, setting, child) => settingWidget(setting),
              ),
            ),
            Divider(),
          ];
        }).toList(),
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
            return FirebaseAuth.instance.signOut();
          },
          child: Text("Sign out"),
        ),
      ],
    );
  }
}
