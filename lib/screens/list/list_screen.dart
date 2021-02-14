import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:netguru_values_generator/blocs/quotes/quotes.dart';
import 'package:netguru_values_generator/blocs/quotes/state.dart';
import 'package:netguru_values_generator/components/btn.dart';
import 'package:netguru_values_generator/components/quote_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  @override
  void initState() {
    context.read<QuotesCubit>().getQuotes();
    super.initState();
  }

  Widget _body(){
    return BlocBuilder<QuotesCubit, QuotesState>(
        builder: (BuildContext context, QuotesState state) {
          if (state is QuotesInitial) {
            return Container();
          } else if (state is QuotesLoading) {
            return const Center(
                child: NeumorphicProgressIndeterminate(duration: Duration(seconds: 10),));
          } else if (state is QuotesLoaded) {
            return Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ListView.builder(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.width > 375.0 ? 16.0 : 0.0, bottom: MediaQuery.of(context).size.width > 375.0 ? 32.0 : 16.0),
                    itemCount:state.quotes.length,
                    itemBuilder: (BuildContext context, int position){
                      return QuoteCard(value: state.quotes[position]);
                    }
                ),
              ),
            );
          } else {
            return Center(child: Text((state as QuotesError).message));
          }
        });
  }

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
        title: const Text('Values'),
      ),
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: _body()
    );
  }
}
