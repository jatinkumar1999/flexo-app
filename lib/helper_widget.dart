// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constant/color_constant.dart';

class HelperWidget {

  static closeKeyBoard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }


  static showToast({message}) {
    Fluttertoast.cancel();

    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 14);
  }


  static showProgress([BuildContext? context]) {
    showDialog(
      context: context ?? Get.context!,
      builder: (_) =>
          Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LoadingAnimationWidget.inkDrop(
                    // color: ColorConstants.splash1,
                    color: AppColor.orangeColor,
                    size: 40,
                  ),
                  // SizedBox(height: 5,),
                ],
              ),
            ),
          ),
    );
  }


  static String getTimeString(int value) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    return '${hour.toString().padLeft(2, "0")}:${minutes.toString().padLeft(
        2, "0")}';
  }
 static String getInitials({String? string, int? limitTo}) {
    var buffer = StringBuffer();
    var split = string!.split(' ');
    for (var i = 0 ; i < (limitTo ?? split.length); i ++) {
      buffer.write(split[i][0]);
    }

    return buffer.toString();
  }
}
