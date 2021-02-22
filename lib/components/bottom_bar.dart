import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:quotes_generator/constants.dart';
import 'package:quotes_generator/theme/styles.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: bottomNavigationBarStyle(context),
      child: SizedBox(
        height:
            MediaQuery.of(context).size.width > Dimensions.screenSizeBreakpoint
                ? Dimensions.bottomBarLargeScreen
                : Dimensions.bottomBarSmallScreen,
      ),
    );
  }
}
