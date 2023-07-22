import 'package:flutter/material.dart';
import 'package:gallery/constants/colors.dart';

class AppTheme{
  static ThemeData theme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
  backgroundColor: black,
  actionsIconTheme: const IconThemeData(color: Colors.white),
  iconTheme: const IconThemeData(color: Colors.white)),
  brightness: Brightness.light,
  primaryColor: black,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}