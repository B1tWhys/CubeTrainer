import 'package:cubetrainer/model/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(builder: (context, settingsProvider, _) {
      return ListView(
        children: settingsProvider.settings.entries
            .map((MapEntry e) => SettingWidget(e.value))
            .toList(),
        padding: EdgeInsets.all(10),
      );
    });
  }
}

class SettingWidget extends StatefulWidget {
  final Setting _setting;
  const SettingWidget(this._setting, {Key key}) : super(key: key);

  @override
  _SettingWidgetState createState() => _SettingWidgetState(_setting);
}

class _SettingWidgetState extends State<SettingWidget> {
  final Setting _setting;

  _SettingWidgetState(this._setting);

  Widget intInputWidget() => Expanded(
        child: TextFormField(
          initialValue: _setting.value.toString(),
          onChanged: (String newValue) {
            _setting.value = int.tryParse(newValue) ?? _setting.value;
          },
          keyboardType: TextInputType.number,
          textAlign: TextAlign.right,
        ),
      );

  Widget boolInputWidget() => Align(
        child: Switch(
            value: _setting.value,
            onChanged: (bool v) {
              setState(() {
                _setting.value = v;
              });
            }),
        alignment: Alignment.centerRight,
      );

  Widget floatInputWidget() => Expanded(
        child: TextFormField(
          initialValue: _setting.value.toString(),
          textAlign: TextAlign.right,
          onChanged: (String newValue) =>
              _setting.value = double.tryParse(newValue) ?? _setting.value,
        ),
      );

  @override
  Widget build(BuildContext context) {
    Widget inputWidget;
    switch (_setting.value.runtimeType) {
      case int:
        inputWidget = intInputWidget();
        break;
      case bool:
        inputWidget = boolInputWidget();
        break;
      default:
        inputWidget = Container(
          color: Colors.red,
          child: SizedBox(
            height: 30,
            width: 100,
          ),
        );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 3, top: 3),
      child: Row(
        children: [
          Text(_setting.displayName + ":"),
          SizedBox(width: 10),
          inputWidget,
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}
