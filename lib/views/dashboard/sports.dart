import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flexo_app/appbar.dart';
import 'package:flexo_app/helper_widget.dart';
import 'package:flexo_app/model/banner_model.dart';
import 'package:flexo_app/services/auth_services.dart';
import 'package:flexo_app/views/auth/dashboard.dart';
import 'package:flexo_app/views/dashboard/GymDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constant/color_constant.dart';

import '../../constant/math_utils.dart';
import '../../model/service_model.dart';
import '../../model/service_provider_list_model.dart';
import '../../model/sports_model.dart';
import '../../storage/get_storage.dart';
import '../../widget/custom_icon_button.dart';
import '../../widget/custom_search_view.dart';
import '../../widget/spacing.dart';
import '../auth/see_all_listing_screen.dart';

class SportsScreen extends StatefulWidget {
  final String comingFrom;

  const SportsScreen({Key? key, required this.comingFrom}) : super(key: key);

  @override
  State<SportsScreen> createState() => _SportsScreenState();
}

class _SportsScreenState extends State<SportsScreen> {
  CategoryList? sportsCategoriesModel;
  List<Categories>? sportItemList = [];
  BannerModel? bannerModel;
  List<Banners> bannerList = [];
  int currentPageIndex = 0;
  List<Providers>? usersList = [];
  ServiceProviderList? serviceProviderList;
  TextEditingController searchController = TextEditingController();
  ServiceModel? serviceModel;

