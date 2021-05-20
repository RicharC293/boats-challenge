import 'package:boats_challenge/Bloc/dark_mode_state.dart';
import 'package:boats_challenge/UI/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final darkMode = DarkModeState();
  @override
  Widget build(BuildContext context) {
    return StateManagmentInhereted(
      isDark: darkMode,
      child: AnimatedBuilder(
        animation: darkMode,
        builder: (_, __) => MaterialApp(
          title: 'Boats UI challenge',
          theme: darkMode.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: Home(),
        ),
      ),
    );
  }
}
