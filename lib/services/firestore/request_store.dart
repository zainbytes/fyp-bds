
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/model/blood_request.dart';

const String _collection = 'bloodRequests';
class RequestStore {
   
final _firebase =FirebaseFirestore.instance;

Future<void> saveToFirestore(BloodRequest request) async{
  try {
    await _firebase.collection(_collection).add(request.toJson());
  } catch (e) {
    print('error while saving request to db');
  }

}

}