import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactSupportScreen extends StatelessWidget {
  const ContactSupportScreen({super.key});

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch \$url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact & Support'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Header Section
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.support_agent,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'How can we help you?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Choose your preferred way to contact us',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            
            // Contact Options
            _buildContactCard(
              context,
              icon: FontAwesomeIcons.whatsapp,
              title: 'WhatsApp',
              subtitle: 'Chat with us on WhatsApp',
              onTap: () => _launchUrl('https://wa.me/+254743702820'), // Replace with your WhatsApp number
              color: const Color(0xFF25D366), // WhatsApp green
            ),
            
            const SizedBox(height: 16),
            _buildContactCard(
              context,
              icon: Icons.email,
              title: 'Email',
              subtitle: 'Send us an email',
              onTap: () => _launchUrl('kennedymutugi111@gmail.com'), // Replace with your email
              color: Colors.red,
            ),
            
            const SizedBox(height: 16),
            _buildContactCard(
              context,
              icon: Icons.phone,
              title: 'Phone',
              subtitle: '+254 743 702 820', // Replace with your phone number
              onTap: () => _launchUrl('tel:+254743702820'),
              color: Colors.blue,
            ),
            
            const SizedBox(height: 16),
            _buildContactCard(
              context,
              icon: Icons.telegram,
              title: 'Telegram',
              subtitle: 'Contact us onour Telegram channel',
              onTap: () => _launchUrl('https://t.me/kennedymutugiJ2'),
        
              color: const Color(0xFF0088cc), // Telegram blue
            ),
            
            const SizedBox(height: 32),
            // Business Hours Section
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Business Hours',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Monday - Friday: 9:00 AM - 6:00 PM'),
                    Text('Saturday: 10:00 AM - 4:00 PM'),
                    Text('Sunday: Closed'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(
            icon,
            color: color,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey[400],
        ),
        onTap: onTap,
      ),
    );
  }
}
