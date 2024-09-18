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

  Future<List<BloodRequest>> getWhere({required String requester,required String status}) async {
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

  Future<bool> updateStatus({required String requestCode}) async {
    var flag = false;
    var docId = '';
    var docStatus = '';

    var snap = await _firebase
        .collection(_collection)
        .where('requestCode', isEqualTo: requestCode)
        .get();
    for (var element in snap.docs) {
      //because we require doc id to update data
      docId = element.id;
      docStatus = element.data()['status'];
    }

    if (docId.isNotEmpty && docStatus != 'Completed') {
      var currentUser = Auth().currentUser!.email;
      await _firebase
          .collection(_collection)
          .doc(docId)
          .update({'status': 'Completed', 'donor': currentUser});
      flag = true;
    }
    return flag;
  }
}
