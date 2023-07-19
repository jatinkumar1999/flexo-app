import 'package:flexo_app/services/auth_services.dart';
import 'package:flexo_app/storage/get_storage.dart';
import 'package:flexo_app/views/auth/payment_screen.dart';
import 'package:flexo_app/views/dashboard/sports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../../constant/color_constant.dart';
import '../../helper_widget.dart';
import '../../model/common_response_model.dart';
import '../service_provider/add_category.dart';

class VerificationScreen extends StatefulWidget {
  final String email;

  VerificationScreen({Key? key, required this.email})
      : super(
          key: key,
        );

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _verifyFormKey = GlobalKey<FormState>();
  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  bool showErrorText = false;

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  String otpValue = "";
  CommonResponseModel? otpModel;

  // var otpFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/download.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColor.colorWhite,
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            title: Text(
              "Enter Verification Code",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontStyle: FontStyle.normal),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 5, right: 5, top: 7),
                child: Center(
                    child: Image.asset(
                  'assets/ic_otp.png',
                  width: 100,
                  height: 100,
                  color: AppColor.orangeColor,
                )),
              ),
              // desText(StringConstants.SENT_OTP +
              //     '${widget.type == 0 ? 'number' : 'email'}'),
              desText(" We have sent OTP on your email "),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OTPTextField(
                    length: 4,
                    width: MediaQuery.of(context).size.width / 1.5,
                    fieldWidth: 48,
                    style: TextStyle(fontSize: 17),
                    otpFieldStyle: OtpFieldStyle(
                      focusBorderColor: AppColor.borderGrey,
                      enabledBorderColor: AppColor.borderGrey,
                      borderColor: AppColor.borderGrey,
                      backgroundColor: AppColor.colorWhite,
                    ),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.box,
                    onCompleted: (pin) {
                      otpValue = pin;
                    },
                    onChanged: (pin) {
                      otpValue = pin;
                    },
                    outlineBorderRadius: 10.0,
                  ),
                ],
              ),
              showErrorText ? showError('The OTP is required') : Container(),

              const SizedBox(
                height: 24,
              ),
              joinNowButton(),
              const SizedBox(
                height: 8,
              ),
              getPadding(
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Didn’t receive a code?",
                          style: const TextStyle(
                              fontSize: 14.0,
                              color: AppColor.textBlack,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500)),
                      TextSpan(
                          text: " Request again",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              resendOTPApiCall();
                            },
                          style: const TextStyle(
                              fontSize: 13.0,
                              decoration: TextDecoration.underline,
                              color: AppColor.textBlack,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600)),
                    ])),
              ),
              const SizedBox(
                height: 80,
              ),
              const Expanded(
                child: SizedBox(),
              ),

              SizedBox(
                height: 0.07,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getPadding(Widget child) {
    return Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 2), child: child);
  }

  Widget otp1Field() {
    return TextField(
      focusNode: focusNode1,
      textInputAction: TextInputAction.next,
      controller: otp1,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      maxLength: 1,
      style: const TextStyle(
        color: AppColor.textBlack,
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
      onChanged: (v) {
        if (v.length == 1) focusNode2.requestFocus();
      },
      decoration: const InputDecoration(
        counterText: '',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: AppColor.textBlack,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget otp2Field() {
    return TextField(
      focusNode: focusNode2,
      textInputAction: TextInputAction.next,
      controller: otp2,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      maxLength: 1,
      style: const TextStyle(
        color: AppColor.textBlack,
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
      onChanged: (v) {
        if (v.length == 1) focusNode3.requestFocus();
        if (v.length == 0) focusNode1.requestFocus();
      },
      decoration: const InputDecoration(
        counterText: '',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: AppColor.textBlack,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget otp3Field() {
    return TextField(
      focusNode: focusNode3,
      textInputAction: TextInputAction.next,
      controller: otp3,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      maxLength: 1,
      style: const TextStyle(
        color: AppColor.textBlack,
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
      onChanged: (v) {
        if (v.length == 1) focusNode4.requestFocus();
        if (v.length == 0) focusNode2.requestFocus();
      },
      decoration: const InputDecoration(
        counterText: '',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: AppColor.textBlack,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget otp4Field() {
    return TextField(
      focusNode: focusNode4,
      textInputAction: TextInputAction.done,
      controller: otp4,
      textAlign: TextAlign.center,
      keyboardType:
          TextInputType.numberWithOptions(signed: true, decimal: true),
      maxLength: 1,
      style: const TextStyle(
        color: AppColor.textBlack,
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
      onChanged: (v) {
        if (v.length == 0) focusNode3.requestFocus();
      },
      //  onSubmitted: (value) {},
      decoration: const InputDecoration(
        counterText: '',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: AppColor.textBlack,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  showError(String text) {
    return Container(
      margin: EdgeInsets.only(left: 4, top: 1),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          text ?? "",
          style: TextStyle(
            color: Colors.red[800],
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        )

        /*       AppTextView(text, TextAlign.start, Colors.red[800]!,
            TextDecoration.none, 12.sp, FontWeight.w400, FontStyle.normal)*/
        ,
      ),
    );
  }

  Widget desText(String text) {
    return Container(
        //width: 1.0,
        margin: EdgeInsets.only(left: 0, right: 0, top: 5),
        // color: Colors.green,
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontStyle: FontStyle.normal),
        ));
  }

  Widget joinNowButton() {
    return Align(
        alignment: Alignment.center,
        child: Container(
            margin: EdgeInsets.only(
              top: 4,
              left: 6,
              right: 6,
            ),
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
                setState(() {
                  if (otpValue.length < 4) {
                    showErrorText = true;
                  } else {
                    showErrorText = false;
                    HelperWidget.closeKeyBoard();

                    verifyOtpApiCall(
                      otpValue,
                    );
                  }
                });
              },
              child: const Text(
                "Confirm",
                style: TextStyle(color: Colors.white),
              ),
            )));
  }

  void verifyOtpApiCall(String otp) async {
    HelperWidget.showProgress(context);
    otpModel = await ApiProvider().verifyAccount(otp: otp, email: widget.email);
    Navigator.pop(context);
    if (otpModel!.status == true) {
      HelperWidget.showToast(message: otpModel!.message);

      Storage().getStoreStoreMode().toString() == 'service_provider'
          ? Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddCategory()))
          : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PaymentScreen(
                        comingFrom: 'VerificationScreen',
                        catId: '',
                        serviceId: '',
                        timeSlotId: '',
                    providerId: '',
                      )));
    } else if (otpModel!.status == false) {
      HelperWidget.showToast(message: otpModel!.message);
    } else if (otpModel!.status == false) {
      HelperWidget.showToast(message: otpModel!.message);

      print('signupm error messsga e==>${otpModel!.message}');
    }
  }


  void resendOTPApiCall() async {
    HelperWidget.showProgress(context);
    otpModel = await ApiProvider().resendOtp(email: widget.email);
    Navigator.pop(context);
    if (otpModel!.status == true) {
      HelperWidget.showToast(message: otpModel!.message);

      Storage().getStoreStoreMode().toString() == 'service_provider'
          ? Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddCategory()))
          : Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentScreen(
                comingFrom: 'VerificationScreen',
                catId: '',
                serviceId: '',
                timeSlotId: '',
                providerId: '',
              )));
    } else if (otpModel!.status == false) {
      HelperWidget.showToast(message: otpModel!.message);
    } else if (otpModel!.status == false) {
      HelperWidget.showToast(message: otpModel!.message);

      print('signupm error messsga e==>${otpModel!.message}');
    }
  }

}
