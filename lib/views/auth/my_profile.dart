import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexo_app/appbar.dart';
import 'package:flexo_app/helper_widget.dart';
import 'package:flexo_app/model/profile_model.dart';
import 'package:flexo_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../constant/color_constant.dart';

import '../../constant/math_utils.dart';
import '../../model/common_response_model.dart';
import '../../model/service_model.dart';
import '../../storage/get_storage.dart';
import '../../widget/spacing.dart';
import '../auth/login_screen.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  ProfileModel? profileModel;
  var image, email, balance, name;
  File? imgFile;
  String profilePath = '';
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerWallet = TextEditingController();
  CommonResponseModel? commonResponseModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getProfile().then((value) {
        _controllerEmail.text = value.user!.email ?? '';
        _controllerUsername.text = value.user!.name ?? '';
        profilePath = value.user!.image ?? '';
        _controllerWallet.text = value.user!.totalBalance ?? '00';
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.colorWhite,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColor.colorWhite,
            title: Text(
              "Account",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize: getFontSize(
                  24.008163452148438,
                ),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 1.00,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            centerTitle: true,
            automaticallyImplyLeading: true,
          ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24.0,
            ),
            Stack(
              children: [
                imgFile == null
                    ? Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: CachedNetworkImage(
                            imageUrl: profilePath,
                            fit: BoxFit.cover,
                            height: Get.height * .165,
                            width: Get.height * .165,
                            placeholder: (context, url) => Image.asset(
                              'assets/placeHolderIg.png',
                              fit: BoxFit.cover,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/placeHolderIg.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Container(
                            padding: EdgeInsets.all(5),
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage: FileImage(
                                File(imgFile?.path ?? ""),
                              ),
                            )),
                      )
              ],
            ),
            SizedBox(
              height: 18.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: _controllerUsername,
                keyboardType: TextInputType.name,
                cursorColor: AppColor.orangeColor,
                decoration: InputDecoration(
                  hintText: "Username",
                  hintStyle: TextStyle(fontSize: 14),
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Colors.grey,
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
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: _controllerEmail,
                keyboardType: TextInputType.name,
                cursorColor: AppColor.orangeColor,
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(fontSize: 14),
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.grey,
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
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  backgroundColor: AppColor.orangeColor,
                  foregroundColor: AppColor.orangeColor,
                ),
                onPressed: () {
                  updateProfile(_controllerUsername.text, _controllerEmail.text,
                      imgFile!);
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              )),
            ),
          ],
        ),
      ),
    ));
  }

  Future<ProfileModel> getProfile() async {
    String userId = await Storage().getStoreUserId().toString();
    HelperWidget.showProgress(context);
    profileModel = await ApiProvider().getUserProfile(userId);
    Navigator.pop(context);
    if (profileModel?.status == true) {
      HelperWidget.showToast(message: profileModel?.message);
      setState(() {});
    } else if (profileModel?.status == false) {
      HelperWidget.showToast(message: profileModel?.message);
    }

    return profileModel!;
  }

  Future<CommonResponseModel> updateProfile(
      String name, String email, File image) async {
    var userId = await Storage().getStoreUserId().toString();

    HelperWidget.showProgress(context);
    commonResponseModel = await ApiProvider().updateProfile(
        userId: userId, name: name, email: email, filepath: image);
    Navigator.pop(context);
    if (commonResponseModel?.status == true) {
      HelperWidget.showToast(message: profileModel?.message);
      getProfile();
      setState(() {});
    } else if (commonResponseModel?.status == false) {
      HelperWidget.showToast(message: profileModel?.message);
    }

    return commonResponseModel!;
  }
}
