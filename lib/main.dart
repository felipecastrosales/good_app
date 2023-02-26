import 'package:flutter/material.dart';

import 'app.dart';
import 'app/injection/locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(
    const App(),
  );
}
