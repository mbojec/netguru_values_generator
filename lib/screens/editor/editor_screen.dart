import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:quotes_generator/blocs/editor/editor.dart';
import 'package:quotes_generator/blocs/editor/state.dart';
import 'package:quotes_generator/components/bottom_bar.dart';
import 'package:quotes_generator/components/btn.dart';
import 'package:quotes_generator/screens/editor/components/animated_btn.dart';
import 'package:quotes_generator/storage/internal.dart';
import 'package:quotes_generator/theme/styles.dart';

class EditorScreen extends StatefulWidget {
  @override
  _EditorScreenState createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> with SingleTickerProviderStateMixin {
  TextEditingController _controller;
  AnimationController _animationController;
  Animation<double> _cardDepthAnimation, _textDepthAnimation;
  Animation<Color> _textColorAnimation, _cardColorAnimation;
  String value = '';
  // bool isSaving = false;
  @override
  void initState() {
    _controller = TextEditingController();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // _animationController.addStatusListener((AnimationStatus status) {
    //   if (status == AnimationStatus.completed) {
    //
    //   }
    // }
    // );

    _cardDepthAnimation = Tween<double>(
      begin: 0.0,
      end: -20.0,
    ).animate(_animationController);

    _textDepthAnimation = Tween<double>(
      begin: 0.0,
      end: 20.0,
    ).animate(_animationController);


    if(InternalStorage().isUsingDark){
      _textColorAnimation = ColorTween(begin: const Color(0xFF8a8c8f), end: const Color(0xFFe8eafa)).animate(_animationController);
      _cardColorAnimation = ColorTween(begin: const Color(0xFF35393e), end: const Color(0xFF212529)).animate(_animationController);
    } else {
      _textColorAnimation = ColorTween(begin: const Color(0xFFc2c6e0), end: const Color(0xFFe8eafa)).animate(_animationController);
      _cardColorAnimation = ColorTween(begin: const Color(0xFFe8eafa), end: const Color(0xFFc2c6e0)).animate(_animationController);
    }

    super.initState();
  }

  void _saveValue(){
    value = _controller.text;
    if(value.isNotEmpty){
      context.read<EditorCubit>().saveNewQuote(value);
      // setState(() {
      //   isSaving = true;
      // });
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _body(){
    return BlocConsumer<EditorCubit, EditorState>(
        listener: (BuildContext context, EditorState state) {
          if (state is EditorSuccess) {
            Future<void>.delayed(const Duration(milliseconds: 500), (){
              Navigator.of(context).pop(true);
            });
          }
        }, builder: (BuildContext context, EditorState state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
                                  width: state is EditorSaving ? 0.0 : 1.0, color: NeumorphicTheme.variantColor(context)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: state is EditorSaving ? NeumorphicText(
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
                                textCapitalization: TextCapitalization.sentences,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                style: inputTextStyle(context),
                                textAlign: TextAlign.center,
                                onChanged: (String value){
                                  setState(() {
                                    if(value.isNotEmpty){
                                      context.read<EditorCubit>().clearState();
                                    }
                                  });
                                },
                                controller: _controller,
                                decoration: InputDecoration.collapsed(hintText: 'Space for you...', hintStyle: TextStyle(color: NeumorphicTheme.defaultTextColor(context), fontWeight: FontWeight.bold, fontSize: 18.0)),
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
                  child: state is EditorSaving ? AnimatedBuilder(
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
                  ) : state is EditorError ? Center(child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Text(state.message, style: errorTextStyle(),textAlign: TextAlign.center,),
                  )): null,
                ),
              ),
            ],
          );
    });
  }

  void _showErrorMessage(){
    context.read<EditorCubit>().setErrorMessage('You have to type something before saving');
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      // ignore: prefer_const_literals_to_create_immutables
      gestures: <GestureType>[GestureType.onTap, GestureType.onPanUpdateDownDirection],
      child: KeyboardVisibilityBuilder(
        builder: (BuildContext context, bool isKeyboardVisible){
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: NeumorphicAppBar(
              leading: NeumorphicTheme.isUsingDark(context) ? BumpButton(Icons.arrow_back_ios_rounded, (){
                if(!_animationController.isAnimating){
                  Navigator.of(context).pop(false);
                }
              }, context) : ConcaveButton(onPressed: (){
                if(!_animationController.isAnimating){
                  Navigator.of(context).pop(false);
                }
              }, context: context, icon: Icons.arrow_back_ios_rounded),
              centerTitle: true,
              title: const Text('Editor'),
            ),
            backgroundColor: NeumorphicTheme.baseColor(context),
            body: _body(),
            floatingActionButton: Container(
                width: 56.0,
                height: 56.0,
                margin: EdgeInsets.only(bottom: isKeyboardVisible ? 64.0 : 0.0),
                child: SaveBtn(
                  enable: _controller.text.isNotEmpty,
                  context: context,
                  onTap: (){
                    HapticFeedback.vibrate();
                    FocusScope.of(context).requestFocus(FocusNode());
                    Future<void>.delayed(const Duration(milliseconds: 250), (){
                      _saveValue();
                    });
                  },
                  disableTapCallback: (){
                    _showErrorMessage();
                  },
                )),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomBar(),
          );
        },
      ),
    );
  }
}
