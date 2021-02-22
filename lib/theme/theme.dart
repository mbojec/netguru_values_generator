import 'dart:ui';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';

const Color lightBaseColor = Color(0xFFe8eafa);
const Color lightTextColor = Color(0xFFc2c6e0);
const Color lightVariantColor = Color(0xFFc2c6e0);
const Color darkBaseColor = Color(0xFF35393e);
const Color darkTextColor = Color(0xFF8a8c8f);
const Color darkVariantColor = Color(0xFF212529);
const Color accentColor = Color(0xFF00d563);

TextTheme _buildTextTheme(BuildContext context) {
  return const TextTheme(
    headline5: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'Orbitron',
    ),
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Orbitron',
    ),
  );
}

NeumorphicAppBarIcons _buildNeumorphicAppBarIcons(
    BuildContext context, bool isDarkTheme) {
  return NeumorphicAppBarIcons(
      backIcon: Icon(Icons.arrow_back_ios_rounded,
          color: isDarkTheme ? darkTextColor : lightTextColor));
}

NeumorphicAppBarThemeData _buildNeumorphicAppBarThemeData(
    BuildContext context, bool isDarkTheme) {
  return NeumorphicAppBarThemeData(
    centerTitle: true,
    textStyle: TextStyle(
      fontSize: 24,
      color: isDarkTheme ? darkTextColor : lightTextColor,
      fontWeight: FontWeight.bold,
      fontFamily: 'Orbitron',
    ),
    icons: _buildNeumorphicAppBarIcons(context, isDarkTheme),
    buttonStyle: NeumorphicStyle(
      boxShape: const NeumorphicBoxShape.circle(),
      depth: 10.0,
      lightSource: LightSource.topLeft,
      color: isDarkTheme ? darkBaseColor : lightBaseColor,
    ),
  );
}

NeumorphicThemeData buildLightThemeData(BuildContext context) {
  return NeumorphicThemeData(
    baseColor: lightBaseColor,
    variantColor: lightVariantColor,
    accentColor: accentColor,
    depth: 20,
    defaultTextColor: lightTextColor,
    textTheme: _buildTextTheme(context),
    appBarTheme: _buildNeumorphicAppBarThemeData(context, false),
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
    iconTheme: const IconThemeData(color: lightTextColor, size: 24),
    buttonStyle: const NeumorphicStyle(
      boxShape: NeumorphicBoxShape.circle(),
    ),
  );
}

NeumorphicThemeData buildDarkThemeData(BuildContext context) {
  return NeumorphicThemeData(
    // lightSource: LightSource.topRight,
    intensity: 0.3,
    baseColor: darkBaseColor,
    variantColor: darkVariantColor,
    accentColor: accentColor,
    depth: 20,
    defaultTextColor: darkTextColor,
    textTheme: _buildTextTheme(context),
    appBarTheme: _buildNeumorphicAppBarThemeData(context, true),
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
    iconTheme: const IconThemeData(color: darkTextColor, size: 24),
    buttonStyle: const NeumorphicStyle(
      boxShape: NeumorphicBoxShape.circle(),
    ),
  );
}
