import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flexo_app/helper_widget.dart';
import 'package:flexo_app/views/auth/login_screen.dart';
import 'package:flexo_app/views/auth/role_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constant/math_utils.dart';

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
  PageController? _pageController;
  int activeIndex = 0;
  @override
  void initState() {
    _pageController = new PageController(initialPage: activeIndex);
    _pageController!.addListener(() {});
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  activeIndex = index;
                  setState(() {});
                },
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: size.height,
                        width: size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(
                              -0.06661573562615142,
                              -0.023981664408761483,
                            ),
                            end: Alignment(
                              0.9592665406297107,
                              0.6723748228054462,
                            ),
                            colors: [
                             AppColor.colorWhite,
                              AppColor.colorWhite,
                            ],
                          ),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: getPadding(

                                  bottom: 10,
                                ),
                                child: carouselWidget()
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: getVerticalSize(
                            332.00,
                          ),
                          width: size.width,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: getPadding(
                                    bottom: 0,
                                  ),
                                  child: Image.asset(
                                      'assets/img_bg.png',
                                      height: getVerticalSize(
                                        332.00,
                                      ),
                                      width: size.width),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  margin: getMargin(
                                    left: 14,
                                    top: 31,
                                    right: 14,
                                    bottom: 31,
                                  ),

                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: getPadding(
                                              left: 12, right: 12, top: 25),
                                          child: Text(
                                            "Welcometo\n Flexiyoo",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppColor.textBlack,
                                              fontSize: getFontSize(
                                                25.98138999938965,
                                              ),

                                              fontWeight: FontWeight.w600,
                                              height: 1.00,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: getHorizontalSize(
                                            319.00,
                                          ),
                                          margin: getMargin(
                                            left: 12,
                                            top: 27,
                                            right: 12,
                                          ),
                                          child: Text(
                                            "Flexiyoo has workouts on demand that you can find based on how much time you have",
                                            maxLines: null,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppColor.textGrey,
                                              fontSize: getFontSize(
                                                15.396379470825195,
                                              ),

                                              fontWeight: FontWeight.w400,
                                              height: 1.37,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: getPadding(bottom: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: getVerticalSize(
                          7.00,
                        ),
                        margin: getMargin(
                          left: 12,
                          top: 0,
                          right: 12,
                        ),
                        child: AnimatedSmoothIndicator(
                          activeIndex: activeIndex,
                          count: 3,
                          axisDirection: Axis.horizontal,
                          effect: ScrollingDotsEffect(
                            spacing: 7.699997,
                            activeDotColor: AppColor.orangeColor,
                            dotColor: AppColor.borderGrey,
                            dotHeight: getVerticalSize(
                              7.70,
                            ),
                            dotWidth: getHorizontalSize(
                              7.70,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,

                        margin: getMargin(
                          top: 22,left: 16,right: 6
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RoleScreen()));
                          },
                          child: const Text(
                            "Get Started",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),


                      Padding(
                        padding: getPadding(
                          left: 12,
                          top: 21,
                          right: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: getPadding(
                                top: 1,
                                bottom: 2,
                              ),
                              child: Text(
                                "Already have account?",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: AppColor.textGrey,
                                  fontSize: getFontSize(
                                    13.471831321716309,
                                  ),
                                  fontWeight: FontWeight.w400,
                                  height: 1.00,
                                ),
                              ),
                            ),
                            Padding(
                              padding: getPadding(
                                left: 0,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
                                  );
                                },
                                child: Text(
                                  " Sign in ",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: AppColor.orangeColor,
                                    fontSize: getFontSize(
                                      15.396379470825195,
                                    ),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    height: 1.00,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );/*SafeArea(
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
    )*/;
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
              height: Get.height * 0.76,
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











