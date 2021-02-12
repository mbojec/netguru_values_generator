import 'dart:ui';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';

const Color _lightBaseColor = Color(0xFFe8eafa);
const Color _lightTextColor = Color(0xFFc2c6e0);
const Color _lightVariantColor = Color(0xFFc2c6e0);
const Color _darkBaseColor = Color(0xFF35393e);
const Color _darkTextColor = Color(0xFF8a8c8f);
const Color _darkVariantColor = Color(0xFF212529);
const Color _accentColor = Color(0xFF00d563);

TextTheme _buildTextTheme(BuildContext context) {
  return const TextTheme(
    headline5: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Orbitron'),
    bodyText1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, fontFamily: 'Orbitron')
  );
}

NeumorphicAppBarIcons _buildNeumorphicAppBarIcons(BuildContext context, bool isDarkTheme){
  return NeumorphicAppBarIcons(
    backIcon: Icon(Icons.arrow_back_ios_rounded, color: isDarkTheme ? _darkTextColor:_lightTextColor)
  );
}

NeumorphicAppBarThemeData _buildNeumorphicAppBarThemeData(BuildContext context, bool isDarkTheme) {
  return NeumorphicAppBarThemeData(
    centerTitle: true,
    textStyle: TextStyle(fontSize: 24, color: isDarkTheme ? _darkTextColor:_lightTextColor, fontWeight: FontWeight.bold, fontFamily: 'Orbitron'),
    icons: _buildNeumorphicAppBarIcons(context, isDarkTheme),
    buttonStyle: NeumorphicStyle(
        boxShape: const NeumorphicBoxShape.circle(),
        depth: 10.0,
        lightSource: LightSource.topLeft,
        color: isDarkTheme ? _darkBaseColor: _lightBaseColor
    )
  );
}


NeumorphicThemeData buildLightThemeData (BuildContext context){
  return NeumorphicThemeData(
    baseColor: _lightBaseColor,
    variantColor: _lightVariantColor,
    accentColor: _accentColor,
    depth: 20,
    defaultTextColor: _lightTextColor,
    textTheme: _buildTextTheme(context),
    appBarTheme: _buildNeumorphicAppBarThemeData(context, false),
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
    iconTheme: const IconThemeData(color: _lightTextColor, size: 24),
    buttonStyle: const NeumorphicStyle(
      boxShape: NeumorphicBoxShape.circle(),
    ),
  );
}

NeumorphicThemeData buildDarkThemeData (BuildContext context){
  return NeumorphicThemeData(
    // lightSource: LightSource.topRight,
    intensity: 0.3,
    baseColor: _darkBaseColor,
    variantColor: _darkVariantColor,
    accentColor: _accentColor,
    depth: 20,
    defaultTextColor: _darkTextColor,
    textTheme: _buildTextTheme(context),
    appBarTheme: _buildNeumorphicAppBarThemeData(context, true),
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
    iconTheme: const IconThemeData(color: _darkTextColor, size: 24),
    buttonStyle: const NeumorphicStyle(
      boxShape: NeumorphicBoxShape.circle(),
    ),
  );
}



