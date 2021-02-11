import 'package:flutter/widgets.dart';
import 'package:netguru_values_generator/main.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AnimatedQuoteCard extends StatefulWidget {
  final String cardValue;
  const AnimatedQuoteCard({@required this.cardValue});

  @override
  _AnimatedQuoteCardState createState() => _AnimatedQuoteCardState();
}

class _AnimatedQuoteCardState extends State<AnimatedQuoteCard>  with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _cardDepthAnimation, _textDepthAnimation;
  Animation<Color> _textColorAnimation, _cardColorAnimation;

  @override
  void initState() {
    // logger.i('Initial state');
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        // logger.i('Animation has finished');
      }
    }
    );

    _cardDepthAnimation = Tween<double>(
      begin: 0.0,
      end: -20.0,
    ).animate(_animationController);

    _textDepthAnimation = Tween<double>(
      begin: 0.0,
      end: 20.0,
    ).animate(_animationController);

    _textColorAnimation = ColorTween(begin: const Color(0xFFc2c6e0), end: const Color(0xFFe8eafa)).animate(_animationController);
    _cardColorAnimation = ColorTween(begin: const Color(0xFFe8eafa), end: const Color(0xFFc2c6e0)).animate(_animationController);

    Future<void>.delayed(const Duration(milliseconds: 1500),(){
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
    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, __){
        return Neumorphic(
          style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              depth: _cardDepthAnimation.value,
              color: _cardColorAnimation.value
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints (maxHeight: MediaQuery.of(context).size.height * 0.5, minHeight: MediaQuery.of(context).size.height * 0.25),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Center(
                heightFactor: 1.0,
                child: NeumorphicText(
                  widget.cardValue,
                  textStyle: NeumorphicTextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  style: NeumorphicStyle(
                      depth: _textDepthAnimation.value,
                      color: _textColorAnimation.value
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
