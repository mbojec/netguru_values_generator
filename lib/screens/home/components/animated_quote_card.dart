import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:quotes_generator/blocs/quote/quote.dart';
import 'package:quotes_generator/constants.dart';
import 'package:quotes_generator/theme/theme.dart';
import 'package:quotes_generator/theme/styles.dart';
import 'package:quotes_generator/models/quote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimatedQuoteCard extends StatefulWidget {
  final List<Quote> quotes;
  final BuildContext context;

  const AnimatedQuoteCard({@required this.quotes, @required this.context});

  @override
  _AnimatedQuoteCardState createState() => _AnimatedQuoteCardState();
}

class _AnimatedQuoteCardState extends State<AnimatedQuoteCard>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _cardDepthAnimation, _textDepthAnimation;
  Animation<Color> _textColorAnimation, _cardColorAnimation;
  int randomValue;
  Quote value;

  @override
  void initState() {
    randomValue = Random().nextInt(widget.quotes.length - 1);
    value = widget.quotes[randomValue];
    context.read<QuoteCubit>().setQuote(value);
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {}
    });

    _cardDepthAnimation = Tween<double>(
      begin: Dimensions.baseDepth,
      end: -Dimensions.maxDepth,
    ).animate(_animationController);

    _textDepthAnimation = Tween<double>(
      begin: Dimensions.baseDepth,
      end: Dimensions.maxDepth,
    ).animate(_animationController);

    if (NeumorphicTheme.isUsingDark(widget.context)) {
      _textColorAnimation = ColorTween(
        begin: darkTextColor,
        end: lightBaseColor,
      ).animate(_animationController);

      _cardColorAnimation = ColorTween(
        begin: darkBaseColor,
        end: darkVariantColor,
      ).animate(_animationController);
    } else {
      _textColorAnimation = ColorTween(
        begin: lightTextColor,
        end: lightBaseColor,
      ).animate(_animationController);

      _cardColorAnimation = ColorTween(
        begin: lightBaseColor,
        end: lightTextColor,
      ).animate(_animationController);
    }

    Future<void>.delayed(const Duration(milliseconds: 1500), () {
      _animationController.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width * 0.8;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.5,
          minHeight: MediaQuery.of(context).size.height * 0.25,
        ),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (_, __) {
            return Neumorphic(
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(12),
                ),
                depth: _cardDepthAnimation.value,
                color: _cardColorAnimation.value,
              ),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: cardWidth,
                child: Center(
                  heightFactor: 1.0,
                  child: NeumorphicText(
                    value.content,
                    textStyle: cardTextStyle(),
                    style: NeumorphicStyle(
                      depth: _textDepthAnimation.value,
                      color: _textColorAnimation.value,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
