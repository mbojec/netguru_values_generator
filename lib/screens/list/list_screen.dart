import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:netguru_values_generator/components/quote_card.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<String> values = <String>["Exceed clients' and colleagues' expectations", 'Take ownership and question the status quo in a constructive manner',
    'Be brave, curious and experiment. Learn from all successes and failures', 'Act in a way that makes all of us proud',
    'Build an inclusive, transparent and socially responsible culture', 'Be ambitious, grow yourself and the people around you', 'Recognize excellence and engagement'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
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
          'Values',
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
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: ListView.builder(
              padding: const EdgeInsets.only(top: 16.0, bottom: 32.0),
              itemCount: values.length,
              itemBuilder: (BuildContext context, int position){
                return QuoteCard(value: values[position]);
              }
              ),
        ),
      ),
    );
  }
}
