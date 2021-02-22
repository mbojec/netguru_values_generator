import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:quotes_generator/blocs/quotes/quotes.dart';
import 'package:quotes_generator/blocs/quotes/state.dart';
import 'package:quotes_generator/models/quote.dart';
import 'package:quotes_generator/screens/home/components/animated_quote_card.dart';
import 'package:quotes_generator/screens/home/components/bottom_nav_bar.dart';
import 'package:quotes_generator/screens/home/components/fab.dart';
import 'package:quotes_generator/screens/home/components/like_btn.dart';
import 'package:quotes_generator/screens/home/components/settings_btn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController _carouselController;

  @override
  void initState() {
    _carouselController = CarouselController();
    context.read<QuotesCubit>().getQuotes();
    super.initState();
  }

  Widget _body() {
    return BlocBuilder<QuotesCubit, QuotesState>(
        builder: (BuildContext context, QuotesState state) {
      if (state is QuotesInitial) {
        return Container();
      } else if (state is QuotesLoading) {
        return const Center(
            child: NeumorphicProgressIndeterminate(
          duration: Duration(seconds: 10),
        ));
      } else if (state is QuotesLoaded) {
        return Center(
          child: CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
              height: double.infinity,
              scrollPhysics: const NeverScrollableScrollPhysics(),
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 500),
            ),
            items: state.quotes.map((Quote quote) {
              return Builder(
                builder: (BuildContext context) {
                  return AnimatedQuoteCard(
                    quotes: state.quotes,
                    context: context,
                  );
                },
              );
            }).toList(),
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
        leading: SettingsBtn(carouselController: _carouselController),
        centerTitle: true,
        title: const Text('Quotes'),
        actions: <Widget>[
          LikeBtn()
        ],
      ),
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: _body(),
      floatingActionButton: Fab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
