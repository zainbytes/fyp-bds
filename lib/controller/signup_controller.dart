import 'package:flutter/material.dart';
import 'package:fyp/model/appuser.dart';
import 'package:fyp/services/authentication/auth.dart';
import 'package:fyp/services/firestore/appuser_store.dart';

class ControllerSignUp {
  var fulNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNoController = TextEditingController();
  var bloodGropuController = TextEditingController();
  var locationContoller = TextEditingController();
  var passwordController = TextEditingController();

  Future createAccount() async {
    var user = AppUser(
        fullName: fulNameController.text,
        email: emailController.text,
        phoneNo: phoneNoController.text,
        bloodGroup: bloodGropuController.text,
        location: locationContoller.text);
    //create account
    var result = await Auth().signUpWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    if (result.user!=null) {
      //write data to firestore
      await AppUserStore().writeUserToStore(user, Auth().currentUser!.uid);
    }
    return result;
  }

  dispose() {
    fulNameController.dispose();
    emailController.dispose();
    phoneNoController.dispose();
    bloodGropuController.dispose();
    locationContoller.dispose();
    passwordController.dispose();
  }
}
