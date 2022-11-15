import 'package:flutter/material.dart';

import 'package:good_app/app/app.dart';
import 'package:good_app/features/features.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppTexts.projectName,
      theme: AppTheme.theme,
      home: LoginPage(),
    );
  }
}
