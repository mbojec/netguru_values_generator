import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:netguru_values_generator/components/animated_btn.dart';
import 'package:netguru_values_generator/constants.dart';
import 'package:netguru_values_generator/main.dart';
import 'package:netguru_values_generator/screens/home/components/animated_quote_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> values = <String>["Exceed clients' and colleagues' expectations", 'Take ownership and question the status quo in a constructive manner',
    'Be brave, curious and experiment. Learn from all successes and failures', 'Act in a way that makes all of us proud',
    'Build an inclusive, transparent and socially responsible culture', 'Be ambitious, grow yourself and the people around you', 'Recognize excellence and engagement'];
  bool isFavorite = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        centerTitle: true,
        title: NeumorphicText(
          'NG Values',
          textStyle: NeumorphicTextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold
          ),
          style: const NeumorphicStyle(
              depth: 0,
              color: Color(0xFFc2c6e0)
          ),
        ),
        actions: <Widget>[
          AnimatedBtn(
              onTap: (){
                logger.i('Print');
              },
              enableReverseAnimation: true,
              animationCallback: (AnimationStatus status){
                if (status == AnimationStatus.completed) {
                  setState(() {
                    isFavorite = true;
                  });
                } else if (status == AnimationStatus.dismissed) {
                  setState(() {
                    isFavorite = false;
                  });
                }
              },
              icon: isFavorite ? Icons.favorite : Icons.favorite_border)
          // LikeBtn()
        ],
      ),
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 500),
              ),
          items: values.map((String quote) {
            return Builder(
              builder: (BuildContext context) {
                return AnimatedQuoteCard(cardValue: quote);
              },
            );
          }).toList(),
        ),
      ),
      floatingActionButton: NeumorphicButton(
        onPressed: (){
          Navigator.of(context).pushNamed(RouteList.editor);
        },
        style: const NeumorphicStyle(
          boxShape: NeumorphicBoxShape.circle(),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Icon(Icons.add, color: NeumorphicTheme.variantColor(context)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Neumorphic(
        style: NeumorphicStyle(
            boxShape: const NeumorphicBoxShape.rect(),
            depth: -NeumorphicTheme.depth(context),
            lightSource: LightSource.topLeft,
            color: NeumorphicTheme.variantColor(context)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 56.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamed(RouteList.list);
                      },
                      child: NeumorphicIcon(
                        Icons.list,
                        style: NeumorphicStyle(
                            depth: NeumorphicTheme.depth(context),
                            color: NeumorphicTheme.baseColor(context)
                        ),
                        size: 32.0,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamed(RouteList.favorite);
                      },
                      child: NeumorphicIcon(
                        Icons.favorite,
                        style: NeumorphicStyle(
                            depth: NeumorphicTheme.depth(context),
                            color: NeumorphicTheme.baseColor(context)
                        ),
                        size: 32.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24.0)
          ],
        ),
      ),
    );
  }
}