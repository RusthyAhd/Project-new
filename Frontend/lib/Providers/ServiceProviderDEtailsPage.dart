import 'package:flutter/material.dart';

class ServiceProviderDetailPage extends StatelessWidget {
  final dynamic provider;

  const ServiceProviderDetailPage({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(provider['name']),
        backgroundColor: Colors.yellow[700],
      ),
      body: SingleChildScrollView(
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
                for (var i = 0; i < 5; i++)
                  Icon(i < (provider['rating'] ?? 0).round() ? Icons.star : Icons.star_border, color: Colors.amber),
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
                      // Implement send request functionality here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Request sent')),
                      );
                    },
                    child: const Text('Send Request'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.yellow,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Implement pre-booking functionality here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Pre-booking successful')),
                      );
                    },
                    child: const Text('Pre-booking'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.yellow,
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
    );
  }
}
