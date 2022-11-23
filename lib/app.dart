import 'package:flutter/material.dart';

import 'app/commons/resources/app_texts.dart';
import 'app/core/ui/theme/app_theme.dart';
import 'features/login/presenter/pages/login_page.dart';

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
