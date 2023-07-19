import 'package:flexo_app/appbar.dart';
import 'package:flexo_app/helper_widget.dart';
import 'package:flexo_app/model/service_provider_list_model.dart';
import 'package:flexo_app/model/service_provider_model.dart';
import 'package:flexo_app/model/sports_model.dart';
import 'package:flexo_app/services/auth_services.dart';
import 'package:flexo_app/views/dashboard/GymDetailScreen.dart';
import 'package:flutter/material.dart';

import '../../app_drawer.dart';

class DashboardScreen extends StatefulWidget {
  String catId;
  String comingFrom;

  DashboardScreen({Key? key, required this.catId, required this.comingFrom})
      : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  ServiceProviderModel? serviceProviderModel;
  List<Services>? sportItemList = [];
  List<User>? usersList = [];
  ServiceProviderList? serviceProvider;

  @override
  void initState() {
    widget.comingFrom == 'skip'
        ? getUserList().then((value) {
            if (value != null) {
              usersList = value.user;
              if (mounted) setState(() {});
              print('getUserList Length=============>${usersList!.length}');
            }
          })
        : Future.delayed(const Duration(milliseconds: 300), () {
            print("hit the get Category Api");
            serviceProviderList(widget.catId).then((value) async {
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
        drawer: myDrawer(context),
        body: SingleChildScrollView(
          primary: true,
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
             widget.comingFrom == 'skip'?   ListView.builder(
                 scrollDirection: Axis.vertical,
                 itemCount: usersList?.length,
                 shrinkWrap: true,
                 primary: false,
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
                 }): ListView.builder(
                  itemCount: sportItemList?.length,
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
                              /*      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GymDetailScreen(
                                    id: sportItemList![index].userId!,
                                    name:
                                    sportItemList![index].serviceProvider!,
                                    image:
                                    sportItemList![index].userImage!,

                                  )));*/
                            },
                            child: gymItems(sportItemList![index]));
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget gymItems(Services sportsData) {
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
                  'assets/placeHolderIg.png',
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
