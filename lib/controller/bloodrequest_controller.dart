import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/model/blood_request.dart';
import 'package:fyp/services/authentication/auth.dart';
import 'package:fyp/services/firestore/request_store.dart';

class ControllerBloodRequest {
  var reasonController = TextEditingController();
  var bloodController = TextEditingController();
  var bloodDescriptionContoller = TextEditingController();
  var locationController = TextEditingController();
  

  saveToDatabase() async {
    

    var req = BloodRequest(
        reason: reasonController.text,
        blood: bloodController.text,
        bloodDescription: bloodDescriptionContoller.text,
        location: locationController.text,
        requester: Auth().currentUser!.email!,
        status: 'Active',
        requestCode: _generateRandomCode(),
        createdOn: Timestamp.now(),
        donor:'null');

      
    //save request to database
    await RequestStore().saveToFirestore(req);

    
  }

  String _generateRandomCode(){
      var length =8;
      const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789';
      Random rnd = Random.secure();

      return String.fromCharCodes(Iterable.generate(
    length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }
}
