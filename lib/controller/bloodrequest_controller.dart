import 'package:flutter/material.dart';
import 'package:fyp/model/blood_request.dart';
import 'package:fyp/services/authentication/auth.dart';
import 'package:fyp/services/firestore/appuser_store.dart';
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
        requester: Auth().currentUser!.email!);

        //print(Auth().currentUser);

    await RequestStore().saveToFirestore(req);
    await AppUserStore().fetchUserWhere(bloodGroup:bloodController.text);
  }
}
