import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/services/authentication/auth.dart';


const String _collection = 'contactUs';
class ContactUsStore {
  

  final _firestore = FirebaseFirestore.instance;

  Future<void> saveMessage({required String message}) async{
    var user =Auth().currentUser!.email;

    await _firestore.collection(_collection).add({
      'user':user,
      'message':message,
      'date':Timestamp.now()
    });

  }
}