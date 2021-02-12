import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';


class QuoteCard extends StatelessWidget {
  final String value;
  const QuoteCard({@required this.value});

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
          depth: NeumorphicTheme.embossDepth(context),
          color: NeumorphicTheme.variantColor(context)
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints (maxHeight: MediaQuery.of(context).size.height * 0.5, minHeight: MediaQuery.of(context).size.height * 0.25),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            heightFactor: 1.0,
            child: NeumorphicText(
              value,
              textStyle: NeumorphicTextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Orbitron'
              ),
              style: NeumorphicStyle(
                  depth: NeumorphicTheme.depth(context),
                  color: const Color(0xFFe8eafa)
              ),
            ),
          ),
        ),
      ),
    );
  }
}