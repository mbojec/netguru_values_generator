import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:netguru_values_generator/main.dart';
import 'package:netguru_values_generator/storage/internal.dart';

class AnimatedBtn extends StatefulWidget {
  final Function() onTap;
  final Function(AnimationStatus) animationCallback;
  final IconData icon;
  final bool enableReverseAnimation;
  final BuildContext context;
  final Color activeColor;
  const AnimatedBtn({@required this.onTap, @required this.icon, this.animationCallback, this.enableReverseAnimation = false, @required this.context, @required this.activeColor});

  @override
  _AnimatedBtnState createState() => _AnimatedBtnState();
}

class _AnimatedBtnState extends State<AnimatedBtn> with SingleTickerProviderStateMixin {
  AnimationStatus status;
  AnimationController _animationController;
  Animation<double> _btnDepthAnimation, _iconDepthAnimation;
  Animation<Color> _btnColorAnimation, _iconColorAnimation;


  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _btnDepthAnimation = Tween<double>(
      begin: 20.0,
      end: -20.0,
    ).animate(_animationController);

    _iconDepthAnimation = Tween<double>(
      begin: 0.0,
      end: 20.0,
    ).animate(_animationController);

    _btnColorAnimation = ColorTween(begin: NeumorphicTheme.baseColor(widget.context), end: NeumorphicTheme.variantColor(widget.context)).animate(_animationController);
    _iconColorAnimation = ColorTween(begin: NeumorphicTheme.variantColor(widget.context), end: widget.activeColor).animate(_animationController);

    _animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
        if(widget.animationCallback != null){
          widget.animationCallback(status);
        }
        setState(() {
          this.status = status;
        });
      }
    }
    );
    super.initState();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    _btnColorAnimation = ColorTween(begin: NeumorphicTheme.baseColor(widget.context), end: NeumorphicTheme.variantColor(widget.context)).animate(_animationController);
    _iconColorAnimation = ColorTween(begin: NeumorphicTheme.variantColor(widget.context), end: widget.activeColor).animate(_animationController);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          if(widget.enableReverseAnimation){
            if(status != null && status == AnimationStatus.completed){
              _animationController.reverse();
            } else if(status != null && status == AnimationStatus.dismissed){
              _animationController.forward();
            } else {
              _animationController.forward();
            }
          } else {
            _animationController.forward();
          }
          widget.onTap();
        },
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (_, __){
            return Neumorphic(
              style: NeumorphicStyle(
                  shape: (status != null && status == AnimationStatus.completed) ? null : NeumorphicShape.flat,
                  boxShape: const NeumorphicBoxShape.circle(),
                  depth: _btnDepthAnimation.value,
                  lightSource: LightSource.topLeft,
                  color: _btnColorAnimation.value
              ),
              child: Center(
                  child: NeumorphicIcon(
                    widget.icon,
                    style: NeumorphicStyle(
                        depth: _iconDepthAnimation.value,
                        color: _iconColorAnimation.value
                    ),
                  )
                // Icon(Icons.favorite_border_outlined, color: tap ? Colors.red : Colors.grey),
              ),
            );
          },
        )
    );
  }
}
