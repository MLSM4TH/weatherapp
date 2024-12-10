import 'package:flutter/material.dart';
import 'package:weatherapp/pages/weatherpage.dart';
import 'package:weatherapp/pages/settingspage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;
  bool _isMinimalist = true;

  // Function to toggle the theme mode (light/dark)
  void _toggleTheme(bool isDarkMode) {
    setState(() {
      _isDarkMode = isDarkMode;
    });
  }

  // Function to toggle between minimalist and detailed modes
  void _toggleMode(bool isMinimalist) {
    setState(() {
      _isMinimalist = isMinimalist;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: MyHomePage(
        toggleTheme: _toggleTheme,
        toggleMode: _toggleMode,
        isMinimalist: _isMinimalist,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Function(bool) toggleTheme;
  final Function(bool) toggleMode;
  final bool isMinimalist;

  const MyHomePage({
    super.key,
    required this.toggleTheme,
    required this.toggleMode,
    required this.isMinimalist,
  });

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
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(
                    toggleTheme: widget.toggleTheme,
                    toggleMode: widget.toggleMode,
                    isMinimalist: widget.isMinimalist,
                  ), // Pass both toggle functions and the current mode
                ),
              );
            },
          ),
        ],
      ),
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
      body: Weatherpage(
        selectedLocation: selectedLocation,
        isMinimalistMode: widget.isMinimalist, // Pass the minimalist mode here
      ),
    );
  }
}
