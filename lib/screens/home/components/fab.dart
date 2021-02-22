import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_generator/blocs/quotes/quotes.dart';
import 'package:quotes_generator/components/btn.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:quotes_generator/constants.dart';

class Fab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    if (NeumorphicTheme.isUsingDark(context)) {
      return bumpButton(Icons.add, () {
        Navigator.of(context)
            .pushNamed(RouteList.editor)
            .then((Object newQuoteCreated) {
          if (newQuoteCreated) {
            context.read<QuotesCubit>().updateQuotes();
          }
        });
      }, context);
    } else {
      return NeumorphicButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed(RouteList.editor)
              .then((Object newQuoteCreated) {
            if (newQuoteCreated) {
              context.read<QuotesCubit>().updateQuotes();
            }
          });
        },
        padding: const EdgeInsets.all(16.0),
        child: Icon(
          Icons.add,
          color: NeumorphicTheme.defaultTextColor(context),
        ),
      );
    }
  }
}
