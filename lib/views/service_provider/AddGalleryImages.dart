import 'dart:io';

import 'package:flexo_app/storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:async';
import '../../model/common_response_model.dart';

import '../../constant/color_constant.dart';

import 'package:flexo_app/services/auth_services.dart';

import '../../constant/math_utils.dart';
import '../../helper_widget.dart';
import '../../model/common_response_model.dart';

class AddGalleryImage extends StatefulWidget {
  @override
  _AddGalleryImageState createState() {
    return _AddGalleryImageState();
  }
}

class _AddGalleryImageState extends State<AddGalleryImage> {
  var images = <Object>[];
  List<XFile>? imageFileList = [];
  final ImagePicker imagePicker = ImagePicker();
  List<File>? imageList = [];
  CommonResponseModel? commonResponseModel;
  ImageUploadModel? imageUpload;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
    });
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
            "Add Banner",
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

          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: buildGridView(),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                  addImageslist();
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1,
      children: List.generate(images.length, (index) {
        if (images[index] is ImageUploadModel) {
          ImageUploadModel? uploadModel = images[index] as ImageUploadModel?;
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 175,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(
                          File(uploadModel!.imageFile!.path),
                        ),
                      ),
                    )),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    child: Icon(
                      Icons.remove_circle,
                      size: 20,
                      color: Colors.red,
                    ),
                    onTap: () {
                      setState(() {
                        images.replaceRange(index, index + 1, ['Add Image']);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Card(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _onAddImageClick(index);
              },
            ),
          );
        }
      }),
    );
  }

  Future _onAddImageClick(int index) async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();

    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);

    }
    print("Image List Length:" + imageFileList!.length.toString());
    getFileImage(index);

    setState(() {});
  }

  void getFileImage(int index) async {
//    var dir = await path_provider.getTemporaryDirectory();

    for (var i in imageFileList!) {
      setState(() {
 imageUpload = new ImageUploadModel();
        imageUpload?.isUploaded = false;
        imageUpload?.uploading = false;
        imageUpload?.imageFile = File(i.path);
        imageUpload?.imageUrl = '';
        images.replaceRange(index, index + 1, [imageUpload!]);
      });

    }
  }

  Future<CommonResponseModel> addImageslist() async {
    var userId = await Storage().getStoreUserId().toString();

    HelperWidget.showProgress(context);
    commonResponseModel = await ApiProvider().addImages(
      userId: userId,
      filepath: imageFileList ?? [],
    );
    Navigator.pop(context);
    if (commonResponseModel?.status == true) {
      HelperWidget.showToast(message: commonResponseModel?.message);
      //  getProfile();
      setState(() {});
    } else if (commonResponseModel?.status == false) {
      HelperWidget.showToast(message: commonResponseModel?.message);
    }

    return commonResponseModel!;
  }
}

class ImageUploadModel {
  bool? isUploaded;
  bool? uploading;
  File? imageFile;
  String? imageUrl;

  ImageUploadModel({
    this.isUploaded,
    this.uploading,
    this.imageFile,
    this.imageUrl,
  });
}
