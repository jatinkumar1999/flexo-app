import 'package:flexo_app/storage/get_storage.dart';
import 'package:flexo_app/views/auth/forgot_password_screen.dart';
import 'package:flexo_app/views/auth/providerHomePage.dart';
import 'package:flexo_app/views/auth/register_screen.dart';
import 'package:flexo_app/views/dashboard/sports.dart';
import 'package:flexo_app/views/service_provider/add_category.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../constant/color_constant.dart';
import '../../helper_widget.dart';
import '../../model/login_model.dart';
import '../../services/auth_services.dart';
import 'homePage.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email, password;
  bool clicked = true;
  bool isloading = false;
  final formkey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final FocusNode _focusNodePassword = FocusNode();
  bool _obscurePassword = true;

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
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 150),
                const SizedBox(height: 10),
                Text(
                  "Login",
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
                  onEditingComplete: () => _focusNodePassword.requestFocus(),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter email.";
                    } else if (!GetUtils.isEmail(value)) {
                      return "Please enter valid email.";
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: passwordController,
                  focusNode: _focusNodePassword,
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
                Column(
                  children: [
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
                          loginApiCall(
                              emailController.text, passwordController.text);
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForGotPassword()));
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 24),
                        alignment: Alignment.center,
                        child: Text(
                          "Forgot Password ?",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            formkey.currentState?.reset();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Register();
                                },
                              ),
                            );
                          },
                          child: const Text(
                            "Signup",
                            style: TextStyle(color: AppColor.orangeColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNodePassword.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginApiCall(String? emailText, String? passwordText) async {
    HelperWidget.showProgress(context);
    LoginModel loginModel =
        await ApiProvider().loginUser(email: emailText, password: passwordText);
    Navigator.pop(context);
    if (loginModel.success == true) {
      HelperWidget.showToast(message: loginModel.message);
      Storage().storeUserId(loginModel.user?.id ?? 0);
      Storage().storeName(loginModel.user?.name ?? '');
      Storage().storeEmail(loginModel.user?.email ?? '');
      Storage().storeMode(loginModel.user?.role ?? '');
      Storage().storeUserCategoryId(loginModel.user?.categoryId.toString() ?? '0');
      loginModel.user?.role == 'service_provider'
          ? Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (BuildContext context) {
              return ProviderHomeScreen();
            }), (r) {
              return false;
            })
          : Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (BuildContext context) {
              return Home(
              );
            }), (r) {
              return false;
            });
    } else if (loginModel.success == false) {
      HelperWidget.showToast(message: loginModel.message);

      print('signupm error messsga e==>${loginModel.message}');
    }
  }
}
