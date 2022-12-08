import 'package:flutter/material.dart';

import 'package:good_app/app/core/ui/colors/app_gradients.dart';
import 'package:good_app/app/core/ui/styles/app_text_styles.dart';

class EnterButton extends StatelessWidget {
  const EnterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: AppGradients.linear,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Text(
        'Entrar',
        style: AppTextStyles.enterLogin,
      ),
    );
  }
}
