import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7), // Light grey background from mockup
      body: SafeArea(
        child: Stack(
          children: [
            // Background Emblem
            Positioned(
              top: 250, // Adjusted higher because the form is longer
              right: -115,
              child: Opacity(
                opacity: 0.045,
                child: Image.asset(
                  'assets/images/logo-emblem-stylesync.png',
                  width: 430,
                ),
              ),
            ),

            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 36),

                  // Logo
                  Image.asset(
                    'assets/images/logo-text-stylesync.png',
                    width: 240,
                  ),

                  const SizedBox(height: 32),

                  // Headers
                  const Text(
                    'Create an account',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Enter your email to sign up for this app',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Form Fields
                  _inputLabel('Name'),
                  const _AuthTextField(hintText: 'Perera'),

                  const SizedBox(height: 16),

                  _inputLabel('Email'),
                  const _AuthTextField(hintText: 'email@domain.com'),

                  const SizedBox(height: 16),

                  _inputLabel('Password'),
                  const _AuthTextField(
                    hintText: 'xxxxxxx',
                    obscureText: true,
                  ),

                  const SizedBox(height: 16),

                  _inputLabel('Confirm Password'),
                  const _AuthTextField(
                    hintText: 'xxxxxxx',
                    obscureText: true,
                  ),

                  const SizedBox(height: 24),

                  // Create Account Button
                  SizedBox(
                    width: double.infinity,
                    height: 48, // Taller button for better tap area
                    child: ElevatedButton(
                      onPressed: () => context.go('/'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Divider
                  const Text(
                    'or',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Social Buttons (Grey background)
                  _socialButton(
                    logoPath: 'assets/images/google.png',
                    text: 'Continue with Google',
                  ),

                  const SizedBox(height: 12),

                  _socialButton(
                    logoPath: 'assets/images/apple-logo.png',
                    text: 'Continue with Apple',
                  ),

                  const SizedBox(height: 32),

                  // Bottom Links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'You have already account ',
                        style: TextStyle(fontSize: 13),
                      ),
                      GestureDetector(
                        onTap: () => context.go('/'),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Terms and Privacy
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text.rich(
                      TextSpan(
                        text: 'By clicking continue, you agree to our ',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          height: 1.5,
                        ),
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
                    ),
                  ),

                  const SizedBox(height: 32),
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
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  static Widget _socialButton({
    required String logoPath,
    required String text,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFCECECE), // Grey background to match mockup
          foregroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              logoPath,
              width: 22,
              height: 22,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.image_not_supported, color: Colors.black54, size: 22);
              },
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reusing the same TextField style from LoginScreen for consistency
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
      height: 48, 
      child: TextField(
        obscureText: obscureText,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black38,
            fontSize: 15,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFDADADA)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}