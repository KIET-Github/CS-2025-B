// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ApplicationFormPage extends StatefulWidget {
  final String club;
  const ApplicationFormPage({
    Key? key,
    required this.club,
  }) : super(key: key);

  @override
  _ApplicationFormPageState createState() => _ApplicationFormPageState();
}

class _ApplicationFormPageState extends State<ApplicationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _branchController = TextEditingController();
  final _yearController = TextEditingController();
  final _positionController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _linkedinController = TextEditingController();
  final _githubController = TextEditingController();
  final _portfolioController = TextEditingController();
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 500,
          height: 1000,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 24, 96, 252),
                Color.fromARGB(255, 255, 255, 224),
                Color.fromARGB(255, 209, 232, 247),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Application Form',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(child: _buildImagePicker()),
                    const SizedBox(height: 20),
                    _buildTextField(_nameController, 'Name'),
                    _buildTextField(_branchController, 'Branch'),
                    _buildTextField(_yearController, 'Year'),
                    _buildTextField(_positionController, 'Position'),
                    _buildTextField(_mobileNumberController, 'Mobile Number'),
                    _buildTextField(_emailController, 'Email'),
                    _buildTextField(_linkedinController, 'LinkedIn ID'),
                    _buildTextField(_githubController, 'GitHub ID'),
                    _buildTextField(_portfolioController, 'Portfolio ID'),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: _submitApplication,
                        child: const Text('Submit Application'),
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildImagePicker() {
    return Column(
      children: [
        _image != null
            ? Image.file(_image!, height: 100, width: 100)
            : Container(
                child: const Icon(
                  Icons.camera_front_rounded,
                  color: Colors.white,
                  size: 55,
                ),
              ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: _pickImage,
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          child: const Text(
            'Pick Image',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _submitApplication() async {
    if (_formKey.currentState?.validate() ?? false) {
      String? imageUrl;
      if (_image != null) {
        imageUrl = await _uploadImage(_image!);
      }

      await FirebaseFirestore.instance.collection(widget.club).add({
        'name': _nameController.text,
        'branch': _branchController.text,
        'year': _yearController.text,
        'position': _positionController.text,
        'mobileNumber': _mobileNumberController.text,
        'email': _emailController.text,
        'linkedinId': _linkedinController.text,
        'githubId': _githubController.text,
        'portfolioId': _portfolioController.text,
        'imageUrl': imageUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Application Submitted Successfully')),
      );

      // Clear the form
      _formKey.currentState?.reset();
      setState(() {
        _image = null;
      });

       // Navigate back to the previous page
      Navigator.pop(context);
    }
  }

  Future<String> _uploadImage(File image) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('applicant_photos')
        .child('${DateTime.now().toIso8601String()}.jpg');

    try {
      final uploadTask = storageRef.putFile(image);
      final snapshot = await uploadTask.whenComplete(() => null);
      String downloadURL = await snapshot.ref.getDownloadURL();
      print('File uploaded successfully. Download URL: $downloadURL');
      return downloadURL;
    } catch (e) {
      print('Error uploading file: $e');
      rethrow;
    }
  }
}
