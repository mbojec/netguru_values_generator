import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:quotes_generator/blocs/quotes/quotes.dart';
import 'package:quotes_generator/blocs/quotes/state.dart';
import 'package:quotes_generator/components/btn.dart';
import 'package:quotes_generator/constants.dart';
import 'package:quotes_generator/models/quote.dart';
import 'package:quotes_generator/screens/home/components/animated_quote_card.dart';
import 'package:quotes_generator/theme/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFavorite = false;
  int indexValue = 0;
  CarouselController _carouselController;

  @override
  void initState() {
    _carouselController = CarouselController();
    context.read<QuotesCubit>().getQuotes();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void callback(int randomValue){
    setState(() {
      isFavorite = context.read<QuotesCubit>().list[randomValue].isFavorite;
      indexValue = randomValue;
    });
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
              child: CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  viewportFraction: 1.0,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 500),
                ),
                items: state.quotes.map((Quote quote) {
                  return Builder(
                    builder: (BuildContext context) {
                      return AnimatedQuoteCard(quotes: state.quotes, context: context, callback: callback);
                    },
                  );
                }).toList(),
              )
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
        leading: NeumorphicTheme.isUsingDark(context) ? BumpButton(Icons.settings, (){
          Navigator.of(context).pushNamed(RouteList.settings).then((_){
            _carouselController.nextPage(duration: const Duration(milliseconds: 1));
          });
        }, context) : ConcaveButton(onPressed: (){
          Navigator.of(context).pushNamed(RouteList.settings).then((_){
            _carouselController.nextPage(duration: const Duration(milliseconds: 1));
          });
        }, context: context, icon: Icons.settings),
        centerTitle: true,
        title: const Text('Quotes'),
        actions: <Widget>[
          GestureDetector(
              onTap: (){
                HapticFeedback.mediumImpact();
                setState(() {
                  isFavorite = !isFavorite;
                });
                context.read<QuotesCubit>().changeFavoriteState(context.read<QuotesCubit>().list[indexValue]);
              },
              child: Neumorphic(
                style: NeumorphicStyle(
                    shape:  isFavorite ? null : NeumorphicShape.flat,
                    boxShape: const NeumorphicBoxShape.circle(),
                    depth:  isFavorite ? NeumorphicTheme.embossDepth(context) : NeumorphicTheme.depth(context),
                    lightSource: LightSource.topLeft,
                    color: isFavorite ? NeumorphicTheme.variantColor(context) : NeumorphicTheme.baseColor(context),
                ),
                child: Center(
                    child: NeumorphicIcon(
                      isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                      style: NeumorphicStyle(
                          depth: isFavorite ? 20.0 : 0.0,
                          color: isFavorite ? Colors.red : NeumorphicTheme.variantColor(context)
                      ),
                    )
                  // Icon(Icons.favorite_border_outlined, color: tap ? Colors.red : Colors.grey),
                ),
              )
          ),
        ],
      ),
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: _body(),
      floatingActionButton: NeumorphicTheme.isUsingDark(context) ? BumpButton(Icons.add, (){
        Navigator.of(context).pushNamed(RouteList.editor).then((Object newQuoteCreated){
          if(newQuoteCreated){
            context.read<QuotesCubit>().updateQuotes();
          }
        });
       }, context) : NeumorphicButton(
        onPressed: (){
          Navigator.of(context).pushNamed(RouteList.editor).then((Object newQuoteCreated){
            if(newQuoteCreated){
              context.read<QuotesCubit>().updateQuotes();
            }
          });
        },
        padding: const EdgeInsets.all(16.0),
        child: Icon(Icons.add, color: NeumorphicTheme.defaultTextColor(context),),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Neumorphic(
        style: bottomNavigationBarStyle(context),
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
                        HapticFeedback.mediumImpact();
                        Navigator.of(context).pushNamed(RouteList.list);
                      },
                      child: NeumorphicIcon(
                        Icons.list,
                        style: navigationBtnStyle(context),
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
                        HapticFeedback.mediumImpact();
                        Navigator.of(context).pushNamed(RouteList.favorite);
                      },
                      child: NeumorphicIcon(
                        Icons.favorite,
                        style: navigationBtnStyle(context),
                        size: 32.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width > 375.0 ? 24.0: 0.0)
          ],
        ),
      ),
    );
  }
}