import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/model/blood_request.dart';
import 'package:fyp/services/authentication/auth.dart';

const String _collection = 'bloodRequests';

class RequestStore {
  final _firebase = FirebaseFirestore.instance;

  Future<void> saveToFirestore(BloodRequest request) async {
    try {
      await _firebase.collection(_collection).add(request.toJson());
    } catch (e) {
      print('error while saving request to db');
    }
  }

  Future<List<BloodRequest>> getWhere(
      {required String requester, required String status}) async {
    var request = <BloodRequest>[];
    var snap = await _firebase
        .collection(_collection)
        .where('requester', isEqualTo: requester)
        .where('status', isEqualTo: status)
        .get();
    for (var element in snap.docs) {
      request.add(BloodRequest.fromJson(element.data()));
      //print(element.data());
    }

    return request;
  }

  Future<List<BloodRequest>> getWhereDonor({required String donor}) async {
    var request = <BloodRequest>[];
    var rawdata = await _firebase
        .collection(_collection)
        .where('donor', isEqualTo: donor)
        .get();
    for (var element in rawdata.docs) {
      request.add(BloodRequest.fromJson(element.data()));
    }

    return request;
  }

  Future<int> updateStatus({required String requestCode}) async {
    int flag = 0;
    var docId = '';
    var docStatus = '';
    var requester = '';

    var snap = await _firebase
        .collection(_collection)
        .where('requestCode', isEqualTo: requestCode)
        .get();
    for (var element in snap.docs) {
      //because we require doc id to update data
      docId = element.id;
      docStatus = element.data()['status'];
      requester = element.data()['requester'];
    }

    if (docId.isNotEmpty && docStatus != 'Completed') {
      var currentUser = Auth().currentUser!.email;
      if (requester != currentUser) {
        await _firebase.collection(_collection).doc(docId).update({
          'status': 'Completed',
          'donor': currentUser,
          'completedOn': Timestamp.now()
        });
        //sucessful
        flag = 1;
      }
      //You cant use your own code
      flag=-1;
    }
    //code is wrong or already used
    return flag;
  }

  Future<Map<dynamic, int>> getCount() async {
    var totalCount = await _firebase.collection(_collection).count().get();
    var completedCount = await _firebase
        .collection(_collection)
        .where('status', isEqualTo: 'Completed')
        .count()
        .get();

    return {
      'Total': totalCount.count ?? 0,
      'Completed': completedCount.count ?? 0
    };
  }
}
