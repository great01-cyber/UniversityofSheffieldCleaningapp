import 'package:flutter/material.dart';

class LeaveRequestPage extends StatefulWidget {
  @override
  _LeaveRequestPageState createState() => _LeaveRequestPageState();
}

class _LeaveRequestPageState extends State<LeaveRequestPage> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  String? selectedLeaveType;
  List<String> leaveTypes = ["Sick Leave", "Personal Leave", "Vacation", "Other"];

  List<Map<String, String>> leaveHistory = [
    {"date": "2024-02-15 to 2024-02-18", "type": "Vacation", "status": "Approved"},
    {"date": "2024-03-05 to 2024-03-07", "type": "Sick Leave", "status": "Pending"},
  ];

  Future<void> _selectDate(TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  void _submitLeaveRequest() {
    if (_startDateController.text.isEmpty ||
        _endDateController.text.isEmpty ||
        selectedLeaveType == null ||
        _reasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    setState(() {
      leaveHistory.add({
        "date": "${_startDateController.text} to ${_endDateController.text}",
        "type": selectedLeaveType!,
        "status": "Pending"
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Leave request submitted successfully!")),
    );

    _startDateController.clear();
    _endDateController.clear();
    _reasonController.clear();
    selectedLeaveType = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Annual Leave Request", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Request Leave", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
                    SizedBox(height: 15),
                    _buildTextField(_startDateController, "Start Date", Icons.calendar_today, () => _selectDate(_startDateController)),
                    SizedBox(height: 15),
                    _buildTextField(_endDateController, "End Date", Icons.calendar_today, () => _selectDate(_endDateController)),
                    SizedBox(height: 15),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[100],
                      ),
                      child: DropdownButtonFormField<String>(
                        value: selectedLeaveType,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Select Leave Type",
                          labelStyle: TextStyle(color: Colors.black87, fontSize: 16),
                        ),
                        items: leaveTypes.map((String type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type, style: TextStyle(fontSize: 16)),
                          );
                        }).toList(),
                        onChanged: (newValue) => setState(() => selectedLeaveType = newValue),
                      ),
                    ),

                    SizedBox(height: 15),
                    _buildTextField(_reasonController, "Reason for Leave", Icons.assignment, null, maxLines: 3),
                    SizedBox(height: 20),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _submitLeaveRequest,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: Colors.green,
                        ),
                        child: Text(
                          "Submit Request",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 25),

            // Leave History Section
            Text("Leave Request History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
            SizedBox(height: 10),
            ...leaveHistory.map((entry) => Card(
              color: Colors.grey[100],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                leading: Icon(Icons.history, color: Colors.green),
                title: Text(entry["date"]!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                subtitle: Text(entry["type"]!, style: TextStyle(fontSize: 14)),
                trailing: Chip(
                  label: Text(entry["status"]!, style: TextStyle(color: entry["status"] == "Approved" ? Colors.green : Colors.orange)),
                  backgroundColor: entry["status"] == "Approved" ? Colors.green[100] : Colors.orange[100],
                ),
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, VoidCallback? onTap, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      readOnly: onTap != null,
      maxLines: maxLines,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.green),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      ),
    );
  }
}
