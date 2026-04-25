import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // Profile Image with Blue Ring
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF6B9DFE), // Light blue border
                  width: 3,
                ),
              ),
              child: const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('images/profile/profile.jpg'), 
                backgroundColor: Color(0xFFE0E0E0),
              ),
            ),
            const SizedBox(height: 16),
            
            // Name and Email
            const Text(
              'Meleena Karunarathna',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'meleenakarunarathna@gmail.com',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 32),
            
            // Account Details Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Account Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Menu Items
                  _ProfileMenuTile(
                    icon: Icons.person_outline,
                    title: 'Edit your profile',
                    subtitle: 'Name, Email, Profile Picture',
                    onTap: () {},
                  ),
                  const Divider(height: 1, color: Color(0xFFEAEAEA)),
                  _ProfileMenuTile(
                    icon: Icons.shopping_cart_outlined,
                    title: 'Order History',
                    subtitle: 'View and track your previous orders',
                    onTap: () {},
                  ),
                  const Divider(height: 1, color: Color(0xFFEAEAEA)),
                  _ProfileMenuTile(
                    icon: Icons.location_on_outlined,
                    title: 'Shipping Addresses',
                    subtitle: 'Manage your delivery locations',
                    onTap: () {},
                  ),
                  const Divider(height: 1, color: Color(0xFFEAEAEA)),
                  
                  const SizedBox(height: 32),
                  
                  // Logout Button
                  Center(
                    child: SizedBox(
                      width: 160,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFDada), // Light pink/red background
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          context.read<AuthProvider>().logout();
                          context.go('/');
                        },
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            color: Color(0xFFFF3B30), // Red text
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40), // Bottom padding
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _BottomNavBar(),
    );
  }
}

// Helper Widget for Menu Items
class _ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ProfileMenuTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            // Grey Circle Icon
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0xFFE8E8E8), // Light grey circle
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.black87,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            
            // Text Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            
            // Chevron
            const Icon(
              Icons.chevron_right,
              color: Colors.black54,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}

// Consistent Bottom Navigation Bar
class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFF0F0F0)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => context.go('/home'), // Adjust route as needed
            child: const Icon(Icons.home, size: 28, color: Colors.black87),
          ),
          const Icon(Icons.notifications_none, size: 28, color: Colors.black87),
          const Icon(Icons.person, size: 28, color: Colors.black), // Filled icon for active state
        ],
      ),
    );
  }
}