import 'package:flutter/material.dart';
import 'package:medzone/screens/admin_screens/auth/signup_screen2.dart';
import 'package:medzone/screens/auth/signup_screen2.dart';
import 'package:medzone/widgets/button_widget.dart';
import 'package:medzone/widgets/text_widget.dart';
import 'package:medzone/widgets/textfield_widget.dart';
import 'package:medzone/widgets/toast_widget.dart';

class AdminSignupScreen extends StatefulWidget {
  const AdminSignupScreen({super.key});

  @override
  State<AdminSignupScreen> createState() => _AdminSignupScreenState();
}

class _AdminSignupScreenState extends State<AdminSignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                    TextWidget(
                      text: 'Create Account',
                      fontSize: 16,
                      fontFamily: 'Bold',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/brand.png',
                    width: 100,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/amico2.png',
                    width: 175,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: TextFieldWidget(
                    prefixIcon: Icons.email,
                    label: 'Email',
                    hintColor: Colors.black,
                    controller: emailController,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: TextFieldWidget(
                    isObscure: true,
                    showEye: true,
                    prefixIcon: Icons.lock,
                    label: 'Password',
                    hintColor: Colors.black,
                    controller: passwordController,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: TextFieldWidget(
                    isObscure: true,
                    showEye: true,
                    prefixIcon: Icons.lock,
                    label: 'Confirm Password',
                    hintColor: Colors.black,
                    controller: confirmpasswordController,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ButtonWidget(
                    label: 'Next',
                    onPressed: () {
                     if(passwordController.text != confirmpasswordController.text) {
                      showToast('Password do not match!');
                     } else {
                       Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AdminSignupScreen2(emaill: emailController.text, password: passwordController.text)));
                     }
                    },
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
