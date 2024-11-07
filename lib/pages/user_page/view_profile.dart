// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/data/data_model/profile_model.dart';

import '../../logic/locator.dart';

class ViewProfile extends StatefulWidget {
  final ProfileModel profile;

  const ViewProfile({Key? key, required this.profile}) : super(key: key);

  @override
  ViewProfileState createState() => ViewProfileState();
}

class ViewProfileState extends State<ViewProfile> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController religionController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController DOBController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _selectedGender;
  bool _showGenderError = false;

  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.profile.firstName ?? '';
    lastNameController.text = widget.profile.lastName ?? '';
    phoneNumberController.text = widget.profile.phoneNumber ?? '';
    addressController.text = widget.profile.address ?? '';
    DOBController.text = widget.profile.DOB ?? '';
    emailAddressController.text = widget.profile.emailAddress ?? '';
    ageController.text = widget.profile.age ?? '';
    nationalityController.text = widget.profile.nationality ?? '';
    religionController.text = widget.profile.religion ?? '';
    designationController.text = widget.profile.designation ?? '';
    bloodGroupController.text = widget.profile.bloodGroup ?? '';
    _selectedGender = widget.profile.gender ?? '';
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      ProfileModel updatedProfile = ProfileModel(
        documentId: widget.profile.documentId,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        emailAddress: emailAddressController.text,
        gender: _selectedGender, // Update with selected gender
        phoneNumber: phoneNumberController.text,
        address: addressController.text,
        age: ageController.text,
        nationality: nationalityController.text,
        religion: religionController.text,
        designation: designationController.text,
        bloodGroup: bloodGroupController.text,
        DOB: DOBController.text,
        lastModified: DateTime.now(),
      );

      await Locator.profileManagementService
          .updateProfile(widget.profile.documentId!, updatedProfile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
        content: SingleChildScrollView(
            child: SizedBox(
          width: 900,
          child: Column(children: <Widget>[
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text(
                'VIEW PROFILE DETAILS',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]),
            const SizedBox(height: 20),
            const Text(
              'PERSONAL INFORMATION',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                 TextFormField(
                  controller: firstNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill out this field';
                    }
                    return null;
                  },
                  
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: lastNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill out this field';
                    }
                    return null;
                  },
                  
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailAddressController,
                  validator: (value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        (!value.contains('@') || !value.contains('.'))) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: addressController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill out this field';
                    }
                    return null;
                  },
                  
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<String>(
                      value: _selectedGender,
                      decoration: InputDecoration(
                        labelText: 'Select Gender',
                        border: const OutlineInputBorder(),
                        errorText:
                            _showGenderError ? 'Please select a gender' : null,
                      ),
                      dropdownColor: Color.fromARGB(255, 141, 66, 66),
                      items: ['Male', 'Female', 'Others'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGender = newValue;
                          genderController.text = newValue ?? '';
                          _showGenderError = false;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a gender';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: phoneNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill out this field';
                    } else if (value.length != 10) {
                      return 'Please enter exactly 10 digits';
                    }
                    return null;
                  },
                 
                  keyboardType: TextInputType
                      .phone, // This sets the keyboard type to phone
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: DOBController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill out this field';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'DOB',
                    border: OutlineInputBorder(),
                  ),
                ),
                                const SizedBox(height: 20),
                TextFormField(
                  controller: religionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill out this field';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Religion',
                    border: OutlineInputBorder(),
                  ),
                ),
                                const SizedBox(height: 20),
                TextFormField(
                  controller: ageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill out this field';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                  ),
                ),
                                const SizedBox(height: 20),
                TextFormField(
                  controller: nationalityController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill out this field';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Nationality',
                    border: OutlineInputBorder(),
                  ),
                ),
                                const SizedBox(height: 20),
                TextFormField(
                  controller: bloodGroupController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill out this field';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Blood Group',
                    border: OutlineInputBorder(),
                  ),
                ),
                 const SizedBox(height: 20),
                 TextFormField(
                  controller: designationController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill out this field';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Designation',
                    border: OutlineInputBorder(),
                  ),
                ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          bool? confirmDelete = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Delete Customer'),
                                content: const Text(
                                    'Are you sure you want to delete this customer? This action cannot be undone.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(false); // Cancel deletion
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(true); // Confirm deletion
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );

                          if (confirmDelete == true) {
                            Locator.profileManagementService
                                .deleteProfile(widget.profile);
                            // TrashModel trashModel = TrashModel(
                            //     deletedDocumentID: widget.user.documentId);
                            // Locator.trashManagemenrService
                            //     .createTrash(trashModel);
                            print('profile deleted');

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Deleted Successfully'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                            Navigator.of(context).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(
                              255, 141, 66, 66), // Red color for delete button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Delete',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 255, 254, 253))),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _submitForm();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Updated Successfully'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                            Navigator.of(context).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 141, 66, 66),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Update',
                            style: const TextStyle(color: Color(0xFFF4BF58))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ]),
        )));
  }
}
