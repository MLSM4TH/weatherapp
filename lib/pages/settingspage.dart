import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final Function(bool) toggleTheme;
  final Function(bool) toggleMode;
  final bool isMinimalist;

  const SettingsPage({
    super.key,
    required this.toggleTheme,
    required this.toggleMode,
    required this.isMinimalist,
  });

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool _isDarkMode;
  late bool _isMinimalist;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isMinimalist;
    _isMinimalist = widget.isMinimalist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Theme Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: _isDarkMode,
                onChanged: (bool value) {
                  setState(() {
                    _isDarkMode = value;
                    widget.toggleTheme(value);
                  });
                },
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Display Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text('Minimalist Mode'),
              trailing: Switch(
                value: _isMinimalist,
                onChanged: (bool value) {
                  setState(() {
                    _isMinimalist = value;
                    widget.toggleMode(
                        value); // Toggle between minimalist and detailed mode
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
