import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AnimatedProgressIndicator extends StatefulWidget {
  final AnimationController _animationController;

  @override
  _AnimatedProgressIndicatorState createState() =>
      _AnimatedProgressIndicatorState();

  const AnimatedProgressIndicator(this._animationController);
}

class _AnimatedProgressIndicatorState extends State<AnimatedProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget._animationController,
      builder: (_, __) {
        return NeumorphicIndicator(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 15,
          orientation: NeumorphicIndicatorOrientation.horizontal,
          percent: widget._animationController.value,
          style: IndicatorStyle(
            accent: NeumorphicTheme.accentColor(context),
            variant: NeumorphicTheme.accentColor(context),
          ),
        );
      },
    );
  }
}
