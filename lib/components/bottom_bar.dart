import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:netguru_values_generator/theme/styles.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Neumorphic(
        style: bottomNavigationBarStyle(context),
        child: SizedBox(height: MediaQuery.of(context).size.width > 375.0 ? 80.0 : 56.0)
    );
  }
}
