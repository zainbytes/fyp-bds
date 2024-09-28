import 'package:flutter/material.dart';
import 'package:fyp/controller/signup_controller.dart';
import 'package:fyp/services/validation/validation.dart';
import 'package:fyp/view/mywidgets/homepage/customappbar.dart';
import 'package:fyp/view/mywidgets/homepage/my_textfield.dart';
import 'package:fyp/view/mywidgets/others/bottomsheet_blood.dart';
import 'package:gap/gap.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  ControllerSignUp controllerSignUp = ControllerSignUp();
  
  final _formkey = GlobalKey<FormState>();
  bool _signupClicked =false;

  @override
  void dispose() {
    controllerSignUp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Create account'),
      body: Form(
        autovalidateMode: _signupClicked?AutovalidateMode.onUserInteraction:AutovalidateMode.disabled,
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
                width: double.infinity,
              ),
              DecoratedTextField(
                  icon: Icon(Icons.account_circle),
                  label: 'Full name',
                  validator: (value) => nameValidation(value),
                  controller: controllerSignUp.fulNameController),
              const Gap(10),
              DecoratedTextField(
                  icon: Icon(Icons.email_rounded),
                  label: 'Email',
                  validator: (value) => emailValidation(value),
                  controller: controllerSignUp.emailController),
              const Gap(10),
              DecoratedTextField(
                  icon: Icon(Icons.phone_rounded),
                  label: 'Phone no e.g +92xxxx',
                  validator: (value) => phoneValidation(value),
                  controller: controllerSignUp.phoneNoController),
              const Gap(10),
          
              //show bottom sheet to get blood group from chips
              DecoratedTextField(
                ontap: () async {
                  var result= await showModalBottomSheet(context: context, builder:(context) =>const BottomSheetForBlood(),);
                  controllerSignUp.bloodGropuController.text=result??'B+';
                },
                icon: Icon(Icons.bloodtype_rounded),
                label: 'Blood Type',
                readOnly: true,
                validator: (value) => bloodGroupValidation(value),
                controller: controllerSignUp.bloodGropuController,
              ),
              const Gap(10),
              DecoratedTextField(
                  icon: Icon(Icons.description_rounded),
                  label: 'Other blood releated detail',
                  controller: controllerSignUp.bloodDescriptionContoller),
              const Gap(10),
              DecoratedTextField(
                  icon: Icon(Icons.password_rounded),
                  label: 'Password',
                  validator: (value) => passwordValidation(value),
                  obscureText: true,
                  controller: controllerSignUp.passwordController),
              const Gap(10),
          
              //signup button
              GestureDetector(
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    //create account with email & pasword
                  //store user to database
          
                  controllerSignUp.createAccount();
                  }
                  else{
                    //change Auto validation mode
                    setState(() {
                      _signupClicked=true;
                    });
                  }
                },
                child: Container(
                  width: 300,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.red, borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    'Signup',
                    style:
                        TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
