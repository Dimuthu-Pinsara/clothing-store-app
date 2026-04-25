import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Updated to match white background
      body: SafeArea(
        child: Stack(
          children: [
            // Background Emblem (kept, but with slightly higher top to fit better)
            Positioned(
              top: 300,
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
                  const SizedBox(height: 70),

                  // Updated logo path if different
                  Image.asset(
                    'assets/images/logo-text-stylesync.png',
                    width: 260,
                  ),

                  const SizedBox(height: 68),

                  _inputLabel('Email'),
                  const _AuthTextField(hintText: 'email@domain.com'),

                  const SizedBox(height: 12),

                  _inputLabel('Password'),
                  const _AuthTextField(
                    hintText: 'xxxxxxx',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 48, // Slightly taller for better touch target
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<AuthProvider>().login();
                        context.go('/home');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Standard radius
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16, // Matching the font size in UI
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'or',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 16),

                  _socialButton(
                    logoPath: 'assets/images/google.png', 
                    text: 'Continue with Google',
                  ),

                  const SizedBox(height: 12),

                  _socialButton(
                    logoPath: 'assets/images/apple-logo.png',
                    text: 'Continue with Apple',
                  ),

                  const SizedBox(height: 100),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () => context.push('/register'),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Fine Print / Terms
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
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          side: const BorderSide(color: Color(0xFFDADADA)), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Added errorBuilder so the app doesn't crash if the asset is missing
            Image.asset(
              logoPath,
              width: 24,
              height: 22,
              errorBuilder: (context, error, stackTrace) {
                // Shows a default grey icon if the image fails to load
                return const Icon(Icons.image_not_supported, color: Colors.grey, size: 22);
              },
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.w600,
              ),
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
      height: 48, // Consistent field height
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
          // Enabled state border
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFDADADA)),
          ),
          // Focused state border
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}