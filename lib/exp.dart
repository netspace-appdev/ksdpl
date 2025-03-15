import 'package:flutter/material.dart';

class LeadDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lead Details"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Lead Details Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Lead Details",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),

                      SizedBox(height: 10),

                      // Status Tags
                      Wrap(
                        spacing: 8,
                        children: [
                          StatusChip(label: "Interested", color: Colors.orange),
                          StatusChip(label: "Fresh", color: Colors.green),
                          StatusChip(label: "Salaried", color: Colors.blue),
                        ],
                      ),

                      SizedBox(height: 10),

                      DetailRow(label: "Date", value: "23-07-2024 16:51"),
                      DetailRow(label: "Full Name", value: "Akash Patel"),
                      DetailRow(label: "Gender", value: "Male"),
                      DetailRow(label: "Email Address", value: "Info@Gmail.Com"),
                      DetailRow(label: "Phone", value: "968574123"),
                      DetailRow(label: "Adhar Card", value: "5552225522445"),
                      DetailRow(label: "Pan No", value: "PN95840278"),
                      DetailRow(label: "District", value: "Ujjain"),
                      DetailRow(label: "City", value: "Ujjain"),
                      DetailRow(label: "Monthly Income", value: "252500"),
                      DetailRow(label: "Loan Amount", value: "25000"),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Phone Number Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Phone Number",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text("+91 978654321",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),

                      // Icon Buttons
                      Row(
                        children: [
                          IconButtonWidget(
                              icon: Icons.share, color: Colors.orange),
                          IconButtonWidget(
                              icon: Icons.phone, color: Colors.green),
                          IconButtonWidget(
                              icon: Icons.message, color: Colors.blue),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Lead Details Description
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Lead Details",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text(
                        "Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry.",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper Widget for Status Chips
class StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyle(color: color)),
    );
  }
}

// Helper Widget for Detail Rows
class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("$label: ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Expanded(
              child: Text(value, style: TextStyle(fontSize: 14), maxLines: 1)),
        ],
      ),
    );
  }
}

// Helper Widget for Icon Buttons
class IconButtonWidget extends StatelessWidget {
  final IconData icon;
  final Color color;

  IconButtonWidget({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: CircleAvatar(
        backgroundColor: color.withOpacity(0.2),
        child: Icon(icon, color: color),
      ),
    );
  }
}
