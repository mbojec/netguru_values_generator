import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:netguru_values_generator/app.dart';

final Logger logger = Logger(
  printer: PrettyPrinter(
    printTime: true,
  ),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  logger.v('Initialing application');

  await SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent
  ));

  runApp(App());
}
