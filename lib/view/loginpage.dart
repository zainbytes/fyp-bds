import 'package:flutter/material.dart';
import 'package:fyp/controller/login_controller.dart';
import 'package:fyp/view/signuppage.dart';
import 'package:gap/gap.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controllerLogin = ControllerLogin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          //email text field

          Container(
            width: 300,
            padding: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16)),
            child: TextField(
              controller: _controllerLogin.emailController,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: 'Email'),
            ),
          ),
          const Gap(10),
          //password text field
          Container(
            width: 300,
            padding: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16)),
            child: TextField(
              controller: _controllerLogin.passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: 'Password'),
            ),
          ),
          const Gap(10),

          //login button
          GestureDetector(
            onTap: () async {
              //login user
              await _controllerLogin.loginUser();
            },
            child: Container(
                width: 300,
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)),
                child: const Text('Login')),
          ),
          const Gap(10),

          //move to signup page
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SignUpPage(),
              ));
            },
            child: const Text(
              'Not member yet?',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          const Gap(100),
        ],
      ),
    );
  }
}
