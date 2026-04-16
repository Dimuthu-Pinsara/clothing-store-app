import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/primary_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              const CustomTextField(hintText: 'Name'),
              const SizedBox(height: 16),
              const CustomTextField(hintText: 'Email'),
              const SizedBox(height: 16),
              const CustomTextField(hintText: 'Password', obscureText: true),
              const SizedBox(height: 16),
              const CustomTextField(
                hintText: 'Confirm Password',
                obscureText: true,
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'Create Account',
                onPressed: () => context.go('/'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}