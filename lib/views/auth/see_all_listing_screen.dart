import 'package:flutter/material.dart';

import '../../appbar.dart';
import '../../helper_widget.dart';
import '../../model/service_provider_list_model.dart';
import '../../model/sports_model.dart';
import '../../services/auth_services.dart';
import '../dashboard/GymDetailScreen.dart';
import 'dashboard.dart';

class SeeAllListing extends StatefulWidget {
  String? listingType;

  SeeAllListing({Key? key, required this.listingType}) : super(key: key);

  @override
  State<SeeAllListing> createState() => _SeeAllListingState();
}

class _SeeAllListingState extends State<SeeAllListing> {
  List<User>? usersList = [];
  ServiceProviderList? serviceProviderList;
  CategoryList? sportsCategoriesModel;
  List<Categories>? sportItemList = [];
  List<User>? searchAllStoreList = [];
  List<Categories>? searchAllCategoryList = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      widget.listingType == "Categories"
          ? await sportsList().then((value) async {
              if (value != null) {
                sportItemList = value.categories;
                searchAllCategoryList = sportItemList;
                if (mounted) setState(() {});
                print(
                    'sportsList Length=============>${sportItemList!.length}');
              }
            })
          : await getUserList().then((value) {
              if (value != null) {
                usersList = value.user;
                searchAllStoreList = usersList;

                if (mounted) setState(() {});
                print('getUserList Length=============>${usersList!.length}');
              }
            });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: MyAppBarPage(title: widget.listingType),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: SingleChildScrollView(
          primary: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              widget.listingType == "Categories"
                  ? categorySearchField()
                  : searchField(),
              SizedBox(
                height: 20,
              ),
              widget.listingType == 'Categories' ? category() : serviceUsers()
            ],
          ),
        ),
      ),
    ));
  }

  Widget serviceUsers() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: searchAllStoreList?.length,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return searchAllStoreList?.length == 0
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
                            builder: (context) => GymDetailScreen(
                                  id: searchAllStoreList![index].id.toString(),
                                  name: searchAllStoreList![index]
                                      .name
                                      .toString(),
                                  image: searchAllStoreList![index]
                                      .image
                                      .toString(),
                                  categoryId: searchAllStoreList![index]
                                      .categoryId
                                      .toString(),
                                )));
                  },
                  child: serviceItems(searchAllStoreList![index]));
        });
  }

  Widget category() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: searchAllCategoryList?.length,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return searchAllCategoryList?.length == 0
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
                            builder: (context) => DashboardScreen(
                                  catId: searchAllCategoryList![index]
                                      .id
                                      .toString(),
                                  comingFrom: 'categories',
                                )));
                  },
                  child: gymItems(searchAllCategoryList![index]));
        });
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
                    sportsData.image == ""
                        ? Image.asset(
                            'assets/new-home-gym.png',
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
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

  Widget searchField() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(35),
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        onChanged: (value) => _runFilter(value),
        onSubmitted: (value) {},
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          //hintText: 'searchByName'.tr,
          hintText: "Search by name",

          prefixIcon: Padding(
            padding: EdgeInsets.all(15),
            child: Icon(Icons.search),
          ),
        ),
      ),
    );
  }

  Widget categorySearchField() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(35),
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        onChanged: (value) => categoryrFilter(value),
        onSubmitted: (value) {},
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          //hintText: 'searchByName'.tr,
          hintText: "Search by name",

          prefixIcon: Padding(
            padding: EdgeInsets.all(15),
            child: Icon(Icons.search),
          ),
        ),
      ),
    );
  }

  void _runFilter(String enteredKeyword) {
    List<User>? results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = usersList;
    } else {
      results = usersList!
          .where((store) =>
              store.name!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      searchAllStoreList = results;
    });
  }

  void categoryrFilter(String enteredKeyword) {
    List<Categories>? results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = sportItemList;
    } else {
      results = sportItemList!
          .where((store) => store.category!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      searchAllCategoryList = results;
    });
  }

  Future<CategoryList> sportsList() async {
    HelperWidget.showProgress(context);
    sportsCategoriesModel = await ApiProvider().getSportsList();
    Navigator.pop(context);
    if (sportsCategoriesModel?.status == true) {
      //HelperWidget.showToast(message: sportsCategoriesModel?.message);
      setState(() {});
    } else if (sportsCategoriesModel?.status == false) {
      // HelperWidget.showToast(message: blockUserModel?.message);
    }

    return sportsCategoriesModel!;
  }

  Future<ServiceProviderList> getUserList() async {
    HelperWidget.showProgress(context);
    serviceProviderList = await ApiProvider().getServiceProviderList();
    Navigator.pop(context);
    if (serviceProviderList?.status == true) {
      //  HelperWidget.showToast(message: serviceProviderList?.message);
      setState(() {});
    } else if (serviceProviderList?.status == false) {
      // HelperWidget.showToast(message: blockUserModel?.message);
    }

    return serviceProviderList!;
  }
}
