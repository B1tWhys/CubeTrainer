import 'dart:collection';

class Setting<T> {
  final String displayName;
  T value;

  Setting(this.displayName, this.value);
}

class Settings {
  LinkedHashMap<String, Setting> settings = LinkedHashMap.fromEntries([
    MapEntry("nSplits", Setting<int>("Splits", 1)),
    MapEntry("inspection", Setting<bool>("Inspection", false)),
    MapEntry("inspectionTime", Setting<int>("Inspection Time", 15)),
  ]);
}
