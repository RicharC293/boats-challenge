import 'package:flutter/widgets.dart';

class DarkModeState extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => this._isDarkMode;
  void updateThemeMode(bool value) {
    this._isDarkMode = value;
    notifyListeners();
  }
}

class StateManagmentInhereted extends InheritedWidget {
  final Widget child;
  final DarkModeState isDark;

  StateManagmentInhereted({@required this.child, this.isDark});

  static StateManagmentInhereted of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
