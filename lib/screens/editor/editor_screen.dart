import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:netguru_values_generator/components/animated_btn.dart';

class EditorScreen extends StatefulWidget {
  @override
  _EditorScreenState createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> with SingleTickerProviderStateMixin {
  TextEditingController _controller;
  bool keyboardIsVisible = false;
  AnimationController _animationController;
  Animation<double> _cardDepthAnimation, _textDepthAnimation;
  Animation<Color> _textColorAnimation, _cardColorAnimation;
  String value = '';
  bool isSaving = false;
  @override
  void initState() {
    _controller = TextEditingController();
    KeyboardVisibilityNotification().addNewListener(
        onChange: (bool visible) {
          setState(() {
            keyboardIsVisible = visible;
          });
    },);

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        Future<void>.delayed(const Duration(milliseconds: 500), (){
          Navigator.of(context).pop();
        });
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

    super.initState();
  }

  void _saveValue(){
    value = _controller.text;
    setState(() {
      isSaving = true;
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: [GestureType.onTap, GestureType.onPanUpdateDownDirection],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: NeumorphicAppBar(
          leading: GestureDetector(
            onTap: (){
              if(!_animationController.isAnimating){
                Navigator.of(context).pop();
              }
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
                    Icons.arrow_back_ios_rounded,
                    style: NeumorphicStyle(
                        depth: 0,
                        color: NeumorphicTheme.variantColor(context)
                    ),
                  )
              ),
            ),
          ),
          centerTitle: true,
          title: NeumorphicText(
            'Editor',
            textStyle: NeumorphicTextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold
            ),
            style: const NeumorphicStyle(
                depth: 0,
                color: Color(0xFFc2c6e0)
            ),
          ),
        ),
        backgroundColor: NeumorphicTheme.baseColor(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Expanded(
              child: SizedBox(),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: double.infinity,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (_, __){
                      return Neumorphic(
                        style: NeumorphicStyle(
                            depth: _cardDepthAnimation.value,
                            color: _cardColorAnimation.value,
                          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                          border: NeumorphicBorder(
                              isEnabled: true, width: isSaving ? 0.0 : 1.0, color: NeumorphicTheme.variantColor(context)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: isSaving ? NeumorphicText(
                            value,
                            textStyle: NeumorphicTextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            style: NeumorphicStyle(
                                depth: _textDepthAnimation.value,
                                color: _textColorAnimation.value
                            ),
                          ):TextField(
                            cursorColor: NeumorphicTheme.accentColor(context),
                            autofocus: true,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: TextStyle(color: NeumorphicTheme.variantColor(context), fontWeight: FontWeight.bold, fontSize: 18.0),
                            textAlign: TextAlign.center,
                            onChanged: (String value){},
                            controller: _controller,
                            decoration: InputDecoration.collapsed(hintText: 'Space for you...', hintStyle: TextStyle(color: NeumorphicTheme.variantColor(context), fontWeight: FontWeight.bold, fontSize: 18.0)),
                          ),
                        ),
                      );
                    }
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: isSaving ? AnimatedBuilder(
                  animation: _animationController,
                  builder: (_, __){
                    return NeumorphicIndicator(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 15,
                      orientation:NeumorphicIndicatorOrientation.horizontal,
                      percent: _animationController.value,
                      style: IndicatorStyle(
                        accent: NeumorphicTheme.accentColor(context),
                        variant: NeumorphicTheme.accentColor(context),
                      ),
                    );
                  },
                ) : null,
              ),
            ),
          ],
        ),
        floatingActionButton: Container(
          width: 56.0,
            height: 56.0,
            margin: EdgeInsets.only(bottom: keyboardIsVisible ? 64.0 : 0.0),
            child: AnimatedBtn(
              icon: Icons.save,
              onTap: (){
                FocusScope.of(context).requestFocus(FocusNode());
                Future<void>.delayed(const Duration(milliseconds: 250), (){
                  _saveValue();
                });
              },
            )),
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: Platform.isIOS ? 80.0 : 56.0,)
            ],
          ),
        ),
      ),
    );
  }
}
