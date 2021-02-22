import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:quotes_generator/app.dart';

final Logger logger = Logger(
  printer: PrettyPrinter(
    printTime: true,
  ),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  logger.v('Initialing application');

  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ],
  );

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  SystemChrome.setEnabledSystemUIOverlays(
    <SystemUiOverlay>[SystemUiOverlay.bottom],
  );

  runApp(App());
}