  List<ServiceItem>? servicesLists = [];

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 300), () {
      print("hit the get Category Api");
      bannerListApi().then((value) {
        bannerList = value.banners!;
        print('bannerList=====>${bannerList.length}');
      });
      sportsList().then((value) async {
        if (value != null) {
          sportItemList = value.categories;
          if (mounted) setState(() {});
          print('sportsList Length=============>${sportItemList!.length}');
        }
      });

      getUserList().then((value) {
        if (value != null) {
          usersList = value.services;
          if (mounted) setState(() {});
          print('getUserList Length=============>${usersList!.length}');
        }
      });

      servicesList().then((value) {
        if (value != null) {
          servicesLists = value.services;
          if (mounted) setState(() {});
          print('getUserList Length=============>${usersList!.length}');
        }
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.colorWhite,
          body: Column(
            children: [
              Expanded(
                child: Container(
                  margin: getMargin(
                    top: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: size.width,
                        margin: getMargin(left: 16, right: 16, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: getPadding(
                                top: 6,
                                bottom: 5,
                              ),
                              child: Text(
                                "Hi, ${Storage().getStoreName()}",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: AppColor.textBlack,
                                  fontSize: getFontSize(
                                    25.98634910583496,
                                  ),
                                  // fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  height: 1.00,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.add_alert_sharp,
                              size: 24,
                              color: AppColor.orangeColor,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: getPadding(
                            left: 0,
                            top: 0,
                          ),
                          child: Container(
                            margin: getMargin(
                              bottom: 16,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomSearchView(
                                  width: 344,
                                  focusNode: FocusNode(),
                                  controller: searchController,
                                  hintText: "Search something",
                                  margin: getMargin(
                                    left: 16,
                                    right: 16,
                                  ),
                                  alignment: Alignment.center,
                                  prefix: Container(
                                    margin: getMargin(
                                      left: 16,
                                      top: 15,
                                      right: 16,
                                      bottom: 15,
                                    ),
                                    child: Icon(Icons.search_rounded),
                                  ),
                                  prefixConstraints: BoxConstraints(
                                    minWidth: getSize(
                                      15.00,
                                    ),
                                    minHeight: getSize(
                                      15.00,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: getVerticalSize(
                                      207.00,
                                    ),
                                    width: size.width,
                                    margin: getMargin(
                                      left: 16,
                                      top: 30,
                                      right: 16,
                                    ),
                                    child: CarouselSlider(
                                      options: CarouselOptions(
                                          aspectRatio: 2.0,
                                          viewportFraction: 1,
                                          enlargeCenterPage: true,
                                          autoPlay: true,
                                          onPageChanged: (index, dwqwd) {
                                            setState(() {
                                              currentPageIndex = index;
                                            });
                                          }),
                                      items: bannerList
                                          .map((e) => Container(
                                                width: double.infinity,
                                                height: Get.height * 0.32,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          getHorizontalSize(
                                                    7.70,
                                                  )),
                                                  child: Image.network(
                                                    e.slide.toString(),
                                                    fit: BoxFit.fitWidth,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: getVerticalSize(
                                    7.00,
                                  ),
                                  margin: getMargin(
                                    left: 12,
                                    top: 0,
                                    right: 12,
                                  ),
                                  child: AnimatedSmoothIndicator(
                                    activeIndex: currentPageIndex,
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
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    margin: getMargin(
                                      top: 29,
                                      right: 0,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: getPadding(
                                              left: 16,
                                              right: 16,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  "Category",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: getFontSize(
                                                      19.249147415161133,
                                                    ),
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.00,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: getPadding(
                                                    top: 3,
                                                    bottom: 1,
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                SeeAllListing(
                                                                    listingType:
                                                                        'Categories')),
                                                      );
                                                    },
                                                    child: Text(
                                                      "View All",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        color:
                                                            AppColor.textGrey,
                                                        fontSize: getFontSize(
                                                          14.436860084533691,
                                                        ),
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 1.00,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: getPadding(
                                              top: 9, right: 16, left: 16),
                                          child: Text(
                                            'Categories: ${sportsCategoriesModel?.totalRecords.toString() ?? '0'}',
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: AppColor.textGrey,
                                              fontSize: getFontSize(
                                                11.549488067626953,
                                              ),
                                              fontWeight: FontWeight.w400,
                                              height: 1.00,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Container(
                                              height: getVerticalSize(70),
                                              child: ListView.separated(
                                                  padding: getPadding(
                                                      left: 8, right: 8),
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          HorizontalSpace(
                                                              width: 16),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      sportItemList!.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppColor.colorWhite,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          getHorizontalSize(
                                                            7.70,
                                                          ),
                                                        ),
                                                        border: Border.all(
                                                          color:
                                                              AppColor.borderGrey,
                                                          width:
                                                              getHorizontalSize(
                                                            0.96,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                              padding:
                                                                  getPadding(
                                                                left: 16,
                                                                top: 4,
                                                                right: 16,
                                                              ),
                                                              child:
                                                                  Image.network(
                                                                '${sportItemList![index].image}',
                                                                height: getSize(
                                                                  26.00,
                                                                ),
                                                                width: getSize(
                                                                  26.00,
                                                                ),
                                                                fit: BoxFit
                                                                    .cover,
                                                              )),
                                                          Padding(
                                                            padding: getPadding(
                                                              left: 16,
                                                              top: 5,
                                                              right: 15,
                                                              bottom: 4,
                                                            ),
                                                            child: Text(
                                                              sportItemList![
                                                                          index]
                                                                      .category ??
                                                                  '',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: AppColor
                                                                    .textBlack,
                                                                fontSize:
                                                                    getFontSize(
                                                                  13.474403381347656,
                                                                ),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                height: 1.00,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  })),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    margin: getMargin(
                                      left: 0,
                                      right: 0,
                                      top: 32,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: getPadding(
                                            right: 16,
                                            left: 16,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                "Popular Workout Providers",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: getFontSize(
                                                    19.249147415161133,
                                                  ),
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.00,
                                                ),
                                              ),
                                              Padding(
                                                padding: getPadding(
                                                  left: 0,
                                                  top: 4,
                                                  bottom: 1,
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SeeAllListing(
                                                                  listingType:
                                                                      '')),
                                                    );
                                                  },
                                                  child: Text(
                                                    "View All",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      color: AppColor.textGrey,
                                                      fontSize: getFontSize(
                                                        14.436860084533691,
                                                      ),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 1.00,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: getPadding(
                                              top: 9, right: 16, left: 16),
                                          child: Text(
                                            "Workouts: ${serviceProviderList?.totalRecords.toString() ?? '0'}",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: AppColor.textGrey,
                                              fontSize: getFontSize(
                                                11.549488067626953,
                                              ),
                                              fontWeight: FontWeight.w400,
                                              height: 1.00,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          height: getVerticalSize(
                                            223.00,
                                          ),
                                          width: size.width,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount: usersList!.length > 4
                                                ? 4
                                                : usersList?.length,
                                            itemBuilder: (context, index) {
                                              return gymItems(
                                                  usersList![index]);
                                            },
                                          ) /*ListView.separated(
                                            separatorBuilder: (context, index) =>
                                                HorizontalSpace(width: 15),
                                            padding: getPadding(
                                              top: 17,
                                              right: 16,
                                              left: 16,
                                              bottom: 3,
                                            ),
                                            scrollDirection: Axis.horizontal,
                                            physics: BouncingScrollPhysics(),
                                            itemCount:sportItemList!.length,
                                            itemBuilder: (context, index) {
                                              return gymItems(sportItemList![indeex]);
                                            },
                                          )*/
                                          ,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: getPadding(
                                      left: 16,
                                      top: 32,
                                      right: 16,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding: getPadding(
                                            bottom: 2,
                                          ),
                                          child: Text(
                                            "Exercises",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: AppColor.textBlack,
                                              fontSize: getFontSize(
                                                19.249147415161133,
                                              ),
                                              fontWeight: FontWeight.w500,
                                              height: 1.00,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: getPadding(
                                            top: 7,
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SeeAllListing(
                                                            listingType:
                                                                'Exercises')),
                                              );
                                            },
                                            child: Text(
                                              "View All",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: AppColor.textGrey,
                                                fontSize: getFontSize(
                                                  14.436860084533691,
                                                ),
                                                fontWeight: FontWeight.w500,
                                                height: 1.00,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: getPadding(
                                    left: 16,
                                    top: 10,
                                    right: 16,
                                  ),
                                  child: Text(
                                    "Exercises: ${serviceModel?.totalRecords.toString() ?? '0'}",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: AppColor.textGrey,
                                      fontSize: getFontSize(
                                        11.549488067626953,
                                      ),
                                      fontWeight: FontWeight.w400,
                                      height: 1.00,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: getPadding(
                                      left: 16,
                                      top: 17,
                                      right: 16,
                                    ),
                                    child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: servicesLists!.length > 4
                                          ? 4
                                          : servicesLists?.length,
                                      itemBuilder: (context, index) {
                                        return serviceItems(
                                            servicesLists![index]);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
    );
  }

  Widget serviceItems(ServiceItem serviceItem) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        child: Container(
          margin: getMargin(
            top: 7.700012,
            bottom: 7.700012,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              getHorizontalSize(
                7.70,
              ),
            ),
            border: Border.all(
              color: AppColor.borderGrey,
              width: getHorizontalSize(
                0.96,
              ),
            ),
          ),
          padding: getPadding(left: 0, right: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: getPadding(
                  left: 0,
                  top: 7,
                  bottom: 7,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    HorizontalSpace(
                      width: 7,
                    ),
                    Container(
                      height: getSize(
                        61.00,
                      ),
                      width: getSize(
                        61.00,
                      ),
                      child: serviceItem.image == ""
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(
                                getHorizontalSize(
                                  7.70,
                                ),
                              ),
                              child: Image.asset(
                                'assets/Gym-weights.png',
                                height: getVerticalSize(
                                  60.00,
                                ),
                                width: getHorizontalSize(
                                  61.00,
                                ),
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(
                                getHorizontalSize(
                                  7.70,
                                ),
                              ),
                              child: Image.network(
                                serviceItem.image.toString(),
                                height: getVerticalSize(
                                  60.00,
                                ),
                                width: getHorizontalSize(
                                  61.00,
                                ),
                              ),
                            ),
                    ),
                    HorizontalSpace(width: 15),
                    Container(
                      margin: getMargin(
                        left: 0,
                        top: 10,
                        bottom: 11,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              serviceItem.serviceTitle.toString(),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: getFontSize(
                                  13.399317741394043,
                                ),
                                fontWeight: FontWeight.w500,
                                height: 1.00,
                              ),
                            ),
                          ),
                          Padding(
                            padding: getPadding(
                              top: 9,
                              right: 10,
                            ),
                            child: Text(
                              serviceItem.duration.toString(),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: AppColor.textGrey,
                                fontSize: getFontSize(
                                  13.474403381347656,
                                ),
                                fontWeight: FontWeight.w400,
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
              Padding(
                padding: getPadding(
                  left: 0,
                  top: 28,
                  right: 0,
                  bottom: 28,
                ),
                child: InkWell(
                  onTap: () {
                    /*showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                top: Radius.circular(24),
                              )),
                              builder: (context) {
                                return ExerciseInfoScreen();
                              });*/
                  },
                  child: Row(
                    children: [
                      Icon(Icons.info_outline),
                      HorizontalSpace(
                        width: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget gymItems(Providers user) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GymDetailScreen(
                      id: user.userId.toString(),
                      name: user.serviceProvider.toString(),
                      image: user.userImage.toString(),
                      categoryId: user.categoryId.toString(),
                    )));
      },
      child: Container(
        margin: getMargin(
          right: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: getVerticalSize(
                153.00,
              ),
              width: getHorizontalSize(
                230.00,
              ),
              child: Card(
                clipBehavior: Clip.antiAlias,
                elevation: 0,
                margin: EdgeInsets.all(0),
                color: AppColor.textGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    getHorizontalSize(
                      7.70,
                    ),
                  ),
                ),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            getHorizontalSize(
                              7.70,
                            ),
                          ),
                          child: user.userImage == ""
                              ? Image.asset(
                                  'assets/new-home-gym.png',
                                  height: getVerticalSize(
                                    153.00,
                                  ),
                                  width: getHorizontalSize(
                                    230.00,
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  '${user.userImage}',
                                  height: getVerticalSize(
                                    153.00,
                                  ),
                                  width: getHorizontalSize(
                                    230.00,
                                  ),
                                  fit: BoxFit.cover,
                                )),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: getPadding(
                top: 12,
                right: 10,
              ),
              child: Text(
                user.serviceProvider ?? '',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColor.textBlack,
                  fontSize: getFontSize(
                    15.399317741394043,
                  ),
                  fontWeight: FontWeight.w500,
                  height: 1.00,
                ),
              ),
            ),
            Padding(
              padding: getPadding(
                top: 6,
                right: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: getPadding(
                      top: 1,
                    ),
                    child: Text(
                      "Category Name:",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: AppColor.textGrey,
                        fontSize: getFontSize(
                          11.549488067626953,
                        ),
                        fontWeight: FontWeight.w500,
                        height: 1.00,
                      ),
                    ),
                  ),
                  Container(
                    height: getSize(
                      3.00,
                    ),
                    width: getSize(
                      3.00,
                    ),
                    margin: getMargin(
                      left: 7,
                      top: 3,
                      bottom: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.orangeColor,
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          1.93,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      left: 7,
                      bottom: 1,
                    ),
                    child: Text(
                      user.category ?? '',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: AppColor.orangeColor,
                        fontSize: getFontSize(
                          11.549488067626953,
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
    );
  }

  Future<BannerModel> bannerListApi() async {
    //HelperWidget.showProgress(context);
    bannerModel = await ApiProvider().getBannerList();
    // Navigator.pop(context);
    if (bannerModel?.status == true) {
      // HelperWidget.showToast(message: userMatchListModel?.message);
      setState(() {});
    } else if (bannerModel?.status == false) {
      // HelperWidget.showToast(message: blockUserModel?.message);
    }

    return bannerModel!;
  }

  Future<CategoryList> sportsList() async {
    HelperWidget.showProgress(context);
    sportsCategoriesModel = await ApiProvider().getSportsList();
    Navigator.pop(context);
    if (sportsCategoriesModel?.status == true) {
      HelperWidget.showToast(message: sportsCategoriesModel?.message);
      setState(() {});
    } else if (sportsCategoriesModel?.status == false) {
      // HelperWidget.showToast(message: blockUserModel?.message);
    }

    return sportsCategoriesModel!;
  }

  Future<ServiceProviderList> getUserList() async {
    //  HelperWidget.showProgress(context);
    serviceProviderList = await ApiProvider().getServiceProviderList();
    //  Navigator.pop(context);
    if (serviceProviderList?.status == true) {
      // HelperWidget.showToast(message: serviceProviderList?.message);
      setState(() {});
    } else if (serviceProviderList?.status == false) {
      // HelperWidget.showToast(message: blockUserModel?.message);
    }

    return serviceProviderList!;
  }

  Future<ServiceModel> servicesList() async {
    HelperWidget.showProgress(context);
    serviceModel = await ApiProvider().getServicesList();
    Navigator.pop(context);
    if (serviceModel?.status == true) {
      // HelperWidget.showToast(message: userMatchListModel?.message);
      setState(() {});
    } else if (serviceModel?.status == false) {
      HelperWidget.showToast(message: 'No Service Found');
    }

    return serviceModel!;
  }

  Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Do you want to exit?"),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('yes selected');
                            exit(0);
                          },
                          child: Text("Yes"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red.shade800),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          print('no selected');
                          Navigator.of(context).pop();
                        },
                        child:
                            Text("No", style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
