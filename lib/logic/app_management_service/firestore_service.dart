import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  CollectionReference profileColRef =
      FirebaseFirestore.instance.collection('profiles');


  init() async {}

  setupRef(){
    
  }
}
