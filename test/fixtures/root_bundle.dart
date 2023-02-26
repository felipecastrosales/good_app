import 'package:flutter/services.dart' show rootBundle;

class RootBundle {
  static Future<String> loadString(String path) async {
    return await rootBundle.loadString(path);
  }
}
