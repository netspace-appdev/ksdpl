import 'package:flutter/material.dart';

class MyFilesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> fileOptions = [
    {"label": "Follow up", "icon": Icons.feedback, "color": Colors.purple},
    {"label": "Open Poll", "icon": Icons.lock_open, "color": Colors.pink},
    {"label": "Details", "icon": Icons.insert_drive_file, "color": Colors.green},

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "My Files",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: fileOptions.map((option) {
                return _buildNeumorphicButton(option);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNeumorphicButton(Map<String, dynamic> option) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: option["color"],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(4, 4),
                blurRadius: 6,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-4, -4),
                blurRadius: 6,
              ),
            ],
          ),
          child: Icon(option["icon"], color: Colors.white, size: 30),
        ),
        SizedBox(height: 6),
        Text(
          option["label"],
          style: TextStyle(fontSize: 12, color: Colors.grey[800]),
        ),
      ],
    );
  }
}
