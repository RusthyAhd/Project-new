import 'package:flutter/material.dart';
import 'package:tap_on/ShopOwner/ShopOwnerDetailPage.dart';

class FilteredShopOwnersPage extends StatefulWidget {
  final List<dynamic> shopOwners;

  const FilteredShopOwnersPage({Key? key, required this.shopOwners})
      : super(key: key);

  @override
  _FilteredShopOwnersPageState createState() => _FilteredShopOwnersPageState();
}

class _FilteredShopOwnersPageState extends State<FilteredShopOwnersPage> {
  List<dynamic> filteredShopOwners = [];
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
    // Initially, show all shop owners
    filteredShopOwners = widget.shopOwners;
  }

  // Function to filter shop owners by selected location
  void filterShopOwnersByLocation(String location) {
    setState(() {
      selectedLocation = location;
      if (location == 'All') {
        // Show all shop owners if 'All' is selected
        filteredShopOwners = widget.shopOwners;
      } else {
        // Filter shop owners by location
        filteredShopOwners = widget.shopOwners.where((shopOwner) {
          return shopOwner['location'] == location;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Owners'),
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
                  filterShopOwnersByLocation(newValue);
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
            child: filteredShopOwners.isEmpty
                ? const Center(
                    child: Text('No shop owners found',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  )
                : ListView.builder(
                    itemCount: filteredShopOwners.length,
                    itemBuilder: (context, index) {
                      final shopOwner = filteredShopOwners[index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          title: Text(
                            shopOwner['shop_name'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            shopOwner['description'],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShopOwnerDetailPage(
                                  shopOwner: filteredShopOwners[index],
                                ),
                              ),
                            );
                          },
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
