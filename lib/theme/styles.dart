import 'package:flutter_neumorphic/flutter_neumorphic.dart';

NeumorphicStyle navigationBtnStyle(BuildContext context){
  return NeumorphicStyle(
      depth: NeumorphicTheme.depth(context),
      color: NeumorphicTheme.isUsingDark(context) ? const Color(0xFF8a8c8f) : NeumorphicTheme.baseColor(context)
  );
}

NeumorphicStyle bottomNavigationBarStyle(BuildContext context){
  return NeumorphicStyle(
      boxShape: const NeumorphicBoxShape.rect(),
      depth: NeumorphicTheme.embossDepth(context),
      color: NeumorphicTheme.variantColor(context)
  );
}