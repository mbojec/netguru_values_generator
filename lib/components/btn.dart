import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

Widget bumpButton(IconData icon, Function() onPressed, BuildContext context) {
  return Neumorphic(
    drawSurfaceAboveChild: false,
    style: NeumorphicStyle(
      color: NeumorphicTheme.baseColor(context),
      depth: 10,
      boxShape: const NeumorphicBoxShape.circle(),
      intensity: 0.3,
      shape: NeumorphicShape.concave,
    ),
    child: NeumorphicButton(
        onPressed: () {
          onPressed();
        },
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.all(14.0),
        style: NeumorphicStyle(
          boxShape: const NeumorphicBoxShape.circle(),
          color: NeumorphicTheme.variantColor(context),
          depth: 0,
          shape: NeumorphicShape.convex,
        ),
        child: Icon(icon)),
  );
}

Widget concaveButton(
    {IconData icon, Function() onPressed, BuildContext context}){
  return GestureDetector(
    onTap: (){
     onPressed();
    },
    child: Neumorphic(
      style: NeumorphicStyle(
          boxShape: const NeumorphicBoxShape.circle(),
          depth: 20.0,
          lightSource: LightSource.topLeft,
          color: NeumorphicTheme.baseColor(context)
      ),
      child: Center(
          child: NeumorphicIcon(
            icon,
            style: NeumorphicStyle(
                depth: 0,
                color: NeumorphicTheme.variantColor(context)
            ),
          )
      ),
    ),
  );
}