import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fyp/controller/login_controller.dart';
import 'package:fyp/services/validation/validation.dart';
import 'package:fyp/view/forgotpassword.dart';
import 'package:fyp/view/mycolors.dart';
import 'package:fyp/view/mywidgets/homepage/my_textfield.dart';
import 'package:fyp/view/signuppage.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controllerLogin = ControllerLogin();
  final _formkey = GlobalKey<FormState>();
  bool _loginClicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        autovalidateMode: _loginClicked
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.end,
            
            children: [
              const SizedBox(width: double.infinity,height: 50,),
              //title
              Text(
                'Blood Bridge',
                style: GoogleFonts.outfit(
                    textStyle: TextStyle(
                        fontSize: 42,
                        color: angryFlamingo,
                        fontWeight: FontWeight.w700)),
              ),
              const Gap(50),
              //image
              Image.asset('assets/images/login.jpg', width: 300),
          
              const Gap(100),
              
              //email text field
          
              DecoratedTextField(
                controller: _controllerLogin.emailController,
                label: "Email",
                icon: const Icon(Icons.email_rounded),
                validator: (value) => emailValidation(value),
              ),
              const Gap(10),
              //password text field
              DecoratedTextField(
                controller: _controllerLogin.passwordController,
                label: "Password",
                icon: const Icon(Icons.password_rounded),
                obscureText: true,
                validator: (value) => passwordValidation(value),
              ),
          
              const Gap(1),
          
              //forget pasword
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgetPasswordPage()));
                  },
                  child: Container(
                      padding: EdgeInsets.only(right: 5),
                      alignment: Alignment.centerRight,
                      width: 300,
                      child: Text('Forgot password?',
                          style: TextStyle(
                              color: Colors.red,
                              fontStyle: FontStyle.italic)))),
              const Gap(10),
          
              //login user
          
              GestureDetector(
                onTap: () async {
                  if (_formkey.currentState!.validate()) {
                    try {
                      await _controllerLogin.loginUser();
                    } catch (e) {
                      return showDialog(context: context, builder:(context) {
                        return AlertDialog(
                          title: Center(child: Text("Login error")),
                          content: Text("Incorrect email or password"),
                        );
                      },);
                    }
                    
                  } else {
                    changeAutoValidation();
                  }
                },
                child: const DecoratedButton(
                  label: "Login",
                ),
              ),
              const Gap(5),
          
              //navigate to signup page
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ));
                  },
                  child: Text(
                    "Create new account",
                    style: TextStyle(
                        color: Colors.red, fontStyle: FontStyle.italic),
                  )),
          
              const Gap(30),
            ],
          ),
        ),
      ),
    );
  }

  void changeAutoValidation() {
    return setState(() {
      _loginClicked = true;
    });
  }
}

class DecoratedButton extends StatelessWidget {
  final String label;
  const DecoratedButton({
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(16)),
        child: Text(
          label,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ));
  }
}
