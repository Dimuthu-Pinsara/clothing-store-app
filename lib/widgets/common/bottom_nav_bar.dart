import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFEAEAEA)),
        ),
      ),
      // 2. Removed 'const' from the Row
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => context.push('/home'),
            child: const Icon( // 3. Kept 'const' on the Icons, which is perfectly fine
              Icons.home,
              size: 28,
              color: Colors.black87,
            ),
          ),
          GestureDetector(
            onTap: () => context.push('/notifications'),
            child: const Icon(
              Icons.notifications_none,
              size: 28,
              color: Colors.black87,
            ),
          ),
          GestureDetector(
            onTap: () => context.push('/profile'),
            child: const Icon(
              Icons.person_outline,
              size: 28,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}