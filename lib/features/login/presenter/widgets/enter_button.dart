import 'package:flutter/material.dart';

import 'package:good_app/app/core/core.dart';

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
