import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flexo_app/app_drawer.dart';
import 'package:flexo_app/appbar.dart';
import 'package:flexo_app/helper_widget.dart';
import 'package:flexo_app/model/banner_model.dart';
import 'package:flexo_app/services/api_constant.dart';
import 'package:flexo_app/services/auth_services.dart';
import 'package:flexo_app/views/auth/dashboard.dart';
import 'package:flexo_app/views/dashboard/GymDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/service_provider_list_model.dart';
import '../../model/sports_model.dart';
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
  List<User>? usersList = [];
  ServiceProviderList? serviceProviderList;

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
          usersList = value.user;
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
          appBar: MyAppBarPage(title: 'Category'),
          drawer: myDrawer(context),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 100 * 25,
                      padding: const EdgeInsets.all(12.0),
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
                                  child: Image.network(
                                    e.slide.toString(),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Categories",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          sportItemList!.isEmpty
                              ? Container()
                              :    InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SeeAllListing(
                                            listingType: 'Categories',

                                          )));

                            },
                            child: Text(
                              "See All",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height / 100 * 25,
                        padding: const EdgeInsets.all(12.0),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (sportItemList ?? []).length > 10
                            ? 10
                            : sportItemList?.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return sportItemList?.length == 0
                                  ? Center(
                                      child: Text(
                                        'No record found',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DashboardScreen(
                                                      catId:
                                                          sportItemList![index]
                                                              .id
                                                              .toString(),
                                                      comingFrom: 'categories',
                                                    )));
                                      },
                                      child: gymItems(sportItemList![index]));
                            })),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Service Provider",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          usersList!.isEmpty
                              ? Container()
                              :    InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SeeAllListing(
                                            listingType: 'Service Provider',

                                          )));


                            },
                            child: Text(
                              "See All",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height / 100 * 25,
                        padding: const EdgeInsets.all(12.0),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (usersList ?? []).length > 10
                                ? 10
                                : usersList?.length,

                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return usersList?.length == 0
                                  ? Center(
                                      child: Text(
                                        'No record found',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GymDetailScreen(
                                                      id: usersList![index]
                                                          .id
                                                          .toString(),
                                                      name: usersList![index]
                                                          .name
                                                          .toString(),
                                                      image: usersList![index]
                                                          .image
                                                          .toString(),
                                                      categoryId: usersList![index].categoryId.toString(),
                                                    )));
                                      },
                                      child: serviceItems(usersList![index]));
                            })),
                  ],
                ),
              ),
              widget.comingFrom == ('Sports') ||
                      widget.comingFrom == ('BookingScreen') ||
                      widget.comingFrom == ('Splash') ||
                      widget.comingFrom == ('Login')
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashboardScreen(
                                      catId: '',
                                      comingFrom: 'skip',
                                    )));
                      },
                      child: Container(
                        padding: EdgeInsets.all(
                          18,
                        ),
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget gymItems(Categories sportsData) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      width: MediaQuery.of(context).size.width * 0.70,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: /*CachedNetworkImage(
                fit: BoxFit.cover,

                imageUrl:'${ApiUrl.imageUrl}${sportsData.sportImg}',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),*/
                    Image.network(
                  '${sportsData.image}',
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                sportsData.category ?? '',
                // '${'\$'}${'20'}',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 2,
            )
          ],
        ),
      ),
    );
  }

  Widget serviceItems(User user) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      width: MediaQuery.of(context).size.width * 0.70,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: /*CachedNetworkImage(
                fit: BoxFit.cover,

                imageUrl:'${ApiUrl.imageUrl}${sportsData.sportImg}',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),*/
                    user.image == ""
                        ? Image.asset(
                            'assets/new-home-gym.png',
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            '${user.image}',
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                user.name ?? '',
                // '${'\$'}${'20'}',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 2,
            )
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
