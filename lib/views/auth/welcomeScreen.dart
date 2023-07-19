import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flexo_app/helper_widget.dart';
import 'package:flexo_app/views/auth/login_screen.dart';
import 'package:flexo_app/views/auth/role_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constant/color_constant.dart';
import '../../model/banner_model.dart';
import '../../services/auth_services.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentPageIndex = 0;
  List<Banners> bannerList = [];
  List<String> imageList = [];
  BannerModel? bannerModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await bannerListApi().then((value) {
        bannerList = value.banners!;
        print('bannerList=====>${bannerList.length}');
      });
    });

    //Timer(const Duration(seconds: 7), () => pageChange());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: Stack(
          children: [
            carouselWidget(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [joinNowButton(), alreadyAccount()],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column carouselWidget() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              aspectRatio: 2.0,
              viewportFraction: 1,
              // enlargeCenterPage: true,
              autoPlay: true,
              height: Get.height * 0.96,
              onPageChanged: (index, dwqwd) {
                setState(() {
                  currentPageIndex = index;
                });
              }),
          items: bannerList
              .map((e) => Container(
                    child: CachedNetworkImage(
                      imageUrl: e.slide.toString(),
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Transform.scale(
                        scale: 0.15,
                        child: CircularProgressIndicator(
                            strokeWidth: 1.5, value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/new-home-gym.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget joinNowButton() {
    return Container(
      margin: const EdgeInsets.only(top: 0, left: 16, right: 16),
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
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => RoleScreen()));
        },
        child: const Text(
          "Continue",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget alreadyAccount() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.only(top: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(color: AppColor.orangeColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<BannerModel> bannerListApi() async {
    HelperWidget.showProgress(context);
    bannerModel = await ApiProvider().getBannerList();
    Navigator.pop(context);
    if (bannerModel?.status == true) {
      // HelperWidget.showToast(message: bannerModel?.message);
      setState(() {});
    } else if (bannerModel?.status == false) {
      // HelperWidget.showToast(message: bannerModel?.message);
    }

    return bannerModel!;
  }
}
