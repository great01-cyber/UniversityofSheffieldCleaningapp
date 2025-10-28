import 'package:flutter/material.dart';

// --- Data Model for a Report ---
class Report {
  final String type;
  final String personName;
  final String time;
  final String place;
  final String comment;
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

// --- Main Page Widget ---
class CleanerReportAccidents extends StatefulWidget {
  const CleanerReportAccidents({super.key});

  @override
  State<CleanerReportAccidents> createState() =>
      _CleanerReportAccidentsState();
}

class _CleanerReportAccidentsState extends State<CleanerReportAccidents> {
  final List<Report> reports = [];

  // --- Form Controllers ---
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _typeController.dispose();
    _nameController.dispose();
    _timeController.dispose();
    _placeController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cleaner Reports", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- Input Form ---
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(_typeController, 'Incident Type'),
                  const SizedBox(height: 12),
                  const SizedBox(height: 12),
                  _buildTextField(_timeController, 'Time (e.g., 09:15 AM, Oct 28)'),
                  const SizedBox(height: 12),
                  _buildTextField(_placeController, 'Place/Location'),
                  const SizedBox(height: 12),
                  _buildTextField(_commentController, 'Comment', maxLines: 3),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.send),
                      label: const Text('Submit Report'),
                      onPressed: _submitReport,
                    ),
                  ),
                  const Divider(height: 32, thickness: 1),
                ],
              ),
            ),

            // --- Display Submitted Reports ---
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: reports.length,
              itemBuilder: (context, index) {
                return _buildReportCard(reports[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper: TextField ---
  Widget _buildTextField(TextEditingController controller, String label,
      {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        fillColor: Colors.white,
        filled: true,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  // --- Submit a Report ---
  void _submitReport() {
    if (_formKey.currentState!.validate()) {
      final newReport = Report(
        type: _typeController.text,
        personName: _nameController.text,
        time: _timeController.text,
        place: _placeController.text,
        comment: _commentController.text,
        icon: Icons.report_problem_rounded,
        color: Colors.blue.shade700,
      );

      setState(() {
        reports.insert(0, newReport); // Newest first
        _typeController.clear();
        _nameController.clear();
        _timeController.clear();
        _placeController.clear();
        _commentController.clear();
      });
    }
  }

  // --- Report Card Widget ---
  Widget _buildReportCard(Report report) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 3,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Container(
            width: 10,
            constraints: const BoxConstraints(minHeight: 150),
            color: report.color,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  _buildDetailRow(Icons.person_pin_rounded, report.personName),
                  const SizedBox(height: 10),
                  _buildDetailRow(Icons.access_time_filled_rounded, report.time),
                  const SizedBox(height: 10),
                  _buildDetailRow(Icons.location_on_rounded, report.place),
                  const Divider(height: 24, thickness: 0.5),
                  _buildDetailRow(Icons.notes_rounded, "Comment", isTitle: true),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
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

  Widget _buildDetailRow(IconData icon, String text, {bool isTitle = false}) {
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
