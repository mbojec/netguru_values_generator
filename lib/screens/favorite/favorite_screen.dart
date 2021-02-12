import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:netguru_values_generator/components/btn.dart';
import 'package:netguru_values_generator/components/quote_card.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<String> values = <String>["Exceed clients' and colleagues' expectations", 'Take ownership and question the status quo in a constructive manner',
    'Be brave, curious and experiment. Learn from all successes and failures', 'Act in a way that makes all of us proud',
    'Build an inclusive, transparent and socially responsible culture', 'Be ambitious, grow yourself and the people around you', 'Recognize excellence and engagement'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        leading: NeumorphicTheme.isUsingDark(context) ? BumpButton(Icons.arrow_back_ios_rounded, (){
          Navigator.of(context).pop();
        }, context) : ConcaveButton(onPressed: (){
          Navigator.of(context).pop();
        }, context: context, icon: Icons.arrow_back_ios_rounded),
        centerTitle: true,
        title: const Text('Favorite Values'),
      ),
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: ListView.builder(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.width > 375.0 ? 16.0 : 0.0, bottom: MediaQuery.of(context).size.width > 375.0 ? 32.0 : 16.0),
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
