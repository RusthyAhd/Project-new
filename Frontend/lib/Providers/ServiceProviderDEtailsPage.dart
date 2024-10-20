import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceProviderDetailPage extends StatelessWidget {
  final dynamic provider;

  const ServiceProviderDetailPage({Key? key, required this.provider}) : super(key: key);

  Future<void> _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(provider['name']),
        backgroundColor: Colors.amber[700],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(provider['imageUrl'] ?? 'https://via.placeholder.com/150'), // Placeholder image
                ),
              ),
              const SizedBox(height: 20),

              // Provider Name
              Text(
                provider['name'],
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Service Title
              Text(
                provider['service_title'],
                style: const TextStyle(fontSize: 20, color: Colors.grey),
              ),
              const Divider(height: 20, thickness: 2),

              // Address
              Text(
                "Address: ${provider['address']}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),

              // Contact Information
              Text(
                "Contact: ${provider['contact'] ?? 'N/A'}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),

              // Description
              Text(
                "Description:",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                provider['description'] ?? 'No description available.',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Rating Section
              Row(
                children: [
                  const Text(
                    "Rating: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  // Placeholder for rating stars
                  const Icon(Icons.star, color: Colors.amber),
                  const Icon(Icons.star, color: Colors.amber),
                  const Icon(Icons.star, color: Colors.amber),
                  const Icon(Icons.star, color: Colors.amber),
                  const Icon(Icons.star_border, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    provider['rating']?.toString() ?? 'N/A',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Action Buttons
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        final phone = provider['contact'];
                        if (phone != null && phone.isNotEmpty) {
                          _launchURL('tel:$phone');
                        }
                      },
                      child: const Text('Call Provider'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber[700],
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        final email = provider['email'];
                        if (email != null && email.isNotEmpty) {
                          _launchURL('mailto:$email');
                        }
                      },
                      child: const Text('Email Provider'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber[700],
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        final website = provider['website'];
                        if (website != null && website.isNotEmpty) {
                          _launchURL(website);
                        }
                      },
                      child: const Text('Visit Website'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber[700],
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
