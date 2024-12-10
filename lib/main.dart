import 'package:flutter/material.dart';
import 'package:weatherapp/pages/weatherpage.dart';
/*
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Weatherpage(),
    );
  }
}

*/


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedLocation = 'Enschede'; // Default location

  void updateLocation(String location) {
    setState(() {
      selectedLocation = location;
    });
    Navigator.pop(context); // Close the drawer after selection
  }

  void _reloadApp() {
    Navigator.pop(context); // Close the drawer
    updateLocation(selectedLocation); // Reload current location
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('App reloaded!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Choose Location',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              title: const Text('Enschede'),
              onTap: () {
                updateLocation('Enschede');
              },
            ),
            ListTile(
              title: const Text('Gronau'),
              onTap: () {
                updateLocation('Gronau');
              },
            ),
            ListTile(
              title: const Text('Wierden'),
              onTap: () {
                updateLocation('Wierden');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.refresh),
              title: const Text('Reload App'),
              onTap: () {
                _reloadApp();
              },
            ),
          ],
        ),
      ),
      body: Weatherpage(selectedLocation: selectedLocation),
    );
  }
}
