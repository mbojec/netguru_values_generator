import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:quotes_generator/storage/internal.dart';

class ThemeSwitch extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              'App Theme',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: NeumorphicTheme.defaultTextColor(context)),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: Icon(
                    Icons.wb_sunny,
                    color: NeumorphicTheme.of(context).isUsingDark
                        ? NeumorphicTheme.defaultTextColor(context)
                        : NeumorphicTheme.accentColor(context),
                  ),
                ),
                Expanded(
                  child: NeumorphicSwitch(
                    value: NeumorphicTheme.of(context).isUsingDark,
                    style: NeumorphicSwitchStyle(
                      activeTrackColor: NeumorphicTheme.accentColor(context),
                      inactiveTrackColor: NeumorphicTheme.variantColor(context),
                    ),
                    onChanged: (bool value) {
                      if (value) {
                        NeumorphicTheme.of(context).themeMode = ThemeMode.dark;
                      } else {
                        NeumorphicTheme.of(context).themeMode = ThemeMode.light;
                      }
                      InternalStorage().isUsingDark = value;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16.0),
                  child: Icon(
                    Icons.nightlight_round,
                    color: NeumorphicTheme.of(context).isUsingDark
                        ? NeumorphicTheme.accentColor(context)
                        : NeumorphicTheme.defaultTextColor(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
