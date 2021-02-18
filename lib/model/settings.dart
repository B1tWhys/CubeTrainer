import 'dart:collection';

import 'package:flutter/foundation.dart';

class Setting<T> {
  final String displayName;
  T value;

  Setting(this.displayName, this.value);
}

class Settings extends ChangeNotifier {
  LinkedHashMap<String, Setting> _settings = LinkedHashMap.fromEntries([
    MapEntry("nSplits", Setting<int>("Splits", 1)),
    MapEntry("inspection", Setting<bool>("Inspection", false)),
    MapEntry("inspectionTime", Setting<int>("Inspection Time", 15)),
    MapEntry("scrambleLen", Setting<int>("Scramble Length", 15)),
  ]);

  Setting operator [](String k) => _settings[k];
  void operator []=(String k, Object v) {
    print("updating setting: $k with value: $v");
    _settings[k].value = v;
    notifyListeners();
  }

  Iterable<MapEntry<String, Setting>> get entries => _settings.entries;
}
