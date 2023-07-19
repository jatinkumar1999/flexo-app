import 'package:flexo_app/storage/get_storage.dart';
import 'package:flexo_app/views/auth/login_screen.dart';
import 'package:flexo_app/views/auth/verification.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../constant/color_constant.dart';
import '../../helper_widget.dart';
import '../../model/register_model.dart';
import '../../model/sports_model.dart';
import '../../services/auth_services.dart';
import '../dashboard/sports.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool clicked = true;
  bool isloading = false;
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeConfirmPassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConFirmPassword =
      TextEditingController();
  RegisterModel? _registerModel;
  String userRole = '';
  String? _dropDownValue;
  bool _obscurePassword = true;
  String? selectedCategoryId;
  List<Categories>? categories = [];

  CategoryList? sportsCategoriesModel;

  @override
  void initState() {
    getSelectedRole();
    sportsList().then((value) async {
      if (value != null) {
        categories = value.categories;
        if (mounted) setState(() {});
        print('categories Length=============>${categories!.length}');
      }
    });
    super.initState();
  }

  getSelectedRole() async {
    userRole = Storage().getStoreStoreMode().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 100),
                Text("Sign Up",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
                const SizedBox(height: 10),
                Text(
                  "Create your account",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 35),
                TextFormField(
                  controller: _controllerUsername,
                  keyboardType: TextInputType.name,
                  cursorColor: AppColor.orangeColor,
                  decoration: InputDecoration(
                    hintText: "Username",
                    hintStyle: TextStyle(fontSize: 14),
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: const Icon(
                      Icons.person_outline,
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
                      return "Please enter username.";
                    }

                    return null;
                  },
                  onEditingComplete: () => _focusNodeEmail.requestFocus(),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _controllerEmail,
                  focusNode: _focusNodeEmail,
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
                    } else if (!(value.contains('@') && value.contains('.'))) {
                      return "Please enter valid email";
                    }
                    return null;
                  },
                  onEditingComplete: () => _focusNodePassword.requestFocus(),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _controllerPassword,
                  obscureText: _obscurePassword,
                  focusNode: _focusNodePassword,
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: AppColor.orangeColor,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(fontSize: 14),
                    contentPadding: EdgeInsets.zero,
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
                    } else if (value.length < 8) {
                      return "Password must be at least 8 character.";
                    }
                    return null;
                  },
                  onEditingComplete: () =>
                      _focusNodeConfirmPassword.requestFocus(),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _controllerConFirmPassword,
                  obscureText: _obscurePassword,
                  focusNode: _focusNodeConfirmPassword,
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: AppColor.orangeColor,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(fontSize: 14),
                    contentPadding: EdgeInsets.zero,
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
                    } else if (value != _controllerPassword.text) {
                      return "Password doesn't match.";
                    }
                    return null;
                  },
                ),
                userRole == 'Fitness Studio/service provider'
                    ? const SizedBox(height: 16)
                    : Container(),
                userRole == 'Fitness Studio/service provider'
                    ? DropdownButtonFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: const Icon(
                            Icons.category,
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
                        validator: (value) {
                          if (value == null) {
                            return 'Please select category';
                          }
                        },
                        hint: _dropDownValue == null
                            ? const Text('Select Category')
                            : Text(
                                _dropDownValue!,
                                style: const TextStyle(color: Colors.black),
                              ),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: const TextStyle(color: Colors.black),
                        items: categories?.map<DropdownMenuItem<Categories>>(
                            (Categories value) {
                          return DropdownMenuItem<Categories>(
                            value: value,
                            child: Text(value.category.toString()),
                          );
                        }).toList(),
                        onChanged: (Categories? value) {
                          setState(
                            () {
                              _dropDownValue = value?.category.toString();
                              selectedCategoryId = value?.id.toString();
                              Storage().storeUserCategoryId(selectedCategoryId.toString());
                            },
                          );
                        },
                      )
                    : Container(),
                const SizedBox(height: 20),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: AppColor.orangeColor,
                        foregroundColor: AppColor.orangeColor,
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          registerApiCall();

                          _formKey.currentState?.reset();

                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "Login",
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
    ;
  }

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeConfirmPassword.dispose();
    _controllerUsername.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerConFirmPassword.dispose();
    super.dispose();
  }

  void registerApiCall() async {
    HelperWidget.showProgress(context);
    if (Storage().getStoreStoreMode() == 'Customer') {
      _registerModel = await ApiProvider().signUp(
          name: _controllerUsername.text.trim(),
          email: _controllerEmail.text.trim(),
          password: _controllerPassword.text.trim(),
          role:"customer");
    } else {
      _registerModel = await ApiProvider().signUp(
          name: _controllerUsername.text.trim(),
          email: _controllerEmail.text.trim(),
          password: _controllerPassword.text.trim(),
          role: 'service_provider',
          categoryId: selectedCategoryId);
    }

    Navigator.pop(context);


    if (_registerModel!.success == true) {
      HelperWidget.showToast(message: _registerModel!.message);
      Storage().storeUserId(int.parse(_registerModel!.userId.toString()));
      Storage().storeEmail(_registerModel!.userEmail.toString());
      Storage().storeName(_registerModel!.userName.toString());
      Storage().storeMode(_registerModel!.userRole ?? '');
      Storage().storeUserCategoryId(_registerModel!.categoryId ?? '');

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => VerificationScreen(
                  email: _registerModel!.userEmail.toString())));
    } else if (_registerModel!.success == false) {
      HelperWidget.showToast(message: _registerModel!.message);

      print('signupm error messsga e==>${_registerModel!.message}');
    }
  }

  Future<CategoryList> sportsList() async {
    // HelperWidget.showProgress(context);
    sportsCategoriesModel = await ApiProvider().getSportsList();
    // Navigator.pop(context);
    if (sportsCategoriesModel?.status == true) {
      HelperWidget.showToast(message: sportsCategoriesModel?.message);
      setState(() {});
    } else if (sportsCategoriesModel?.status == false) {
      // HelperWidget.showToast(message: blockUserModel?.message);
    }

    return sportsCategoriesModel!;
  }
}
