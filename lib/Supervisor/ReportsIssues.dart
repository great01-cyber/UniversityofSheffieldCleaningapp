import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportsIssuesS extends StatelessWidget {
  const ReportsIssuesS({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report Issues"),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Issue Title",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Issue Description",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Logic to submit issue report
                },
                child: Text("Submit Report"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
