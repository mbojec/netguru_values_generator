import 'package:flutter/widgets.dart';
import 'package:netguru_values_generator/constants.dart';
import 'package:netguru_values_generator/screens/editor/editor_screen.dart';
import 'package:netguru_values_generator/screens/favorite/favorite_screen.dart';
import 'package:netguru_values_generator/screens/home/home_screen.dart';
import 'package:netguru_values_generator/screens/list/list_screen.dart';
import 'package:netguru_values_generator/screens/settings/settings_screen.dart';

class Routes {
  // ignore: always_specify_types
  static Route getRouteGenerate(RouteSettings settings) =>
      _routeGenerate(settings);

  // ignore: always_specify_types
  static Route _routeGenerate(RouteSettings settings) {
    switch (settings.name) {
      case RouteList.home:
        return _FadedTransitionRoute(
          widget: const HomeScreen(), settings: settings
        );
        break;
      case RouteList.list:
        return _FadedTransitionRoute(widget: ListScreen(), settings: settings);
        break;
      case RouteList.favorite:
        return _FadedTransitionRoute(widget: FavoriteScreen(), settings: settings);
        break;
      case RouteList.editor:
        return _FadedTransitionRoute(widget: EditorScreen(), settings: settings);
        break;
      case RouteList.settings:
        return _FadedTransitionRoute(widget: SettingsScreen(), settings: settings);
        break;
      default:
        return _FadedTransitionRoute(
            widget: const HomeScreen(), settings: settings
        );
    }
  }
}

// ignore: always_specify_types
class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({this.widget, this.settings})
      : super(
      settings: settings,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return widget;
      },
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
          child: child,
        );
      });
}