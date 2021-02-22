import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:quotes_generator/constants.dart';
import 'package:quotes_generator/theme/styles.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: bottomNavigationBarStyle(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 56.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      Navigator.of(context).pushNamed(RouteList.list);
                    },
                    child: NeumorphicIcon(
                      Icons.list,
                      style: navigationBtnStyle(context),
                      size: 32.0,
                    ),
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      Navigator.of(context).pushNamed(RouteList.favorite);
                    },
                    child: NeumorphicIcon(
                      Icons.favorite,
                      style: navigationBtnStyle(context),
                      size: 32.0,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.width >
                  Dimensions.screenSizeBreakpoint
                  ? 24.0
                  : 0.0)
        ],
      ),
    );
  }
}
