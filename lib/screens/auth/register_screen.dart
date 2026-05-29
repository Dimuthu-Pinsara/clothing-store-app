import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _isLoading = false;

  // Don't forget to dispose them!
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF7F7F7,
      ), // Light grey background from mockup
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
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),

                  const SizedBox(height: 24),

                  // Form Fields
                  _inputLabel('Name'),
                  _AuthTextField(
                    hintText: 'Perera',
                    controller: _nameController,
                  ),

                  const SizedBox(height: 16),

                  _inputLabel('Email'),
                  _AuthTextField(
                    hintText: 'email@domain.com',
                    controller: _emailController,
                  ),

                  const SizedBox(height: 16),

                  _inputLabel('Password'),
                  _AuthTextField(
                    hintText: 'xxxxxxx',
                    obscureText: true,
                    controller: _passwordController,
                  ),

                  const SizedBox(height: 16),

                  _inputLabel('Confirm Password'),
                  _AuthTextField(
                    hintText: 'xxxxxxx',
                    obscureText: true,
                    controller: _confirmController,
                  ),

                  const SizedBox(height: 24),

                  // Create Account Button
                  SizedBox(
                    width: double.infinity,
                    height: 48, // Taller button for better tap area
                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () async {
                              // Check if passwords match first
                              if (_passwordController.text !=
                                  _confirmController.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Passwords do not match!'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              setState(() => _isLoading = true);

                              final error = await context
                                  .read<AuthProvider>()
                                  .register(
                                    _emailController.text,
                                    _passwordController.text,
                                  );

                              setState(() => _isLoading = false);

                              if (error == null) {
                                // Optional: You can save the _nameController.text to a user profile database here later
                                if (context.mounted) context.go('/home');
                              } else {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(error),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            },
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
                    style: TextStyle(fontSize: 14, color: Colors.black54),
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
          backgroundColor: const Color(
            0xFFCECECE,
          ), // Grey background to match mockup
          foregroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              logoPath,
              width: 22,
              height: 22,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.image_not_supported,
                  color: Colors.black54,
                  size: 22,
                );
              },
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
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
  final TextEditingController? controller;

  const _AuthTextField({
    required this.hintText,
    this.obscureText = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black38, fontSize: 15),
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
