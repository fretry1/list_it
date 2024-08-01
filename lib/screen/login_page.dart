import 'package:flutter/material.dart';
import 'package:list_it/global/color.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _background(),
          _loginForm(context),
        ],
      ),
    );
  }

  SvgPicture _background() {
    return SvgPicture.asset('asset/svg/picture/login_background.svg', fit: BoxFit.cover);
  }

  Widget _loginForm(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.06,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _logo(),
            const SizedBox(height: 24),
            _loginLabel(),
            const SizedBox(height: 24),
            _emailField(_emailCtrl, 'e-mail'),
            const SizedBox(height: 24),
            _passwordField(_passwordCtrl, 'password'),
            const SizedBox(height: 6),
            _forgotPasswordPrompt(),
            const SizedBox(height: 24),
            _loginButton(),
            const SizedBox(height: 6),
            _signUpPrompt(context),
          ],
        ),
      ),
    );
  }

  SvgPicture _logo() {
    return SvgPicture.asset('asset/svg/logo/LISTit_icon.svg', height: 64);
  }

  Widget _loginLabel() {
    return const Align(alignment: Alignment.centerLeft,
      child: Text('Log In',
        style: TextStyle(
          color: AppColors.grey_800,
          fontSize: 18,
          fontVariations: [FontVariation('wght', 600)]
        )
      )
    );
  }

  Widget _emailField(TextEditingController controller, String hintText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        alignLabelWithHint: true,
        filled: true,
        fillColor: Colors.grey[200],
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.green_600),
        ),
        isDense: true,
      ),
    );
  }

  TextField _passwordField(TextEditingController controller, String hintText) {
    return TextField(
      controller: controller,
      obscureText: true,
      obscuringCharacter: '▪',
      decoration: InputDecoration(
        hintText: hintText,
        alignLabelWithHint: true,
        filled: true,
        fillColor: Colors.grey[200],
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.green_600),
        ),
        isDense: true,
      ),
    );
  }

  Widget _forgotPasswordPrompt() {
    return SizedBox(
      height: 18,
      child: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          child: const Text(
            'Forgot your password?',
            style: TextStyle(
                color: AppColors.grey_500,
                fontSize: 13,
                fontVariations: [FontVariation('wgth', 200)]
            ),
          ),
          onTap: () {
            // TODO: implement navigation
          },
        ),
      ),
    );
  }

  Widget _signUpPrompt(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Don't have an account? ",
            style: TextStyle(color: AppColors.grey_400),
          ),
          GestureDetector(
            child: const Text(
              'Sign up',
              style: TextStyle(
                color: AppColors.green_600,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.signupScreen.route);
            },
          ),
        ],
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.green_600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0, // Add this line to create a shadow effect
        ),
        onPressed: () {
          Navigator.pushNamed(context, Routes.homeScreen.route);
        },
        child: const Text('LOG IN'),
      ),
    );
  }
}
