import 'package:flutter/material.dart';
import 'package:tap_on/Providers/ServiceProviderDEtailsPage.dart';

class FilteredProvidersPage extends StatefulWidget {
  final List<dynamic> providers;

  const FilteredProvidersPage({Key? key, required this.providers})
      : super(key: key);

  @override
  _FilteredProvidersPageState createState() => _FilteredProvidersPageState();
}

class _FilteredProvidersPageState extends State<FilteredProvidersPage> {
  List<dynamic> filteredProviders = [];
  String selectedLocation = '';

  // List of locations for filtering
  final List<String> locations = [
    "All",
    "Colombo",
    "Gampaha",
    "Kalutara",
    "Kandy",
    "Matale",
    "Nuwara Eliya",
    "Galle",
    "Matara",
    "Hambantota",
    "Jaffna",
    "Kilinochchi",
    "Mannar",
    "Vavuniya",
    "Batticaloa",
    "Ampara",
    "Trincomalee",
    "Polonnaruwa",
    "Anuradhapura",
    "Dambulla",
    "Kurunegala",
    "Puttalam",
    "Ratnapura",
    "Kegalle",
    "Badulla",
    "Monaragala",
  ];

  @override
  void initState() {
    super.initState();
    // Initially, show all providers
    filteredProviders = widget.providers;
  }

  // Function to filter providers by selected location
  void filterProvidersByLocation(String location) {
    setState(() {
      selectedLocation = location;
      if (location == 'All') {
        // Show all providers if 'All' is selected
        filteredProviders = widget.providers;
      } else {
        // Filter providers by location
        filteredProviders = widget.providers.where((provider) {
          return provider['location'] == location;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtered Service Providers'),
        backgroundColor: Colors.amber[700],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: selectedLocation.isEmpty ? null : selectedLocation,
              hint: const Text('Select Location'),
              isExpanded: true,
              style: const TextStyle(color: Colors.black),
              iconEnabledColor: Colors.amber[700],
              onChanged: (String? newValue) {
                if (newValue != null) {
                  filterProvidersByLocation(newValue);
                }
              },
              items: locations.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: filteredProviders.isEmpty
                ? const Center(
                    child: Text('No providers found',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  )
                : ListView.builder(
                    itemCount: filteredProviders.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          title: Text(
                            filteredProviders[index]['name'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            filteredProviders[index]['service_title'],
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // Navigate to the provider details page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ServiceProviderDetailPage(
                                    provider: filteredProviders[index],
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.amber[700],
                            ),
                            child: const Text('Choose'),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
