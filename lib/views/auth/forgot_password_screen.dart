import 'package:flexo_app/views/auth/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/color_constant.dart';
import '../../helper_widget.dart';
import '../../model/register_model.dart';
import '../../services/auth_services.dart';

class ForGotPassword extends StatefulWidget {
  ForGotPassword({Key? key}) : super(key: key);

  @override
  _ForGotPasswordState createState() => _ForGotPasswordState();
}

class _ForGotPasswordState extends State<ForGotPassword> {
  final formkey = GlobalKey<FormState>();
  String? email;
  TextEditingController emailController = TextEditingController();

  forgotPassword() async {
    if (formkey.currentState!.validate()) {
      forgotApiCall(emailController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/download.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 150),
                const SizedBox(height: 10),
                Text(
                  "Forgot Password",
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
                    if (formkey.currentState?.validate() ?? false) {
                      forgotApiCall(
                          emailController.text,);
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
    )         ;
  }

  void forgotApiCall(String? emailText) async {
    HelperWidget.showProgress(context);

    RegisterModel registerModel = await ApiProvider().forgotPassword(user: emailText);
    Navigator.pop(context);

    if (registerModel.success == true) {

      HelperWidget.showToast(message: registerModel.message);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ResetPassword(email: emailText.toString(),)));
    } else if (registerModel.success == false) {
      HelperWidget.showToast(message: registerModel.message);

      print('signupm error messsga e==>${registerModel.message}');
    }
  }
}
