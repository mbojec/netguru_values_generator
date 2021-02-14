import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:netguru_values_generator/components/bottom_bar.dart';
import 'package:netguru_values_generator/components/btn.dart';
import 'package:netguru_values_generator/screens/settings/components/theme_switch.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        leading: NeumorphicTheme.isUsingDark(context) ? BumpButton(Icons.arrow_back_ios_rounded, (){
          Navigator.of(context).pop();
        }, context) : ConcaveButton(onPressed: (){
          Navigator.of(context).pop();
        }, context: context, icon: Icons.arrow_back_ios_rounded),
        centerTitle: true,
        title: const Text('Settings'),
      ),
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 32.0),
          ThemeSwitch()
        ],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
