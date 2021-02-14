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

TextStyle infoTextStyle(BuildContext context){
  return TextStyle(color: NeumorphicTheme.defaultTextColor(context), fontSize: 18.0, fontFamily: 'Orbitron');
}

TextStyle errorTextStyle(){
  return const TextStyle(color: Colors.red, fontSize: 18.0, fontFamily: 'Orbitron');
}

TextStyle inputTextStyle(BuildContext context){
  return TextStyle(color: NeumorphicTheme.defaultTextColor(context), fontWeight: FontWeight.bold, fontSize: 18.0, fontFamily: 'Orbitron');
}