import 'dart:collection';

import 'package:flutter/foundation.dart';

class Setting<T> extends ChangeNotifier {
  final String displayName;

  T _value;
  T get value => _value;

  set value(T newValue) {
    _value = newValue;
    notifyListeners();
  }

  Setting(this.displayName, this._value);
}

class Settings {
  LinkedHashMap<String, Setting> settings = LinkedHashMap.fromEntries([
    MapEntry("nSplits", Setting<int>("Splits", 1)),
    MapEntry("inspection", Setting<bool>("Inspection", false)),
    MapEntry("inspectionTime", Setting<int>("Inspection Time", 15)),
    MapEntry("scrambleLen", Setting<int>("Scramble Length", 15)),
  ]);
}
