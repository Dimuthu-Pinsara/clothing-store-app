import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 330,
              right: -120,
              child: Opacity(
                opacity: 0.04,
                child: Image.asset(
                  'assets/images/logo-emblem-stylesync.png',
                  width: 420,
                ),
              ),
            ),

            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 36),

                  Image.asset(
                    'assets/images/logo-text-stylesync.png',
                    width: 260,
                  ),

                  const SizedBox(height: 28),

                  const Text(
                    'Create an account',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Enter your email to sign up for this app',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 14),

                  _inputLabel('Name'),
                  const _AuthTextField(hintText: 'Perera'),

                  const SizedBox(height: 10),

                  _inputLabel('Email'),
                  const _AuthTextField(hintText: 'email@domain.com'),

                  const SizedBox(height: 10),

                  _inputLabel('Password'),
                  const _AuthTextField(
                    hintText: 'xxxxxxxx',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  _inputLabel('Confirm Password'),
                  const _AuthTextField(
                    hintText: 'xxxxxxxx',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () => context.go('/'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      child: const Text(
                        'Create Account',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'or',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black45,
                    ),
                  ),

                  const SizedBox(height: 12),

                  _socialButton(
                    icon: 'G',
                    text: 'Continue with Google',
                    iconColor: Colors.blue,
                  ),

                  const SizedBox(height: 9),

                  _socialButton(
                    icon: '',
                    text: 'Continue with Apple',
                    iconColor: Colors.black,
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'You have already account ',
                        style: TextStyle(fontSize: 12),
                      ),
                      GestureDetector(
                        onTap: () => context.go('/'),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Text.rich(
                      TextSpan(
                        text: 'By clicking continue, you agree to our ',
                        children: [
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(color: Colors.black87),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(color: Colors.black87),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                        height: 1.4,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _inputLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  static Widget _socialButton({
    required String icon,
    required String text,
    required Color iconColor,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD1CFCF),
          foregroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              icon,
              style: TextStyle(
                fontSize: 22,
                color: iconColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;

  const _AuthTextField({
    required this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        obscureText: obscureText,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black38,
            fontSize: 14,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: Color(0xFFDADADA)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}