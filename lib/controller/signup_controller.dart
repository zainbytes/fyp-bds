import 'package:flutter/material.dart';
import 'package:fyp/model/appuser.dart';
import 'package:fyp/services/authentication/auth.dart';
import 'package:fyp/services/firestore/appuser_store.dart';

class ControllerSignUp {
  var fulNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNoController = TextEditingController();
  var bloodGropuController = TextEditingController();
  var bloodDescriptionContoller = TextEditingController();
  var passwordController = TextEditingController();

  createAccount() async {
    var user = AppUser(
        fullName: fulNameController.text,
        email: emailController.text,
        phoneNo: phoneNoController.text,
        bloodGroup: bloodGropuController.text,
        bloodDescription: bloodDescriptionContoller.text);
    //create account
    var result = await Auth().signUpWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    if (result) {
      //write data to firestore
      await AppUserStore().writeUserToStore(user, Auth().currentUser!.uid);
    }
  }

  dispose() {
    fulNameController.dispose();
    emailController.dispose();
    phoneNoController.dispose();
    bloodGropuController.dispose();
    bloodDescriptionContoller.dispose();
    passwordController.dispose();
  }
}
