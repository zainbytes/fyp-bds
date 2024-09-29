import 'package:flutter/material.dart';
import 'package:fyp/controller/login_controller.dart';
import 'package:fyp/services/validation/validation.dart';
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
      body: Form(
        autovalidateMode: _loginClicked
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          
              Text('Blood Bridge',style: GoogleFonts.outfit(textStyle: TextStyle(
                fontSize: 42,
                color: angryFlamingo,
                fontWeight: FontWeight.w700)),),
              const Gap(50),
              //image
              Image.asset('assets/images/login.jpg', width: 300),
          
              const Gap(100),
              const SizedBox(width: double.infinity),
              //email text field
          
              DecoratedTextField(
                controller: _controllerLogin.emailController,
                label: "Email",
                icon:const Icon(Icons.email_rounded),
                validator: (value) => emailValidation(value),
              ),
              const Gap(10),
              //password text field
              DecoratedTextField(
                controller: _controllerLogin.passwordController,
                label: "Password",
                icon:const Icon(Icons.password_rounded),
                obscureText: true,
                validator: (value) => passwordValidation(value),
              ),
              const Gap(10),
          
              //login button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      //signup user
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ));
                    },
                    child: const DecoratedButton(
                      label: "SignUp",
                    ),
                  ),
                  const Gap(20),
                  GestureDetector(
                    onTap: () async {
                      if (_formkey.currentState!.validate()) {
                        //login user
                        await _controllerLogin.loginUser();
                      } else {
                        changeAutoValidation();
                      }
                    },
                    child: const DecoratedButton(
                      label: "Login",
                    ),
                  ),
                ],
              ),
          
              const Gap(50),
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
        width: 120,
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(20)),
        child: Text(
          label,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ));
  }
}
