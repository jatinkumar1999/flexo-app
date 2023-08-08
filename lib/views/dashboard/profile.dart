import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexo_app/appbar.dart';
import 'package:flexo_app/helper_widget.dart';
import 'package:flexo_app/model/profile_model.dart';
import 'package:flexo_app/services/auth_services.dart';
import 'package:flexo_app/views/auth/my_profile.dart';
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
import 'bookingList.dart';

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
  List<ServiceItem>? serviceItem = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getProfile().then((value) {
        _controllerEmail.text = value.user!.email ?? '';
        _controllerUsername.text = value.user!.name ?? '';
        profilePath = value.user!.image ?? '';
        _controllerWallet.text = value.user!.totalBalance ?? '00';
        name=value.user!.name ?? '';
      });

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        padding: getPadding(
          left: 15,
          right: 14,
        ),
        child: Container(
          margin: getMargin(
            bottom: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: getPadding(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom: 16

                ),
                child: Center(
                  child: Text(
                    "Profile",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getFontSize(
                        26.008163452148438,
                      ),
                      fontWeight: FontWeight.w600,
                      height: 1.00,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: getSize(
                    77.00,
                  ),
                  width: getSize(
                    77.00,
                  ),
                  margin: getMargin(
                    left: 95,
                    top: 30,
                    right: 95,
                  ),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 0,
                    margin: EdgeInsets.all(0),
                    color: AppColor.textGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          38.53,
                        ),
                      ),
                    ),
                    child: Stack(
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
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
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
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: getPadding(
                    left: 95,
                    top: 9,
                    right: 95,
                  ),
                  child: Text(
                 name ??'UserName',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getFontSize(
                        19.26530647277832,
                      ),
                      fontWeight: FontWeight.w500,
                      height: 1.00,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: getPadding(
                    left: 1,
                    top: 25,
                    right: 1,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            getHorizontalSize(
                              7.71,
                            ),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              spreadRadius: getHorizontalSize(
                                2.00,
                              ),
                              blurRadius: getHorizontalSize(
                                2.00,
                              ),
                              offset: Offset(
                                0,
                                4.81632661819458,
                              ),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: getPadding(
                                left: 34,
                                top: 14,
                                right: 34,
                              ),
                              child: Text(
                                "⚖️",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: getFontSize(
                                    21.191837310791016,
                                  ),
                                  fontWeight: FontWeight.w400,
                                  height: 1.00,
                                ),
                              ),
                            ),
                            Padding(
                              padding: getPadding(
                                left: 34,
                                top: 6,
                                right: 34,
                                bottom: 18,
                              ),
                              child: Text(
                                "55 kg",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: getFontSize(
                                    13.485713958740234,
                                  ),
                                  fontWeight: FontWeight.w500,
                                  height: 1.00,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorWhite,
                          borderRadius: BorderRadius.circular(
                            getHorizontalSize(
                              7.71,
                            ),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              spreadRadius: getHorizontalSize(
                                2.00,
                              ),
                              blurRadius: getHorizontalSize(
                                2.00,
                              ),
                              offset: Offset(
                                0,
                                4.81632661819458,
                              ),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: getPadding(
                                left: 29,
                                top: 15,
                                right: 29,
                              ),
                              child: Icon(Icons.info_outline),
                            ),
                            Padding(
                              padding: getPadding(
                                left: 29,
                                top: 4,
                                right: 29,
                                bottom: 20,
                              ),
                              child: Text(
                                "167 cm",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: getFontSize(
                                    13.485713958740234,
                                  ),
                                  fontWeight: FontWeight.w500,
                                  height: 1.00,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.colorWhite,
                          borderRadius: BorderRadius.circular(
                            getHorizontalSize(
                              7.71,
                            ),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              spreadRadius: getHorizontalSize(
                                2.00,
                              ),
                              blurRadius: getHorizontalSize(
                                2.00,
                              ),
                              offset: Offset(
                                0,
                                4.81632661819458,
                              ),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: getPadding(
                                left: 23,
                                top: 15,
                                right: 23,
                              ),
                              child: Text(
                                "🎂",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: getFontSize(
                                    21.191837310791016,
                                  ),
                                  fontWeight: FontWeight.w400,
                                  height: 1.00,
                                ),
                              ),
                            ),
                            Padding(
                              padding: getPadding(
                                left: 23,
                                top: 3,
                                right: 23,
                                bottom: 20,
                              ),
                              child: Text(
                                "26 Years",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: getFontSize(
                                    13.485713958740234,
                                  ),
                                  fontWeight: FontWeight.w500,
                                  height: 1.00,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: double.infinity,
                  margin: getMargin(
                    left: 1,
                    top: 23,
                    right: 1,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      getHorizontalSize(
                        7.71,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: getHorizontalSize(
                          2.00,
                        ),
                        blurRadius: getHorizontalSize(
                          2.00,
                        ),
                        offset: Offset(
                          0,
                          4.81632661819458,
                        ),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      VerticalSpace(height: 12),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                               Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context)
                                    =>MyProfile()),
                                  );
                          },
                          child: Padding(
                            padding: getPadding(
                              left: 15,
                              top: 10,
                              bottom: 10,
                              right: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Account",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: getFontSize(
                                      15.41224479675293,
                                    ),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    height: 1.00,
                                  ),
                                ),
                                Padding(
                                  padding: getPadding(
                                    top: 1,
                                    bottom: 1,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 13.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: getVerticalSize(
                          1.00,
                        ),
                        width: getHorizontalSize(
                          310.00,
                        ),
                        margin: getMargin(
                          left: 15,
                          top: 7,
                          bottom: 7,
                          right: 15,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.textGrey,
                        ),
                      ),

                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookingListScreen()),
                            );
                          },
                          child: Padding(
                            padding: getPadding(
                              left: 15,
                              top: 10,
                              bottom: 10,
                              right: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "My workouts",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: getFontSize(
                                      15.41224479675293,
                                    ),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    height: 1.00,
                                  ),
                                ),
                                Padding(
                                  padding: getPadding(
                                    top: 1,
                                    bottom: 1,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 13.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),



                      Container(
                        height: getVerticalSize(
                          1.00,
                        ),
                        width: getHorizontalSize(
                          310.00,
                        ),
                        margin: getMargin(
                          left: 15,
                          top: 7,
                          bottom: 7,
                          right: 15,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: getPadding(
                              left: 15,
                              top: 10,
                              bottom: 10,
                              right: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: getPadding(
                                    bottom: 1,
                                  ),
                                  child: Text(
                                    "Workout reminders",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: getFontSize(
                                        15.41224479675293,
                                      ),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 1.00,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: getPadding(
                                    top: 1,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 13.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Container(
                        height: getVerticalSize(
                          1.00,
                        ),
                        width: getHorizontalSize(
                          310.00,
                        ),
                        margin: getMargin(
                          left: 15,
                          top: 7,
                          bottom: 7,
                          right: 15,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          Storage().clearLocalDB();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Login()),
                              (Route<dynamic> route) => false);
                        },
                        child: Padding(
                          padding: getPadding(
                            left: 15,
                            top: 10,
                            right: 15,
                            bottom: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "Logout",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: getFontSize(
                                    15.41224479675293,
                                  ),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  height: 1.00,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      VerticalSpace(height: 10)
                    ],
                  ),
                ),
              ),

            ],
          ),
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
          Text('${'₹'}${serviceItem.price.toString()}'),
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
