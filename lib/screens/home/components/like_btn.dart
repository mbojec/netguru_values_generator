import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:quotes_generator/blocs/quote/quote.dart';
import 'package:quotes_generator/blocs/quote/state.dart';
import 'package:quotes_generator/constants.dart';
import 'package:quotes_generator/blocs/quotes/quotes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikeBtn extends StatefulWidget {

  @override
  _LikeBtnState createState() => _LikeBtnState();
}

class _LikeBtnState extends State<LikeBtn> {
  bool _isFavorite;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuoteCubit, QuoteState>(
        builder: (BuildContext context, QuoteState state) {
      _isFavorite =
          (state is! QuoteInitial) && ((state as QuoteLoaded).quote.isFavorite);
      return GestureDetector(
        onTap: () {
          HapticFeedback.mediumImpact();
          context
              .read<QuotesCubit>()
              .changeFavoriteState((state as QuoteLoaded).quote);
          setState(() {
            _isFavorite = !_isFavorite;
          });
        },
        child: Neumorphic(
          style: NeumorphicStyle(
            shape: _isFavorite ? null : NeumorphicShape.flat,
            boxShape: const NeumorphicBoxShape.circle(),
            depth: _isFavorite
                ? NeumorphicTheme.embossDepth(context)
                : NeumorphicTheme.depth(context),
            lightSource: LightSource.topLeft,
            color: _isFavorite
                ? NeumorphicTheme.variantColor(context)
                : NeumorphicTheme.baseColor(context),
          ),
          child: Center(
            child: NeumorphicIcon(
              _isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
              style: NeumorphicStyle(
                depth: _isFavorite ? Dimensions.maxDepth : Dimensions.baseDepth,
                color: _isFavorite
                    ? Colors.red
                    : NeumorphicTheme.variantColor(context),
              ),
            ),
          ),
        ),
      );
    });
  }
}
