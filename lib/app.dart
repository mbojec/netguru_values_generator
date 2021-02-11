import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:netguru_values_generator/route.dart';
import 'package:netguru_values_generator/screens/home/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: const NeumorphicThemeData(
        baseColor: Color(0xFFe8eafa),
        variantColor: Color(0xFFc2c6e0),
        accentColor: Color(0xFF00d563),
        depth: 20,
      ),
      // darkTheme: const NeumorphicThemeData(
      //   baseColor: Color(0xFF3E3E3E),
      //   depth: 6,
      // ),
      home: CustomSplash(
        imagePath: 'assets/images/ic_launcher.png',
        backGroundColor: Colors.grey,
        logoSize: 50,
        duration: 2000,
        home: const HomeScreen(),
      ),
      onGenerateRoute: Routes.getRouteGenerate,
    );
  }
}
