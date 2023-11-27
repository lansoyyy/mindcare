import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medzone/screens/admin_screens/home_screen.dart';
import 'package:medzone/screens/home_screen.dart';
import 'package:medzone/utils/colors.dart';
import 'package:medzone/widgets/button_widget.dart';
import 'package:medzone/widgets/text_widget.dart';
import 'package:medzone/widgets/textfield_widget.dart';
import 'package:medzone/widgets/toast_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
                TextWidget(
                  text: 'MindCare',
                  fontSize: 45,
                  fontFamily: 'Bold',
                ),
                const SizedBox(
                  height: 20,
                ),
                TextWidget(
                  text: 'Welcome',
                  fontSize: 32,
                  fontFamily: 'Bold',
                ),
                TextWidget(
                  text: 'Select your preferred login method',
                  fontSize: 14,
                  fontFamily: 'Regular',
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
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      // showDialog(
                      //   context: context,
                      //   builder: ((context) {
                      //     final formKey = GlobalKey<FormState>();
                      //     final TextEditingController emailController =
                      //         TextEditingController();

                      //     return AlertDialog(
                      //       title: TextWidget(
                      //         text: 'Forgot Password',
                      //         fontSize: 14,
                      //         color: Colors.black,
                      //       ),
                      //       content: Form(
                      //         key: formKey,
                      //         child: Column(
                      //           mainAxisSize: MainAxisSize.min,
                      //           children: [
                      //             TextFieldWidget(
                      //               hint: 'Email',
                      //               textCapitalization: TextCapitalization.none,
                      //               inputType: TextInputType.emailAddress,
                      //               label: 'Email',
                      //               controller: emailController,
                      //               validator: (value) {
                      //                 if (value == null || value.isEmpty) {
                      //                   return 'Please enter an email address';
                      //                 }
                      //                 final emailRegex = RegExp(
                      //                     r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      //                 if (!emailRegex.hasMatch(value)) {
                      //                   return 'Please enter a valid email address';
                      //                 }
                      //                 return null;
                      //               },
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       actions: [
                      //         TextButton(
                      //           onPressed: (() {
                      //             Navigator.pop(context);
                      //           }),
                      //           child: TextWidget(
                      //             text: 'Cancel',
                      //             fontSize: 12,
                      //             color: Colors.black,
                      //           ),
                      //         ),
                      //         TextButton(
                      //           onPressed: (() async {
                      //             // if (formKey.currentState!.validate()) {
                      //             //   try {
                      //             //     Navigator.pop(context);
                      //             //     await FirebaseAuth.instance
                      //             //         .sendPasswordResetEmail(
                      //             //             email: emailController.text);
                      //             //     showToast(
                      //             //         'Password reset link sent to ${emailController.text}');
                      //             //   } catch (e) {
                      //             //     String errorMessage = '';

                      //             //     if (e is FirebaseException) {
                      //             //       switch (e.code) {
                      //             //         case 'invalid-email':
                      //             //           errorMessage =
                      //             //               'The email address is invalid.';
                      //             //           break;
                      //             //         case 'user-not-found':
                      //             //           errorMessage =
                      //             //               'The user associated with the email address is not found.';
                      //             //           break;
                      //             //         default:
                      //             //           errorMessage =
                      //             //               'An error occurred while resetting the password.';
                      //             //       }
                      //             //     } else {
                      //             //       errorMessage =
                      //             //           'An error occurred while resetting the password.';
                      //             //     }

                      //             //     showToast(errorMessage);
                      //             //     Navigator.pop(context);
                      //             //   }
                      //             // }
                      //           }),
                      //           child: TextWidget(
                      //             text: 'Continue',
                      //             fontSize: 14,
                      //             color: Colors.black,
                      //           ),
                      //         ),
                      //       ],
                      //     );
                      //   }),
                      // );
                    },
                    child: TextWidget(
                      text: 'Forgot Password?',
                      fontSize: 12,
                      color: primary,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/amico3.png',
                    width: 200,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: ButtonWidget(
                    label: 'Sign In',
                    onPressed: () {
                      if (emailController.text == 'admin@mindcare.com' &&
                          passwordController.text == 'admin123') {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const AdminHomeScreen()));
                      } else {
                        login(context);
                      }
                    },
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     TextWidget(
                //       text: "Don't have an account?",
                //       fontSize: 12,
                //       fontFamily: 'Regular',
                //       color: Colors.black,
                //     ),
                //     TextButton(
                //       onPressed: () {
                //         Navigator.of(context).push(MaterialPageRoute(
                //             builder: (context) => const SignupScreen()));
                //       },
                //       child: TextWidget(
                //         text: 'Signup here',
                //         fontSize: 14,
                //         fontFamily: 'Medium',
                //         color: primary,
                //       ),
                //     ),
                //   ],
                // ),
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


   login(context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      showToast('Logged in succesfully!');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast("No user found with that email.");
      } else if (e.code == 'wrong-password') {
        showToast("Wrong password provided for that user.");
      } else if (e.code == 'invalid-email') {
        showToast("Invalid email provided.");
      } else if (e.code == 'user-disabled') {
        showToast("User account has been disabled.");
      } else {
        showToast("An error occurred: ${e.message}");
      }
    } on Exception catch (e) {
      showToast("An error occurred: $e");
    }
}
}
