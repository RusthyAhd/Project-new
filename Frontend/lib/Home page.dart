import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tap_on/Providers/FilteredProvidersPage.dart';
import 'package:tap_on/Toollogin.dart';
import 'dart:convert'; // For JSON handling
import 'package:tap_on/Users/Notification.dart';
import 'package:tap_on/Users/edit%20profile.dart';
import 'package:tap_on/Servicelogin.dart';
import 'package:tap_on/user-renttools/Tool%20location.dart';
import 'package:tap_on/user-services/location.dart';
import 'package:tap_on/Users/Chatbot.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  String errorMessage = '';

  // Fetch Service Providers by Category
  Future<void> fetchProvidersByCategory(String category) async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response = await http.get(
        Uri.parse('http://localhost:3000/api/v1/service/service-providers/category/$category'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> serviceProviders = json.decode(response.body)['data'] ?? [];
        
        // Navigate to FilteredProvidersPage with the fetched service providers
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FilteredProvidersPage(providers: serviceProviders),
          ),
        );
      } else {
        setState(() {
          errorMessage = 'Failed to load service providers: ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TapOn'),
        backgroundColor: Colors.amber[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NotificationPage()));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            title: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              child: const Text("Profile"),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.support_agent),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatPage()),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              'Choose Your Service',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 233, 231, 207),
              child: GridView.count(
                crossAxisCount: 3,
                padding: const EdgeInsets.all(10.0),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  ServiceCard(
                    icon: Icons.plumbing,
                    label: 'Plumber',
                    onTap: () {
                      fetchProvidersByCategory('Plumber');
                    },
                  ),
                  ServiceCard(
                    icon: Icons.face,
                    label: 'Beauty',
                    onTap: () {
                      fetchProvidersByCategory('Beauty');
                    },
                  ),
                  ServiceCard(
                    icon: Icons.phone_iphone,
                    label: 'Phone Repair',
                    onTap: () {
                      fetchProvidersByCategory('Phone Repair');
                    },
                  ),
                  ServiceCard(
                    icon: Icons.miscellaneous_services,
                    label: 'Other',
                    onTap: () {
                      fetchProvidersByCategory('Other');
                    },
                  ),
                  // Add more services as needed
                ],
              ),
            ),
          ),
          // Loading Indicator
          if (isLoading) const CircularProgressIndicator(),
          if (errorMessage.isNotEmpty)
            Text(errorMessage, style: TextStyle(color: Colors.red)),
                     const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              'Rent Tools',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 233, 231, 207),
              child: GridView.count(
                crossAxisCount: 3,
                padding: const EdgeInsets.all(10.0),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  ServiceCard(
                    icon: Icons.plumbing,
                    label: 'Plumbing Tools',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TLocationPage()),
                      );
                    },
                  ),
                  ServiceCard(
                    icon: Icons.electrical_services,
                    label: 'Electrical Tools',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TLocationPage()),
                      );
                    },
                  ),
                  ServiceCard(
                    icon: Icons.construction,
                    label: 'Carpenting Tools',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TLocationPage()),
                      );
                    },
                  ),
                  ServiceCard(
                    icon: Icons.format_paint,
                    label: 'Painting Tools',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TLocationPage()),
                      );
                    },
                  ),
                  ServiceCard(
                    icon: Icons.grass,
                    label: 'Gardening Tools',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TLocationPage()),
                      );
                    },
                  ),
                  ServiceCard(
                    icon: Icons.kitchen,
                    label: 'Repairing Tools',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TLocationPage()),
                      );
                    },
                  ),
                  ServiceCard(
                    icon: Icons.build,
                    label: 'Building Tools',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TLocationPage()),
                      );
                    },
                  ),
                  ServiceCard(
                    icon: Icons.phone_android,
                    label: 'Phone Accessories',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TLocationPage()),
                      );
                    },
                  ),
                  ServiceCard(
                    icon: Icons.content_cut,
                    label: 'Other',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TLocationPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                // Handle User button press
              },
              child: const Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 8),
                  Text('User'),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TLoginPage()));
                // Handle Shop Owner button press
              },
              child: const Row(
                children: [
                  Icon(Icons.store),
                  SizedBox(width: 8),
                  Text('Shop Owner'),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PLoginPage()));
                // Handle Shop Owner button press
              },

              // Handle Provider button press

              child: const Row(
                children: [
                  Icon(Icons.engineering),
                  SizedBox(width: 8),
                  Text('Provider'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
     

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ServiceCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: const Color.fromARGB(255, 250, 184, 78),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            const SizedBox(height: 10),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
