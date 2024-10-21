import 'package:flutter/material.dart';

class ShopOwnerDetailPage extends StatelessWidget {
  final dynamic shopOwner;

  const ShopOwnerDetailPage({Key? key, required this.shopOwner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shopOwner['shop_name']),
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
                  backgroundImage: NetworkImage(shopOwner['imageUrl'] ?? 'https://via.placeholder.com/150'), // Placeholder image
                ),
              ),
              const SizedBox(height: 20),

              // Shop Name
              Text(
                shopOwner['shop_name'],
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Owner Name
              Text(
                shopOwner['name'],
                style: const TextStyle(fontSize: 20, color: Colors.grey),
              ),
              const Divider(height: 20, thickness: 2),

              // Address
              Text(
                "Address: ${shopOwner['address']}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),

              // Contact Information
              Text(
                "Contact: ${shopOwner['phone'] ?? 'N/A'}",
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
                shopOwner['description'] ?? 'No description available.',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Rating Section (if applicable)
              if (shopOwner['rating'] != null) ...[
                Row(
                  children: [
                    const Text(
                      "Rating: ",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    // Placeholder for rating stars
                    for (var i = 0; i < (shopOwner['rating'] as int); i++)
                      const Icon(Icons.star, color: Colors.amber),
                    for (var i = 0; i < (5 - (shopOwner['rating'] as int)); i++)
                      const Icon(Icons.star_border, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      shopOwner['rating']?.toString() ?? 'N/A',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],

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
                        backgroundColor: Colors.amber[700],
                        foregroundColor: Colors.black,
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
                        backgroundColor: Colors.amber[700],
                        foregroundColor: Colors.black,
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
