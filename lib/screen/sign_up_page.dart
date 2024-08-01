import 'package:flutter/material.dart';
import 'package:list_it/global/color.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../main.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _confirmPasswordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _background(),
          _signUpForm(context),
        ],
      ),
    );
  }

  SvgPicture _background() {
    return SvgPicture.asset('asset/svg/picture/login_background.svg', fit: BoxFit.cover);
  }

  Widget _signUpForm(BuildContext context) {
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
            _signupLabel(),
            const SizedBox(height: 24),
            _emailField(_emailCtrl, 'enter your e-mail'),
            const SizedBox(height: 24),
            _passwordField(_passwordCtrl, 'choose a password'),
            const SizedBox(height: 24+18),
            _signUpButton(),
            const SizedBox(height: 6),
            _loginPrompt(context),
          ],
        ),
      ),
    );
  }

  SvgPicture _logo() {
    return SvgPicture.asset('asset/svg/logo/LISTit_icon.svg', height: 64);
  }

  Widget _signupLabel() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Sign Up',
        style: TextStyle(
          color: AppColors.grey_800,
          fontSize: 18,
          fontVariations: [FontVariation('wght', 600)],
        ),
      ),
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

  TextField _confirmPasswordField(TextEditingController controller, String hintText) {
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

  Widget _loginPrompt(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Already have an account? ",
            style: TextStyle(color: AppColors.grey_400),
          ),
          GestureDetector(
            child: const Text(
              'Log in',
              style: TextStyle(
                color: AppColors.green_600,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.loginScreen.route);
            },
          ),
        ],
      ),
    );
  }

  Widget _signUpButton() {
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
          // TODO: implement sign up functionality
        },
        child: const Text('SIGN UP'),
      ),
    );
  }
}
