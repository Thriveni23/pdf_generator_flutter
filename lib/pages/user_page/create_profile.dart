// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_app/data/data_model/profile_model.dart';

import '../../../logic/locator.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
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

  bool isNotNumeric(String? value) {
    if (value == null) {
      return true;
    }
    try {
      double.parse(value);
      return false; // It's a valid number
    } catch (e) {
      return true; // It's not a valid number
    }
  }

  void addUser() {
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final emailAddress = emailAddressController.text;
    final phoneNumber = phoneNumberController.text;
    final address = addressController.text;
    final gender = genderController.text;
    final DOB = DOBController.text;
    final religion = religionController.text;
    final nationality = nationalityController.text;
    final bloodGroup = bloodGroupController.text;
    final age = ageController.text;
    final designation = designationController.text;

    ProfileModel user = ProfileModel(
      documentId: '',
      firstName: firstName,
      lastName:lastName,
      emailAddress: emailAddress,
      phoneNumber: phoneNumber,
      address: address,
      gender: gender,
      DOB: DOB,
      religion:religion,
      nationality:nationality,
      bloodGroup:bloodGroup,
      age:age,
      designation:designation,
      lastModified: DateTime.now(),
    );

    Locator.profileManagementService.createProfile(user);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
        content: SingleChildScrollView(
            child: Column(children: <Widget>[
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              'PERSONAL INFORMATION',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ]),
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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                  ],
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
                ),const SizedBox(height: 20),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          addUser();
                          Navigator.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text(
                        'ADD',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 141, 66, 66),
                        ),
                      ), // This is the child of the ElevatedButton
                    )),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ])));
  }
}
