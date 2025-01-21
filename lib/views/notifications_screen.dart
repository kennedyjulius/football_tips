import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<NotificationItem> _notifications = [
    NotificationItem(
      title: 'New Match Tip Available',
      message: 'Check out our prediction for Manchester United vs Arsenal',
      type: NotificationType.tip,
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      isRead: false,
    ),
    NotificationItem(
      title: 'Tip Success!',
      message: 'Your previous tip for Chelsea vs Liverpool was successful',
      type: NotificationType.success,
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      isRead: true,
    ),
    NotificationItem(
      title: 'Daily Tips Updated',
      message: 'New tips have been added for today\'s matches',
      type: NotificationType.update,
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              setState(() {
                _notifications.clear();
              });
            },
          ),
        ],
      ),
      body: _notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No notifications',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return Dismissible(
                  key: Key(notification.timestamp.toString()),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      _notifications.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Notification dismissed'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: _getNotificationIcon(notification.type),
                    title: Text(
                      notification.title,
                      style: TextStyle(
                        fontWeight:
                            notification.isRead ? FontWeight.normal : FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notification.message),
                        const SizedBox(height: 4),
                        Text(
                          _formatTimestamp(notification.timestamp),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        notification.isRead = true;
                      });
                      // Handle notification tap
                    },
                  ),
                );
              },
            ),
    );
  }

  Widget _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.tip:
        return const CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.sports_soccer, color: Colors.white),
        );
      case NotificationType.success:
        return const CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(Icons.check, color: Colors.white),
        );
      case NotificationType.update:
        return const CircleAvatar(
          backgroundColor: Colors.orange,
          child: Icon(Icons.update, color: Colors.white),
        );
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return DateFormat('MMM d, h:mm a').format(timestamp);
    }
  }
}

class NotificationItem {
  final String title;
  final String message;
  final NotificationType type;
  final DateTime timestamp;
  bool isRead;

  NotificationItem({
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    required this.isRead,
  });
}

enum NotificationType {
  tip,
  success,
  update,
}