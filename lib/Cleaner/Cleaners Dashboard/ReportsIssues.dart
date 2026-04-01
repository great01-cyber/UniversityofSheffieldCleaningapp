import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ReportsIssues extends StatefulWidget {
  const ReportsIssues({super.key});

  @override
  _ReportsIssuesState createState() => _ReportsIssuesState();
}

class _ReportsIssuesState extends State<ReportsIssues> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _doorNumberController = TextEditingController();
  bool _isFemaleToilet = false;
  bool _isMaleToilet = false;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  // Pick an image from the gallery or camera
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery); // Or ImageSource.camera
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Submit the report along with the image URL (since there's no upload to storage now)
  void _submitReport() {
    String description = _descriptionController.text;
    String floor = _floorController.text;
    String doorNumber = _doorNumberController.text;
    String toiletType = _isFemaleToilet ? "Female Toilet" : _isMaleToilet ? "Male Toilet" : "None";

    // You can store this in your database, or perform further actions
    print('Report submitted! Description: $description, Floor: $floor, Door Number: $doorNumber, Toilet Type: $toiletType');

    // Clear the form after submission
    _descriptionController.clear();
    _floorController.clear();
    _doorNumberController.clear();
    setState(() {
      _isFemaleToilet = false;
      _isMaleToilet = false;
      _image = null;
    });

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Report submitted successfully')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report Issues"),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Enter Description:'),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(hintText: 'Enter a description of the issue'),
              ),
              SizedBox(height: 20),
              Text('What Floor:'),
              TextField(
                controller: _floorController,
                decoration: InputDecoration(hintText: 'Enter floor number'),
              ),
              SizedBox(height: 20),
              Text('What is the Door Number:'),
              TextField(
                controller: _doorNumberController,
                decoration: InputDecoration(hintText: 'Enter door number'),
              ),
              SizedBox(height: 20),
              Text('Toilet Type:'),
              Row(
                children: [
                  Checkbox(
                    value: _isFemaleToilet,
                    onChanged: (value) {
                      setState(() {
                        _isFemaleToilet = value!;
                        _isMaleToilet = false;
                      });
                    },
                  ),
                  Text('Female Toilet'),
                  Checkbox(
                    value: _isMaleToilet,
                    onChanged: (value) {
                      setState(() {
                        _isMaleToilet = value!;
                        _isFemaleToilet = false;
                      });
                    },
                  ),
                  Text('Male Toilet'),
                ],
              ),
              SizedBox(height: 20),
              Text('Upload Image (Optional):'),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
              SizedBox(height: 10),
              _image == null
                  ? Text('No image selected.')
                  : Image.file(_image!, height: 100, width: 100, fit: BoxFit.cover),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_descriptionController.text.isNotEmpty && _floorController.text.isNotEmpty && _doorNumberController.text.isNotEmpty) {
                    _submitReport();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill all required fields')));
                  }
                },
                child: Text('Submit Report'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
