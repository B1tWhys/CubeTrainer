import 'dart:collection';

import 'package:flutter/foundation.dart';

class Setting<T> extends ChangeNotifier {
  final String displayName;
  final bool enabled;

  T _value;
  T get value => _value;

  set value(T newValue) {
    _value = newValue;
    notifyListeners();
  }

  Setting(this.displayName, this._value, this.enabled);
}

class Settings {
  LinkedHashMap<String, Setting> settings = LinkedHashMap.fromEntries([
    MapEntry("nSplits", Setting<int>("Splits", 1, true)),
    MapEntry("inspection", Setting<bool>("Inspection", false, false)),
    MapEntry("inspectionTime", Setting<int>("Inspection Time", 15, false)),
    MapEntry("scrambleLen", Setting<int>("Scramble Length", 15, true)),
  ]);
}
