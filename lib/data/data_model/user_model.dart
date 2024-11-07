import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String? displayName;
  @HiveField(1)
  String? email;
  @HiveField(2)
  bool? emailVerified;
  @HiveField(3)
  bool? isAnonymous;
  @HiveField(4)
  String? phoneNumber;
  @HiveField(5)
  String? photoURL;
  @HiveField(6)
  String? refreshToken;
  @HiveField(7)
  String? tenantId;
  @HiveField(8)
  String? uid;
  @HiveField(9)
  String? companyType;
  @HiveField(10)
  String? companyDocumentId;
  @HiveField(11)
  String? companyName;
  @HiveField(12)
  String? userType;
  @HiveField(13)
  String? name;
  @HiveField(14)
  String? address;
  @HiveField(15)
  List? phoneNumbers;
  @HiveField(16)
  String? description;

  UserModel({
    this.displayName,
    this.email,
    this.emailVerified,
    this.isAnonymous,
    this.phoneNumber,
    this.photoURL,
    this.refreshToken,
    this.tenantId,
    this.uid,
    this.companyType,
    this.companyDocumentId,
    this.companyName,
    this.userType,
    this.name,
    this.address,
    this.phoneNumbers,
    this.description,
    });

  factory UserModel.fromJson({required Map<String, dynamic> data, required User user}) {
    try{
      return UserModel(
        displayName: user.displayName,
        email: user.email,
        emailVerified: user.emailVerified,
        isAnonymous: user.isAnonymous,
        phoneNumber: user.phoneNumber,
        photoURL: user.photoURL,
        refreshToken: user.refreshToken,
        tenantId: user.tenantId,
        uid: user.uid,
        companyType: (data["companyType"] is String) ? data["companyType"] : "",
        companyDocumentId: (data["companyDocumentId"] is String) ? data["companyDocumentId"] : "",
        companyName: (data["companyName"] is String) ? data["companyName"] : "",
        userType: (data["userType"] is String) ? data["userType"] : "",
        name: (data["name"] is String) ? data["name"] : "",
        address: (data["address"] is String )? data["address"] : "",
        phoneNumbers: (data["phoneNumbers"] is List) ? data["phoneNumbers"] : [""],
        description: (data["description"] is String )? data["description"] : ""
      );
    }catch(error){
      if (kDebugMode) {
        print(error);
      }
      throw FormatException('Invalid JSON: $data');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'companyType': companyType,
      'companyDocumentId': companyDocumentId,
      'companyName': companyName,
      'userType': userType,
      'name': name,
      'address': address,
      'phoneNumbers': phoneNumbers,
      'description': description,
     };
  }
}