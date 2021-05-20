import 'dart:io';

import 'package:boats_challenge/Bloc/dark_mode_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      kIsWeb
                          ? Icons.arrow_back
                          : Platform.isAndroid
                              ? Icons.arrow_back
                              : Icons.arrow_back_ios,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Settings",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "DarkTheme",
                    style: TextStyle(fontSize: 20),
                  ),
                  Switch(
                      value:
                          StateManagmentInhereted.of(context).isDark.isDarkMode,
                      onChanged: (value) {
                        StateManagmentInhereted.of(context)
                            .isDark
                            .updateThemeMode(value);
                        SystemChrome.setSystemUIOverlayStyle(
                            SystemUiOverlayStyle(
                                statusBarIconBrightness: value
                                    ? Brightness.light
                                    : Brightness.dark));
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
