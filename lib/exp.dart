import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('Settings')),
        body: SettingsList(),
      ),
    );
  }
}

class SettingsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(12),
      children: [
        CustomExpansionTile(
          icon: Icons.login,
          title: "Login Settings",
        ),
        CustomExpansionTile(
          icon: Icons.people,
          title: "Family Members",
        ),
        CustomExpansionTile(
          icon: Icons.shield,
          title: "Famillly Moment Premium", // Keeping the typo as in the image
        ),
      ],
    );
  }
}

class CustomExpansionTile extends StatelessWidget {
  final IconData icon;
  final String title;

  CustomExpansionTile({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.black54),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text("More options..."),
          ),
        ],
      ),
    );
  }
}
