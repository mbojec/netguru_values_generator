import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:netguru_values_generator/route.dart';
import 'package:netguru_values_generator/screens/home/home_screen.dart';
import 'package:netguru_values_generator/storage/internal.dart';
import 'package:netguru_values_generator/theme/theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      themeMode: InternalStorage().isUsingDark ? ThemeMode.dark : ThemeMode.light,
      theme: buildLightThemeData(context),
      darkTheme: buildDarkThemeData(context),
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
