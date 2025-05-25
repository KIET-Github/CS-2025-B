import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ClubDataPage extends StatefulWidget {
  const ClubDataPage({super.key});

  @override
  State<ClubDataPage> createState() => _ClubDataPageState();
}

class _ClubDataPageState extends State<ClubDataPage> {
  final _formKey = GlobalKey<FormState>();
  final _clubNameController = TextEditingController();
  final _dateOfEstablishmentController = TextEditingController();
  final _establishedByController = TextEditingController();
  final _clubTypeController = TextEditingController();
  final _facaltyCoordinatorsController = TextEditingController();
  final _presidentController = TextEditingController();
  final _vicePrecidentController = TextEditingController();
  final _tecnicalHeadController = TextEditingController();
  final _managementHeadController = TextEditingController();
  final _graphicsHeadController = TextEditingController();
  final _prHeadController = TextEditingController();
  final _totalMembersController = TextEditingController();
  File? _image;
  String? _imageUrl;
  String? userId;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
      _fetchClubDetails(userId!);
    }
  }

  Future<void> _fetchClubDetails(String userId) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('clubs')
          .doc(userId)
          .get();
      if (doc.exists) {
        final data = doc.data()!;
        _clubNameController.text = data['clubname'] ?? '';
        _dateOfEstablishmentController.text = data['dateOfEstablishment'] ?? '';
        _establishedByController.text = data['establishedBy'] ?? '';
        _clubTypeController.text = data['clubType'] ?? '';
        _facaltyCoordinatorsController.text = data['facaltyCoordinators'] ?? '';
        _presidentController.text = data['president'] ?? '';
        _vicePrecidentController.text = data['vicePrecident'] ?? '';
        _tecnicalHeadController.text = data['tecnicalHead'] ?? '';
        _managementHeadController.text = data['managementHead'] ?? '';
        _graphicsHeadController.text = data['graphicsHead'] ?? '';
        _prHeadController.text = data['prHead'] ?? '';
        _totalMembersController.text = data['totalMembers'] ?? '';
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
          final storageRef =
              FirebaseStorage.instance.ref().child('profile_images/$userId');
          final uploadTask = storageRef.putFile(_image!);
          final snapshot = await uploadTask;
          _imageUrl = await snapshot.ref.getDownloadURL();
        }

        await FirebaseFirestore.instance
            .collection('clubs')
            .doc(userId)
            .update({
          'clubname': _clubNameController.text,
          'dateOfEstablishment': _dateOfEstablishmentController.text,
          'establishedBy': _establishedByController.text,
          'clubType': _clubTypeController.text,
          'facaltyCoordinators': _facaltyCoordinatorsController.text,
          'president': _presidentController.text,
          'vicePrecident': _vicePrecidentController.text,
          'tecnicalHead': _tecnicalHeadController.text,
          'managementHead': _managementHeadController.text,
          'graphicsHead': _graphicsHeadController.text,
          'prHead': _prHeadController.text,
          'totalMembers': _totalMembersController.text,
          'imageUrl': _imageUrl,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Club profile updated successfully')),
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
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _refreshData() async {
    if (userId != null) {
      await _fetchClubDetails(userId!);
    }
  }

  Widget _buildProfileImage() {
    const Widget placeholder = Icon(Icons.account_circle, size: 150);
    return CircleAvatar(
      radius: 60,
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
        child: SizedBox(
          width: 400,
          height: 1000,
          child: RefreshIndicator(
            onRefresh: _refreshData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('clubs')
                        .doc(userId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return const Center(child: Text('Error loading data.'));
                      }

                      if (!snapshot.hasData || !snapshot.data!.exists) {
                        return const Center(child: Text('No data available.'));
                      }

                      final data =
                          snapshot.data!.data() as Map<String, dynamic>;

                      _imageUrl = data['imageUrl'] ?? '';

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 10,),
                          IconButton(
                            alignment: Alignment.topLeft,
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                              size: 26,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(width: 5,),
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                (_imageUrl != null && _imageUrl!.isNotEmpty)
                                    ? NetworkImage(_imageUrl!)
                                    : null,
                            child: (_imageUrl == null || _imageUrl!.isEmpty)
                                ? const Icon(
                                    Icons.account_circle,
                                    size: 50,
                                    color: Colors.black,
                                  )
                                : null,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: Text(
                              _clubNameController
                                  .text, // Replace with student's name
                              style: const TextStyle(
                                fontSize: 20.0,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.right,

                            ),
                          ),
                          // IconButton(
                            
                          //     onPressed: () {},
                          //     icon: const Icon(
                          //       Icons.notifications_active_outlined,
                          //       color: Colors.black,
                          //       size: 25,
                          //     )),
                        ],
                      );
                    },
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                "Club Data",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(child: _buildProfileImage()),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: ElevatedButton(
                                onPressed: _isEditing ? _pickImage : null,
                                child: Text(_image != null
                                    ? 'Update Image'
                                    : 'Upload Image'),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: _isEditing
                                      ? _updateProfile
                                      : () {
                                          setState(() {
                                            _isEditing = true;
                                          });
                                        },
                                  child: Text(_isEditing
                                      ? 'Save Changes'
                                      : 'Edit Profile'),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    return [
      _buildTextField(controller: _clubNameController, labelText: 'Club Name'),
      _buildTextField(
          controller: _dateOfEstablishmentController,
          labelText: 'Date Of Establishment'),
      _buildTextField(
          controller: _establishedByController, labelText: 'Established By'),
      _buildTextField(controller: _clubTypeController, labelText: 'Club Type'),
      _buildTextField(
          controller: _facaltyCoordinatorsController,
          labelText: 'Facalty Coordinators'),
      _buildTextField(controller: _presidentController, labelText: 'President'),
      _buildTextField(
          controller: _vicePrecidentController, labelText: 'Vice Precident'),
      _buildTextField(
          controller: _tecnicalHeadController, labelText: 'Tecnical Head'),
      _buildTextField(
          controller: _managementHeadController, labelText: 'Management Head'),
      _buildTextField(
          controller: _graphicsHeadController, labelText: 'Graphics Head'),
      _buildTextField(controller: _prHeadController, labelText: 'PR Head'),
      _buildTextField(
          controller: _totalMembersController, labelText: 'Total Members'),
    ];
  }

  Widget _buildTextField(
      {required TextEditingController controller, required String labelText}) {
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
