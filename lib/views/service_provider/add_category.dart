import 'dart:io';

import 'package:flexo_app/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../app_drawer.dart';
import '../../constant/color_constant.dart';
import '../../helper_widget.dart';
import '../../model/common_response_model.dart';
import '../../services/auth_services.dart';
import '../../storage/get_storage.dart';
import '../dashboard/profile.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  File? _imageFile;
  String imagePath = '';
  TextEditingController serviceController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController desController = TextEditingController();
  final FocusNode _focusNodePassword = FocusNode();
  CommonResponseModel? commonResponseModel;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: myDrawer(context),
        appBar: MyAppBarPage(title: 'Add Service'),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const SizedBox(height: 24),
                TextFormField(
                  controller: serviceController,
                  keyboardType: TextInputType.name,
                  cursorColor: AppColor.orangeColor,
                  decoration: InputDecoration(
                    hintText: "Service Name",
                    hintStyle: TextStyle(fontSize: 14),
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: const Icon(
                      Icons.design_services,
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
                  onEditingComplete: () => _focusNodePassword.requestFocus(),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter service name.";
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  cursorColor: AppColor.orangeColor,
                  decoration: InputDecoration(
                    hintText: "Price",
                    hintStyle: TextStyle(fontSize: 14),
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: const Icon(
                      Icons.money,
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
                  onEditingComplete: () => _focusNodePassword.requestFocus(),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter price.";
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: desController,
                  keyboardType: TextInputType.text,
                  cursorColor: AppColor.orangeColor,
                  decoration: InputDecoration(
                    hintText: "Description ",
                    hintStyle: TextStyle(fontSize: 14),
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: const Icon(
                      Icons.description,
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
                  onEditingComplete: () => _focusNodePassword.requestFocus(),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter service name.";
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
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
                    if (_formKey.currentState!.validate()) {
                      addServices(serviceController.text.trim(), priceController.text.trim(), desController.text.trim());
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
    );
  }

  //////////////////Image Picker Dialog//////////////////////////

  Future _showImagePickerDialog() {
    return Get.defaultDialog(
      title: 'Choose From',
      titlePadding: EdgeInsets.only(top: 2),
      barrierDismissible: false,
      contentPadding: EdgeInsets.only(left: 8, right: 8),
      backgroundColor: AppColor.colorWhite,
      content: ListBody(
        children: [
          SizedBox(
            height: 2,
          ),
          Divider(
            height: 1,
            color: AppColor.borderGrey,
          ),
          ListTile(
            onTap: () {
              getImagefromCamera();
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
            leading: Icon(
              Icons.camera,
              color: Colors.blue,
            ),
          ),
          Divider(
            height: 1,
            color: AppColor.borderGrey,
          ),
          ListTile(
            onTap: () {
              getImagefromGallery();
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
            leading: Icon(
              Icons.account_box,
              color: Colors.blue,
            ),
          ),
          Divider(
            height: 1,
            color: AppColor.borderGrey,
          ),
          ListTile(
            onTap: () {
              Get.back();
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
            leading: Icon(
              Icons.cancel,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Future getImagefromCamera() async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.camera);
    imagePath = image!.path;
  }

  Future getImagefromGallery() async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    imagePath = image!.path;
  }

  Future<CommonResponseModel> addServices(
       service, price, desc) async {
    var userId = await Storage().getStoreUserId().toString();
    var catId = await Storage().getUserCategoryId().toString();

    HelperWidget.showProgress(context);
    commonResponseModel = await ApiProvider().addService(
        userId: userId,
        catId: catId,
        service: service,
        price: price,
        desc: desc);
    Navigator.pop(context);
    if (commonResponseModel?.status == true) {
      HelperWidget.showToast(message: commonResponseModel?.message);
      serviceController.clear();
      priceController.clear();
      desController.clear();

      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
            return ProfileScreen();
          }));

      setState(() {});
    } else if (commonResponseModel?.status == false) {
      HelperWidget.showToast(message: commonResponseModel?.message);
    }

    return commonResponseModel!;
  }
}
