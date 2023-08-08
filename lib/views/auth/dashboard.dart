import 'package:flexo_app/appbar.dart';
import 'package:flexo_app/helper_widget.dart';
import 'package:flexo_app/services/auth_services.dart';
import 'package:flutter/material.dart';

import '../../constant/color_constant.dart';
import '../../constant/math_utils.dart';
import '../../model/service_provider_list_model.dart';
import '../../model/service_provider_model.dart';
import '../../widget/spacing.dart';

class DashboardScreen extends StatefulWidget {

  DashboardScreen({Key? key,})
      : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  ServiceProviderModel? serviceProviderModel;
  List<User>? sportItemList = [];
  List<Providers>? usersList = [];
  ServiceProviderList? serviceProvider;
  List<String> levelsList =[
    'Beginner',
    'Intermediate',
    'Advanced',
  ];
  int selectedIndex=0;
  @override
  void initState() {
 getUserList().then((value) {
            if (value != null) {
              usersList = value.services;
              if (mounted) setState(() {});
              print('getUserList Length=============>${usersList!.length}');
            }
          });
         Future.delayed(const Duration(milliseconds: 300), () {
            print("hit the get Category Api");
            serviceProviderList('').then((value) async {
              if (value != null) {
                sportItemList = value.services;
                if (mounted) setState(() {});
                print('results Length=============>${sportItemList!.length}');
              }
            });
          });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBarPage(title: 'Home'),
        body:      Expanded(
          child: Container(
            width: size.width,
            child: SingleChildScrollView(
              child: Container(
                height: getVerticalSize(
                  760.00,
                ),
                width: size.width,
                margin: getMargin(
                  top: 3,
                ),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: getHorizontalSize(
                          359.00,
                        ),
                        margin: getMargin(
                          left: 10,
                          right: 10,
                          top: 20,

                          bottom: 10,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [


                            Container(
                              height: getVerticalSize(44),
                              child: Row(
                                children: [
                                  Container(
                                    margin: getMargin(
                                      bottom: 1,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColor.borderGrey,
                                      borderRadius: BorderRadius.circular(
                                        getHorizontalSize(
                                          19.23,
                                        ),
                                      ),
                                    ),
                                    padding: getPadding(
                                        left: 20,right: 20,
                                        top: 14,
                                        bottom: 14
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: getPadding(
                                            left: 0,
                                            top: 0,
                                            bottom: 0,
                                          ),
                                          child: Text(
                                            "Clear All",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: AppColor.borderGrey,
                                              fontSize: getFontSize(
                                                11.538461685180664,
                                              ),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              height: 1.00,
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  HorizontalSpace(width: 16),
                                  Expanded(
                                    child: ListView.separated(
                                      padding: getPadding(
                                          left: 0,right:0
                                      ),
                                      itemCount: levelsList.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,


                                      itemBuilder: (context,index){
                                        return GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              selectedIndex=index;
                                            });
                                          },
                                          child: Container(
                                            padding: getPadding(
                                              left: 20,
                                              top: 13,
                                              right: 20,
                                              bottom: 14,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: selectedIndex==index?
                                              AppColor.orangeColor:AppColor.colorWhite),
                                              color:selectedIndex==index? AppColor.orangeColor:Colors.transparent,
                                              borderRadius: BorderRadius.circular(
                                                getHorizontalSize(
                                                  19.24,
                                                ),
                                              ),
                                            ),
                                            child: Text(
                                              levelsList[index],
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color:selectedIndex==index?AppColor.colorWhite:AppColor.borderGrey,
                                                fontSize: getFontSize(
                                                  11.544000625610352,
                                                ),
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                                height: 1.00,
                                              ),
                                            ),
                                          ),
                                        );
                                      }, separatorBuilder:(context, index)=>
                                        HorizontalSpace(width: 16)
                                      , ),


                                  ),
                                ],
                              ),
                            ),


                            Padding(
                              padding: getPadding(
                                top: 29,
                                right: 10,
                              ),
                              child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: getVerticalSize(
                                    162.00,
                                  ),
                                  crossAxisCount: 2,
                                  mainAxisSpacing: getHorizontalSize(
                                    15.39,
                                  ),
                                  crossAxisSpacing: getHorizontalSize(
                                    15.39,
                                  ),
                                ),
                                physics: BouncingScrollPhysics(),
                                itemCount: sportItemList!.length,
                                itemBuilder: (context, index) {
                                  return gymItems(sportItemList![index]);
                                },
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
          ),
        ),
      ),
    );
  }

  Widget gymItems(User sportsData) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: getVerticalSize(
              115.00,
            ),
            width: getHorizontalSize(
              164.00,
            ),
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 0,
              margin: EdgeInsets.all(0),
              color: AppColor.textGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  getHorizontalSize(
                    7.69,
                  ),
                ),
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: getPadding(
                        left: 1,
                        top: 1,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          getHorizontalSize(
                            7.69,
                          ),
                        ),
                        child:  sportsData.userImage == ""
                            ? Image.asset(
                          'assets/new-home-gym.png',
                          height: getVerticalSize(
                            114.00,
                          ),
                          width: getHorizontalSize(
                            163.00,
                          ),
                          fit: BoxFit.cover,
                        )
                            : Image.network(
                          '${sportsData.userImage}',
                          height: getVerticalSize(
                            114.00,
                          ),
                          width: getHorizontalSize(
                            163.00,
                          ),
                          fit: BoxFit.cover,
                        )
                      ),
                    ),
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
              "Boxing Sessions",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: TextStyle(
                color:AppColor.textBlack,
                fontSize: getFontSize(
                  15.384614944458008,
                ),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 1.00,
              ),
            ),
          ),
          Padding(
            padding: getPadding(
              top: 1,
              right: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: getPadding(
                    top: 1,
                  ),
                  child: Text(
                    "Beginner",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColor.orangeColor,
                      fontSize: getFontSize(
                        11.538461685180664,
                      ),
                      fontFamily: 'Poppins',
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
                    color: AppColor.textGrey,
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
                    "12 min",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColor.textGrey,
                      fontSize: getFontSize(
                        11.538461685180664,
                      ),
                      fontFamily: 'Open Sans',
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
    )/*Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      width: MediaQuery.of(context).size.width * 0.70,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: sportsData.userImage == ""
                    ? Image.asset(
                        'assets/new-home-gym.png',
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        '${sportsData.userImage}',
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                sportsData.serviceProvider ?? '',
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
    )*/;
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
                user.userImage == ""
                    ? Image.asset(
                  'assets/placeHolderIg.png',
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
                    : Image.network(
                  '${user.userImage}',
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                user.serviceProvider ?? '',
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


  Future<ServiceProviderModel> serviceProviderList(String catId) async {
    HelperWidget.showProgress(context);
    serviceProviderModel =
        await ApiProvider().getServicesProvider(categoryId: catId);
    Navigator.pop(context);
    if (serviceProviderModel?.status == true) {
      HelperWidget.showToast(message: serviceProviderModel?.message);
      setState(() {});
    } else if (serviceProviderModel?.status == false) {
      // HelperWidget.showToast(message: blockUserModel?.message);
    }

    return serviceProviderModel!;
  }

  Future<ServiceProviderList> getUserList() async {
   // HelperWidget.showProgress(context);
    serviceProvider = await ApiProvider().getServiceProviderList();
   // Navigator.pop(context);
    if (serviceProvider?.status == true) {
      //  HelperWidget.showToast(message: serviceProviderList?.message);
      setState(() {});
    } else if (serviceProvider?.status == false) {
      //  HelperWidget.showToast(message: blockUserModel?.message);
    }

    return serviceProvider!;
  }
}
