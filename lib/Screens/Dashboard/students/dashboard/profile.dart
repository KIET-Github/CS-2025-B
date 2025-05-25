import 'dart:io'; // Import for File handling
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileDetailsPage extends StatefulWidget {
  final String userId;
  const ProfileDetailsPage({super.key, required this.userId});

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _branchController = TextEditingController();
  final _yearController = TextEditingController();
  final _libraryIdController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _emailController = TextEditingController();
  File? _image;
  String? _imageUrl;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _fetchStudentDetails();
  }

  Future<void> _fetchStudentDetails() async {
    try {
      final doc = await FirebaseFirestore.instance.collection('students').doc(widget.userId).get();
      if (doc.exists) {
        final data = doc.data()!;
        _nameController.text = data['name'] ?? '';
        _branchController.text = data['branch'] ?? '';
        _yearController.text = data['year'] ?? '';
        _libraryIdController.text = data['libraryId'] ?? '';
        _mobileNumberController.text = data['mobileNumber'] ?? '';
        _emailController.text = data['email'] ?? '';
        _imageUrl = data['imageUrl'];
        setState(() {});
      }
    } catch (e) {
      print('Error fetching student details: $e');
    }
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        if (_image != null) {
          final storageRef = FirebaseStorage.instance.ref().child('profile_images/${widget.userId}');
          final uploadTask = storageRef.putFile(_image!);
          final snapshot = await uploadTask;
          _imageUrl = await snapshot.ref.getDownloadURL();
        }

        await FirebaseFirestore.instance.collection('students').doc(widget.userId).update({
          'name': _nameController.text,
          'branch': _branchController.text,
          'year': _yearController.text,
          'libraryId': _libraryIdController.text,
          'mobileNumber': _mobileNumberController.text,
          'email': _emailController.text,
          'imageUrl': _imageUrl,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
        setState(() {
          _isEditing = false;
        });
      } catch (e) {
        print('Error updating profile: $e');
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

Widget _buildProfileImage() {
  const Widget placeholder = Icon(Icons.account_circle, size: 150);
  return CircleAvatar(
    radius:  60,
    backgroundColor: Colors.white,
    backgroundImage: _image != null
        ? FileImage(_image!)
        : _imageUrl != null
            ? NetworkImage(_imageUrl!) as ImageProvider<Object>?
            : null,
    child: _image == null && _imageUrl == null ? placeholder : null,
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     const SizedBox(height: 40,),
                    Container(
                      alignment: Alignment.topLeft,
                    width: 50,
                    decoration: const BoxDecoration(
                      backgroundBlendMode: BlendMode.lighten,
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: IconButton(
                      alignment: Alignment.topLeft,
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                   
                    Center(child: _buildProfileImage()),
                    Center(
                      child: ElevatedButton(
                        onPressed: _isEditing ? _pickImage : null,
                        child: Text(_image != null ? 'Update Image' : 'Upload Image'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: _isEditing ? _updateProfile : () {
                            setState(() {
                              _isEditing = true;
                            });
                          },
                          child: Text(_isEditing ? 'Save Changes' : 'Edit Profile'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ..._buildFormFields(),
                    const SizedBox(height: 20),
                    
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

  List<Widget> _buildFormFields() {
    return [
      _buildTextField(controller: _nameController, labelText: 'Name'),
      _buildTextField(controller: _branchController, labelText: 'Branch'),
      _buildTextField(controller: _yearController, labelText: 'Year'),
      _buildTextField(controller: _libraryIdController, labelText: 'Library Id'),
      _buildTextField(controller: _mobileNumberController, labelText: 'Mobile Number'),
      _buildTextField(controller: _emailController, labelText: 'Email'),
    ];
  }

  Widget _buildTextField({required TextEditingController controller, required String labelText}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $labelText.toLowerCase()';
        }
        return null;
      },
      readOnly: !_isEditing,
    );
  }
}
