import 'package:flutter/material.dart';

// --- Data Model for a Report ---
// This class holds the data for a single report, now with a 'comment' field
class Report {
  final String type;
  final String personName;
  final String time;
  final String place;
  final String comment; // <-- The new "actual comment" field
  final IconData icon;
  final Color color;

  Report({
    required this.type,
    required this.personName,
    required this.time,
    required this.place,
    required this.comment,
    required this.icon,
    required this.color,
  });
}

// --- Hard-Coded Data ---
// A list of sample reports, now including comments
final List<Report> hardCodedReports = [
  Report(
    type: 'Slip and Fall',
    personName: 'John Doe',
    time: '09:15 AM, Oct 28',
    place: 'Main Lobby',
    comment: 'Water spill from a plant pot was not signposted. Cleaned up and placed a wet floor sign.',
    icon: Icons.airline_stops_rounded,
    color: Colors.blue.shade700,
  ),
  Report(
    type: 'Accident',
    personName: 'Jane Smith',
    time: '11:30 AM, Oct 27',
    place: 'Kitchen Area',
    comment: 'Dropped a box of supplies on foot. Minor bruising. Requested ice pack from front desk.',
    icon: Icons.personal_injury_outlined,
    color: Colors.red.shade700,
  ),
  Report(
    type: 'Near Miss',
    personName: 'Mike Johnson',
    time: '02:45 PM, Oct 27',
    place: 'Corridor B',
    comment: 'A trolley with a broken wheel almost tipped over. Caught it just in time. Trolley has been removed from service.',
    icon: Icons.notification_important_outlined,
    color: Colors.amber.shade800,
  ),
  Report(
    type: 'Incident',
    personName: 'Sarah Chen',
    time: '08:00 AM, Oct 26',
    place: 'Storage Room',
    comment: 'Found an unsecured chemical cabinet. All bottles were accounted for, but the lock is broken. Reported to maintenance.',
    icon: Icons.warning_amber_rounded,
    color: Colors.orange.shade700,
  ),
  Report(
    type: 'Slip and Fall',
    personName: 'David Lee',
    time: '03:20 PM, Oct 25',
    place: 'Restroom 3',
    comment: 'Guest reported slipping on a paper towel on the floor. No injury, just startled. Ensured all paper towels were in bins.',
    icon: Icons.airline_stops_rounded,
    color: Colors.blue.shade700,
  ),
];

// --- The Main Page Widget ---
class supervisorReportAccidents extends StatefulWidget {
  const supervisorReportAccidents({super.key});

  @override
  State<supervisorReportAccidents> createState() => _supervisorReportAccidentsState();
}

class _supervisorReportAccidentsState extends State<supervisorReportAccidents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Incident Reports",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      backgroundColor: Colors.grey[100], // Light grey background
      body: ListView.builder(
        // This makes the list scrollable
        padding: const EdgeInsets.all(16.0),
        itemCount: hardCodedReports.length,
        itemBuilder: (context, index) {
          // Build a card for each report in our list
          return _buildReportCard(hardCodedReports[index]);
        },
      ),
    );
  }

  /// Helper widget to build a single, fancy report card
  Widget _buildReportCard(Report report) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 3,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias, // Keeps the color bar neatly inside
      child: Row(
        // This Row creates the color stripe on the left
        children: [
          // 1. The Color Bar
          Container(
            width: 10,
            // Self-sizing height based on content
            constraints: const BoxConstraints(minHeight: 150),
            color: report.color,
          ),

          // 2. The Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Header: Icon and Type ---
                  Row(
                    children: [
                      Icon(report.icon, color: report.color, size: 28),
                      const SizedBox(width: 12),
                      Text(
                        report.type,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: report.color,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24, thickness: 0.5),

                  // --- Details: Person, Time, Place ---
                  _buildDetailRow(
                    icon: Icons.person_pin_rounded,
                    text: report.personName,
                  ),
                  const SizedBox(height: 10),
                  _buildDetailRow(
                    icon: Icons.access_time_filled_rounded,
                    text: report.time,
                  ),
                  const SizedBox(height: 10),
                  _buildDetailRow(
                    icon: Icons.location_on_rounded,
                    text: report.place,
                  ),

                  // --- New Comment Section ---
                  const Divider(height: 24, thickness: 0.5),
                  _buildDetailRow(
                    icon: Icons.notes_rounded,
                    text: "Reporter's Comment",
                    isTitle: true,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0), // Indent comment
                    child: Text(
                      report.comment,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.7),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget for the detail rows (Person, Time, Place, and Comment Title)
  Widget _buildDetailRow({
    required IconData icon,
    required String text,
    bool isTitle = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: isTitle ? 15 : 15,
              fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
              color: isTitle ? Colors.black87 : Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }
}