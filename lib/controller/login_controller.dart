import 'package:flutter/material.dart';
import 'package:fyp/services/authentication/auth.dart';

class ControllerLogin {
  var emailController =TextEditingController();
  var passwordController=TextEditingController();

  loginUser() {
    return Auth().logInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
  }
}