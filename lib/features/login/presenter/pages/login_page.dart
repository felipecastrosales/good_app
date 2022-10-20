import 'package:flutter/material.dart';
import 'package:good_app/app/app.dart';

import 'package:good_app/features/login/presenter/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(24),
          color: AppColors.background,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),
                InkWell(
                  onTap: () {},
                  child: Image.asset(
                    AssetsData.logo,
                    height: context.height * .3,
                  ),
                ),
                const SizedBox(height: 24),
                CustomTextFormField(
                  hintText: 'Insira seu usuário',
                  prefixIcon: Icons.person_rounded,
                  controller: _emailController..text,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {},
                  validator: (value) => null,
                  // onChanged: controller.onEmailChanged,
                  // validator: controller.isEmailValid,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hintText: 'Insira sua senha',
                  prefixIcon: Icons.lock,
                  isSecret: true,
                  controller: _passwordController,
                  onChanged: (value) {},
                  validator: (value) => null,
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: () async {
                    var isFormValid =
                        _formKey.currentState?.validate() ?? false;
                    final username = _emailController.text;
                    final password = _passwordController.text;
                    if (isFormValid) {
                      await controller.login(username, password);
                    }
                  },
                  child: const EnterButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginController {
  // login method with password and email
  String email = '';
  String password = '';

  Future<void> login(String email, String password) async {
    this.email = email;
    this.password = password;
  }
}
