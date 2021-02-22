import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:quotes_generator/theme/theme.dart';
import 'package:quotes_generator/theme/styles.dart';
import 'package:quotes_generator/models/quote.dart';

class QuoteCard extends StatelessWidget {
  final Quote value;

  const QuoteCard({@required this.value});

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
        depth: NeumorphicTheme.embossDepth(context),
        color: NeumorphicTheme.variantColor(context),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.5,
          minHeight: MediaQuery.of(context).size.height * 0.25,
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            heightFactor: 1.0,
            child: NeumorphicText(
              value.content,
              textStyle: cardTextStyle(),
              style: NeumorphicStyle(
                depth: NeumorphicTheme.depth(context),
                color: lightBaseColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
