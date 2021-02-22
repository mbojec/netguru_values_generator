import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:quotes_generator/components/btn.dart';

class BackNavBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (NeumorphicTheme.isUsingDark(context)) {
      return bumpButton(Icons.arrow_back_ios_rounded, () {
      Navigator.of(context).pop();
    }, context);
    } else {
      return concaveButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        context: context,
        icon: Icons.arrow_back_ios_rounded);
    }
  }
}
