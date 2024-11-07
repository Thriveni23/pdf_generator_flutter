import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'profile_model.g.dart';

@HiveType(typeId: 1)
class ProfileModel {
  @HiveField(0)
  String? documentId;

  @HiveField(1)
  String? firstName;

  @HiveField(2)
  String? lastName;

  @HiveField(3)
  String? emailAddress;

  @HiveField(4)
  String? phoneNumber;

  @HiveField(5)
  String? address;

  @HiveField(6)
  String? gender;

  @HiveField(7)
  DateTime? lastModified;

  @HiveField(8)
  String? DOB;

  @HiveField(9)
  String? bloodGroup;

  @HiveField(10)
  String?  nationality;


  @HiveField(11)
  String? religion;

  @HiveField(12)
  String? age;

  @HiveField(13)
  String? designation;

  ProfileModel({
    this.documentId,
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.phoneNumber,
    this.address,
    this.gender,
    this.DOB,
    this.bloodGroup,
    this.nationality,
    this.religion,
    this.age,
    this.designation,
    this.lastModified,

  });

  factory ProfileModel.fromJson(
      {required Map<String, dynamic> json, required String documentId}) {
    return ProfileModel(
     documentId:documentId,
      firstName: (json['firstName'] is String) ? json['firstName'] : '',
      lastName: (json['lastName'] is String) ? json['lastName'] : '',
       DOB: (json['DOB'] is String) ? json['DOB'] : '',
      emailAddress:
          (json['emailAddress'] is String) ? json['emailAddress'] : '',
      bloodGroup: (json['bloodGroup'] is String) ? json['bloodGroup'] : '',
      phoneNumber: (json['phoneNumber'] is String) ? json['phoneNumber'] : '',
      address: (json['address'] is String) ? json['address'] : '',
      gender: (json['gender'] is String) ? json['gender'] : '',
      nationality: (json['nationality'] is String) ? json['nationality'] : '',
      age: (json['age'] is String) ? json['age'] : '',
      religion: (json['religion'] is String) ? json['religion'] : '',
      designation:(json['designation'] is String) ? json['designation'] : '',
      lastModified: (json['lastModified'] is Timestamp)
          ? json['lastModified'].toDate()
          : DateTime.now(),
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'documentId': documentId,
      'firstName': firstName,
      'lastName':lastName,
      'DOB':DOB,
      'emailAddress': emailAddress,
      'designation':designation,
      'bloodGroup':bloodGroup,
      'nationality':nationality,
      'religion':religion,
      'age':age,
      'phoneNumber': phoneNumber,
      'address': address,
      'gender': gender,
      'lastModified':
          lastModified != null ? Timestamp.fromDate(lastModified!) : null,
      };
  }

 

 
}
