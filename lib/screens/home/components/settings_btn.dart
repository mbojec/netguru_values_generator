import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotes_generator/components/btn.dart';
import 'package:quotes_generator/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SettingsBtn extends StatelessWidget {
  final CarouselController carouselController;

  const SettingsBtn({@required this.carouselController});

  @override
  Widget build(BuildContext context) {
    if (NeumorphicTheme.isUsingDark(context)) {
      return bumpButton(
      Icons.settings,
          () {
        Navigator.of(context).pushNamed(RouteList.settings).then((_) {
          carouselController.nextPage(
              duration: const Duration(milliseconds: 1));
        });
      },
      context,
    );
    } else {
      return concaveButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RouteList.settings).then((_) {
            carouselController.nextPage(
                duration: const Duration(milliseconds: 1));
          });
        },
        context: context,
        icon: Icons.settings);
    }
  }
}
