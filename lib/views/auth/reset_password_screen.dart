import 'package:flexo_app/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../constant/color_constant.dart';
import '../../helper_widget.dart';
import '../../model/register_model.dart';
import '../../services/auth_services.dart';

class ResetPassword extends StatefulWidget {
  final String email;
  ResetPassword({Key? key,required this.email}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formkey = GlobalKey<FormState>();
  String? email, otp, password;
  TextEditingController otpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  bool _obscurePassword = true;

@override
  void initState() {
  emailController.text =widget.email;
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/download.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Form(
              key:formkey ,
              child: Column(
                children: [
                  const SizedBox(height: 150),
                  const SizedBox(height: 10),
                  Text(
                    "Reset Password",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 60),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: AppColor.orangeColor,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(fontSize: 14),
                      contentPadding: EdgeInsets.zero,
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.orangeColor),
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter email.";
                      } else if (!GetUtils.isEmail(value)) {
                        return "Please enter valid email.";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    cursorColor: AppColor.orangeColor,
                    decoration: InputDecoration(
                      hintText: "Otp",
                      hintStyle: TextStyle(fontSize: 14),
                      contentPadding: EdgeInsets.zero,
                      prefixIcon: const Icon(
                        Icons.description,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.orangeColor),
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    validator: (value) => value!.length < 4
                        ? "enter a 4 chars otp"
                        : null,
                  ),
                  const SizedBox(height: 18),

                  TextFormField(
                    controller: newPasswordController,

                    obscureText: _obscurePassword,
                    keyboardType: TextInputType.visiblePassword,
                    cursorColor: AppColor.orangeColor,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintText: "Password",
                      hintStyle: TextStyle(fontSize: 14),
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Colors.black,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          icon: _obscurePassword
                              ? const Icon(Icons.visibility_outlined)
                              : const Icon(Icons.visibility_off_outlined)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.orangeColor),
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password.";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      backgroundColor: AppColor.orangeColor,
                      foregroundColor: AppColor.orangeColor,
                    ),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        resetPasswordApiCall(otpController.text.trim(),
                            emailController.text.trim(), newPasswordController.text.trim());
                      }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void resetPasswordApiCall(
      String? otpText, String? emailText, String? newPassword) async {
    HelperWidget.showProgress(context);

    RegisterModel registerModel = await ApiProvider()
        .resetPassword(otp: otpText, email: emailText, password: newPassword);
    Navigator.pop(context);

    if (registerModel.message == 'Password reset successful') {
      HelperWidget.showToast(message: registerModel.message);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (BuildContext context) {
            return Login();
          }), (r) {
            return false;
          });
    } else  {
      HelperWidget.showToast(message: registerModel.message);

      print('signupm error messsga e==>${registerModel.message}');
    }
  }
}
