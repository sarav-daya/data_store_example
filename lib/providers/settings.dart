import 'package:data_store_example/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

class SettingsState {
  final bool isDarkMode;
  SettingsState({
    required this.isDarkMode,
  });

  factory SettingsState.initial() => SettingsState(isDarkMode: false);

  SettingsState copyWith({
    bool? isDarkMode,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}

class SettingsProvider extends ChangeNotifier {
  SettingsState _state = SettingsState.initial();
  SettingsState get state => _state;

  SettingsProvider({required bool isDarkMode})
      : _state = SettingsState(isDarkMode: isDarkMode);

  bool get darkMode {
    final box = Hive.box(kDatabaseName);
    return box.get('darkMode') ?? false;
  }

  toggleDarkMode() {
    _state = _state.copyWith(isDarkMode: !_state.isDarkMode);
    final box = Hive.box(kDatabaseName);
    box.put('darkMode', _state.isDarkMode);
    notifyListeners();
  }
}
