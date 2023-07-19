import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexo_app/appbar.dart';
import 'package:flexo_app/helper_widget.dart';
import 'package:flexo_app/model/profile_model.dart';
import 'package:flexo_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../app_drawer.dart';
import '../../constant/color_constant.dart';

import '../../model/common_response_model.dart';
import '../../model/service_model.dart';
import '../../storage/get_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileModel? profileModel;
  var image, email, balance, name;
  File? imgFile;
  String profilePath = '';
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerWallet = TextEditingController();
  CommonResponseModel? commonResponseModel;
  ServiceModel? serviceModel;
  String? _dropDownValue;
  List<ServiceItem>? serviceItem =[];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getProfile().then((value) {
        _controllerEmail.text = value.user!.email ?? '';
        _controllerUsername.text = value.user!.name ?? '';
        profilePath = value.user!.image ?? '';
        _controllerWallet.text = value.user!.totalBalance ?? '00';
      });
      String userId = await Storage().getStoreUserId().toString();
      String catId = await Storage().getUserCategoryId().toString();
      serviceList(userId, catId).then((value) {
        serviceItem = value.services;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.orangeColor,
            title: Text(
              'My Profile',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  _showImagePickerDialog(context, 'Choose from');
                },
                icon: Icon(
                  Icons.edit,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          drawer: myDrawer(context),
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
                          placeholder: (context, url) =>
                              Image.asset(
                                'assets/placeHolderIg.png',
                                fit: BoxFit.cover,
                              ),
                          errorWidget: (context, url, error) =>
                              Image.asset(
                                'assets/placeHolderIg.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                        ) : Center(
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
                Storage().getStoreStoreMode() == 'service_provider' ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    readOnly: true,
                    controller: _controllerWallet,
                    keyboardType: TextInputType.name,
                    cursorColor: AppColor.orangeColor,
                    decoration: InputDecoration(
                      hintText: "Total Balance",
                      hintStyle: TextStyle(fontSize: 14),
                      contentPadding: EdgeInsets.zero,
                      prefixIcon: const Icon(
                        Icons.wallet,
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
                ) : Container(),
                Storage().getStoreStoreMode() == 'service_provider'
                    ? SizedBox(
                  height: 18.0,
                )
                    : Container(),
                Storage().getStoreStoreMode() == 'service_provider'
                    ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Your Categories', style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black),),
                    ) : Container(),

                Storage().getStoreStoreMode() == 'service_provider'?  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(height: Get.height * 0.2, child: serviceItems(),),
                ):Container(),


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
                          updateProfile(
                              _controllerUsername.text, _controllerEmail.text,
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

  Widget serviceItems() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: serviceItem?.length,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return serviceItem?.length == 0
              ? Center(
            child: Text(
              'No record found',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black),
            ),
          )
              : items(serviceItem![index]);
        });
  }



  Widget items(ServiceItem serviceItem) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(serviceItem.serviceTitle.toString()),
          Text('${'₹'}${serviceItem.price.toString()}'  ),
        ],
      ),
    );
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

  Future<ServiceModel> serviceList(String serviceId, String catId) async {
    HelperWidget.showProgress(context);
    serviceModel = await ApiProvider().getServiceList(serviceId, catId);
    Navigator.pop(context);
    if (serviceModel?.status == true) {
      // HelperWidget.showToast(message: userMatchListModel?.message);
      setState(() {});
    } else if (serviceModel?.status == false) {
      HelperWidget.showToast(message: 'No Service Found');
    }

    return serviceModel!;
  }

  //////////////////Image Picker Dialog//////////////////////////

  void _showImagePickerDialog(BuildContext context, String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext cxt) {
        return Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Material(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Choose From',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(
                      height: 1,
                      color: AppColor.borderGrey,
                    ),
                    ListTile(
                      horizontalTitleGap: 0,
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        getImagefromCamera();
                        Navigator.of(context).pop();
                      },
                      title: Text(
                        'Camera',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: AppColor.borderGrey,
                    ),
                    ListTile(
                      horizontalTitleGap: 0,
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        getImagefromGallery();
                        Navigator.of(context).pop();
                      },
                      title: Text(
                        'Gallery',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: AppColor.borderGrey,
                    ),
                    ListTile(
                      horizontalTitleGap: 0,
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      title: Text(
                        'Cancel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future getImagefromCamera() async {
    var image =
    await ImagePicker.platform.pickImage(source: ImageSource.camera);
    imgFile = File(image!.path);
    profilePath = image.path;
    setState(() {});
  }

  Future getImagefromGallery() async {
    var image =
    await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    imgFile = File(image!.path);

    profilePath = image!.path;
    setState(() {});
  }

  Future<CommonResponseModel> updateProfile(String name, String email,
      File image) async {
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
