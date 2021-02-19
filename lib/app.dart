import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:quotes_generator/blocs/editor/editor.dart';
import 'package:quotes_generator/blocs/favorite/quotes.dart';
import 'package:quotes_generator/blocs/quotes/quotes.dart';
import 'package:quotes_generator/constants.dart';
import 'package:quotes_generator/main.dart';
import 'package:quotes_generator/models/quote.dart';
import 'package:quotes_generator/route.dart';
import 'package:quotes_generator/screens/editor/editor_screen.dart';
import 'package:quotes_generator/screens/favorite/favorite_screen.dart';
import 'package:quotes_generator/screens/home/home_screen.dart';
import 'package:quotes_generator/screens/list/list_screen.dart';
import 'package:quotes_generator/storage/database_helper.dart';
import 'package:quotes_generator/storage/internal.dart';
import 'package:quotes_generator/theme/theme.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  Future<bool> _loadInitialData() async {
    logger.i('Initializing storage');
    try{
      await DatabaseHelper().init();
      await InternalStorage().init();
    } catch(e){
      logger.e('Error during initialization internal storage and database helper.');
      return false;
    }

    if(InternalStorage().isInitialLaunch){
      try{
        for(final String value in fundamentalValues) {
          await DatabaseHelper().insert(Quote(content: value));
        }
        InternalStorage().isInitialLaunch = false;
        return true;
      } catch(e){
        logger.e(e);
        return false;
      }
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _loadInitialData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          return MultiBlocProvider(
            // ignore: always_specify_types
            providers: [
              BlocProvider<QuotesCubit>(
                create: (BuildContext context) {
                  return QuotesCubit();
                },
                child: const HomeScreen(),
              ),
              BlocProvider<QuotesCubit>(
                create: (BuildContext context) {
                  return QuotesCubit();
                },
                child: ListScreen(),
              ),
              BlocProvider<FavoriteQuotesCubit>(
                create: (BuildContext context) {
                  return FavoriteQuotesCubit();
                },
                child: FavoriteScreen(),
              ),
              BlocProvider<EditorCubit>(
                create: (BuildContext context) {
                  return EditorCubit();
                },
                child: EditorScreen(),
              ),
            ],
            child: NeumorphicApp(
              debugShowCheckedModeBanner: false,
              themeMode: InternalStorage().isUsingDark ? ThemeMode.dark : ThemeMode.light,
              theme: buildLightThemeData(context),
              darkTheme: buildDarkThemeData(context),
              home: CustomSplash(
                imagePath: 'assets/images/ic_launcher.png',
                logoSize: 50,
                duration: 2000,
                home: const HomeScreen(),
              ),
              onGenerateRoute: Routes.getRouteGenerate,
            )
          );
        } else {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(color: Colors.grey),
          );
        }
      },
    );
  }
}

