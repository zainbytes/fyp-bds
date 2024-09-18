import 'package:flutter/material.dart';
import 'package:fyp/model/appuser.dart';
import 'package:fyp/model/blood_request.dart';
import 'package:fyp/services/authentication/auth.dart';
import 'package:fyp/services/firestore/appuser_store.dart';
import 'package:fyp/services/firestore/request_store.dart';

class ProfileController {


  //used for update profile
  var nameEditor =TextEditingController();
  var phoneEditor =TextEditingController();
  var bloodEditor =TextEditingController();
  var descriptionEditor =TextEditingController();

  Future<AppUser> getCurrentUser() async {
    var id = Auth().currentUser!.uid;

    var user = await AppUserStore().readUserFromStore(id);

    return user!;
  }

  Future<List<BloodRequest>> getDonationRecord() async {
    var email = Auth().currentUser!.email;

    var request = await RequestStore().getWhereDonor(donor: email!);

    return request;
  }

  Future<void> updateProfile() async{
    var id = Auth().currentUser!.uid;
    var data ={
      "name":nameEditor.text,
      "phone":phoneEditor.text,
      "blood":bloodEditor.text,
      "description":descriptionEditor.text,
    };

    await AppUserStore().updateUser(id,data);

  }


}
