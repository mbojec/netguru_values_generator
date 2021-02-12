import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:netguru_values_generator/components/btn.dart';
import 'package:netguru_values_generator/storage/internal.dart';
import 'package:netguru_values_generator/theme/styles.dart';

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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text('App Theme', style: Theme.of(context).textTheme.bodyText1.copyWith(color: NeumorphicTheme.defaultTextColor(context))),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Container(
                          margin:const EdgeInsets.only(right: 16.0),
                          child: Icon(Icons.wb_sunny, color: NeumorphicTheme.of(context).isUsingDark ? NeumorphicTheme.defaultTextColor(context) : NeumorphicTheme.accentColor(context))),
                      Expanded(
                        child: NeumorphicSwitch(
                          value: NeumorphicTheme.of(context).isUsingDark,
                          style: NeumorphicSwitchStyle(
                            activeTrackColor: NeumorphicTheme.accentColor(context),
                            inactiveTrackColor: NeumorphicTheme.variantColor(context)
                          ),
                          onChanged: (bool value){
                            if(value){
                              NeumorphicTheme.of(context).themeMode = ThemeMode.dark;
                            } else {
                              NeumorphicTheme.of(context).themeMode = ThemeMode.light;
                            }
                            InternalStorage().isUsingDark = value;
                          },
                        ),
                      ),
                      Container(
                          margin:const EdgeInsets.only(left: 16.0),
                          child: Icon(Icons.nightlight_round, color: NeumorphicTheme.of(context).isUsingDark ? NeumorphicTheme.accentColor(context) : NeumorphicTheme.defaultTextColor(context))),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Neumorphic(
        style: bottomNavigationBarStyle(context),
        child: SizedBox(height: MediaQuery.of(context).size.width > 375.0 ? 80.0 : 56.0)
      ),
    );
  }
}
