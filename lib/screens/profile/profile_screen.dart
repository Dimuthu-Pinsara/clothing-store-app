import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              child: Icon(Icons.person, size: 40),
            ),
            const SizedBox(height: 16),
            const Text(
              'John Doe',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text('johndoe@email.com'),
            const SizedBox(height: 24),
            Card(
              child: Column(
                children: const [
                  ListTile(
                    leading: Icon(Icons.shopping_bag_outlined),
                    title: Text('My Orders'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.location_on_outlined),
                    title: Text('Shipping Address'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.settings_outlined),
                    title: Text('Settings'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.read<AuthProvider>().logout();
                context.go('/');
              },
              child: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}