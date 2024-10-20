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
  String selectedAddress = '';

  // Sample locations for demonstration
  final List<String> addresses = [
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

  void filterProvidersByLocation(String address) {
    setState(() {
      selectedAddress = address;
      if (address == 'All') {
        // If 'All' is selected, show all providers
        filteredProviders = widget.providers;
      } else {
        // Filter the providers based on selected location
        filteredProviders = widget.providers.where((provider) {
          return provider['address'] ==
              address; // Adjust the key based on your data structure
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
              value: selectedAddress.isEmpty ? null : selectedAddress,
              hint: const Text('Select Location'),
              isExpanded: true,
              style: const TextStyle(color: Colors.black),
              iconEnabledColor: Colors.amber[700],
              onChanged: (String? newValue) {
                if (newValue != null) {
                  filterProvidersByLocation(newValue);
                }
              },
              items: addresses.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: filteredProviders.isEmpty
                ? Center(
                    child: const Text('No providers found',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)))
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(filteredProviders[index]['service_title']),
                                const SizedBox(height: 4),
                                Text(
                                  filteredProviders[index]['address'],
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ServiceProviderDetailPage(
                        provider: filteredProviders[index],),
                                ),
                              );
                            }),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
