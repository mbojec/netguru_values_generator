import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:quotes_generator/components/back_nav_btn.dart';
import 'package:quotes_generator/components/bottom_bar.dart';
import 'package:quotes_generator/screens/settings/components/theme_switch.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        leading: BackNavBtn(),
        centerTitle: true,
        title: const Text('Settings'),
      ),
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[const SizedBox(height: 32.0), ThemeSwitch()],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
