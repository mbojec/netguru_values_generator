import 'package:shared_preferences/shared_preferences.dart';

class InternalStorage {
  SharedPreferences prefs;
  static final InternalStorage _instance = InternalStorage._internal();
  factory InternalStorage() => _instance;

  bool get isUsingDark {
    return prefs.getBool('is_dark_theme') ?? false;
  }

  set isUsingDark(bool isUsingDark){
    prefs.setBool('is_dark_theme', isUsingDark);
  }

  InternalStorage._internal(){
    init();
  }

  Future<void> init() async {
   prefs = await SharedPreferences.getInstance();
  }
}