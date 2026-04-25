import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for notifications
    final List<Map<String, dynamic>> notifications = [
      {
        'title': 'Your order has been successfully placed.',
        'time': '20 minutes ago',
        'image': 'assets/images/products/crop-tops.webp',
        'isUnread': true,
      },
      {
        'title': 'Your order is out for delivery.',
        'time': '2 hours ago',
        'image': 'assets/images/products/t-shirts.webp',
        'isUnread': false,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom Header
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 24),
              child: Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            
            // Notifications List
            Expanded(
              child: notifications.isEmpty
                  ? const Center(
                      child: Text(
                        'No new notifications',
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: notifications.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        return _NotificationTile(
                          title: notification['title'],
                          time: notification['time'],
                          imagePath: notification['image'],
                          isUnread: notification['isUnread'],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _BottomNavBar(),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final String title;
  final String time;
  final String imagePath;
  final bool isUnread;

  const _NotificationTile({
    required this.title,
    required this.time,
    required this.imagePath,
    this.isUnread = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Unread Blue Dot Indicator
        SizedBox(
          width: 12,
          child: isUnread
              ? Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2B6BFF), // Vibrant blue matching the design
                    shape: BoxShape.circle,
                  ),
                )
              : null,
        ),
        
        // Avatar / Product Image
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFF0F0F0), width: 1),
          ),
          child: CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(imagePath),
            backgroundColor: Colors.transparent,
          ),
        ),
        const SizedBox(width: 16),
        
        // Text Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

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
            onTap: () => context.go('/home'), 
            child: const Icon(Icons.home_outlined, size: 28, color: Colors.black87),
          ),
          // Filled icon indicates active state on the Notifications screen
          const Icon(Icons.notifications, size: 28, color: Colors.black),
          GestureDetector(
            onTap: () => context.go('/profile'), 
            child: const Icon(Icons.person_outline, size: 28, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}