import 'package:flutter/material.dart';

import '../../appbar.dart';
import '../../constant/color_constant.dart';
import '../../constant/math_utils.dart';
import '../../helper_widget.dart';
import '../../model/service_model.dart';
import '../../model/service_provider_list_model.dart';
import '../../model/sports_model.dart';
import '../../services/auth_services.dart';
import '../../widget/custom_search_view.dart';
import '../../widget/spacing.dart';
import '../dashboard/GymDetailScreen.dart';
import 'dashboard.dart';

class SeeAllListing extends StatefulWidget {
  String? listingType;

  SeeAllListing({Key? key, required this.listingType}) : super(key: key);

  @override
  State<SeeAllListing> createState() => _SeeAllListingState();
}

class _SeeAllListingState extends State<SeeAllListing> {
  ServiceProviderList? serviceProviderList;
  CategoryList? sportsCategoriesModel;
  List<Categories>? sportItemList = [];
  List<Providers>? searchProviderList = [];
  List<Providers>? usersList = [];

  List<Categories>? searchAllCategoryList = [];
  List<ServiceItem>? searchExerciseList = [];
  TextEditingController searchController = TextEditingController();
  ServiceModel? serviceModel;
  List<ServiceItem>? servicesLists = [];

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
                usersList = value.services;
                searchProviderList = usersList;

                if (mounted) setState(() {});
                print('getUserList Length=============>${usersList!.length}');
              }
            });
      servicesList().then((value) {
        if (value != null) {
          servicesLists = value.services;
          searchExerciseList = servicesLists;
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
      backgroundColor: AppColor.colorWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.colorWhite,
        title: (widget.listingType == 'Categories')
            ? Text(
          "Category",
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.black,
            fontSize: getFontSize(
              24.008163452148438,
            ),
            fontWeight: FontWeight.w500,
            height: 1.00,
          ),
        )
            : (widget.listingType == 'Exercises')
            ? Text(
          "Exercises",
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.black,
            fontSize: getFontSize(
              24.008163452148438,
            ),
            fontWeight: FontWeight.w500,
            height: 1.00,
          ),
        )
            : Text(
          "Popular Workout Providers",
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.black,
            fontSize: getFontSize(
              24.008163452148438,
            ),
            fontWeight: FontWeight.w500,
            height: 1.00,
          ),
        ) ,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
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
              (widget.listingType == 'Categories')
                  ? categorySearchField()
                  : (widget.listingType == 'Exercises')
                      ? exerciseSearchField()
                      : searchField(),

              /* widget.listingType == 'Categories'
                  ?
                  : ,*/
              SizedBox(
                height: 20,
              ),
              (widget.listingType == 'Categories')
                  ? category()
                  : (widget.listingType == 'Exercises')
                      ? services()
                      : providersUsers()
            ],
          ),
        ),
      ),
    ));
  }

  Widget providersUsers() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: searchProviderList?.length,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return searchProviderList?.length == 0
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
                                  id: searchProviderList![index]
                                      .userId
                                      .toString(),
                                  name: searchProviderList![index]
                                      .serviceProvider
                                      .toString(),
                                  image: searchProviderList![index]
                                      .userImage
                                      .toString(),
                                  categoryId: searchProviderList![index]
                                      .categoryId
                                      .toString(),
                                )));
                  },
                  child: providersItems(searchProviderList![index]));
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
                  onTap: () {}, child: gymItems(searchAllCategoryList![index]));
        });
  }

  Widget services() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: searchExerciseList?.length,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return searchExerciseList?.length == 0
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
                                  id: searchExerciseList![index]
                                      .serviceId
                                      .toString(),
                                  name: searchExerciseList![index]
                                      .serviceTitle
                                      .toString(),
                                  image: searchExerciseList![index]
                                      .image
                                      .toString(),
                                  categoryId: searchExerciseList![index]
                                      .categoryId
                                      .toString(),
                                )));
                  },
                  child: serviceItems(searchExerciseList![index]));
        });
  }

  Widget gymItems(Categories sportsData) {
    return Container(
      margin: getMargin(
        top: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            7.71,
          ),
        ),
        border: Border.all(
          color: AppColor.borderGrey,
          width: getHorizontalSize(
            0.96,
          ),
        ),
      ),
      padding: getPadding(
        left: 0,
        right: 0,
      ),
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
                HorizontalSpace(width: 7),
                Container(
                    height: getVerticalSize(53),
                    width: getHorizontalSize(53),
                    padding: getPadding(all: 8),
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius:
                            BorderRadius.circular(getHorizontalSize(8))),
                    child: sportsData.image == ""
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
                HorizontalSpace(width: 16),
                Container(
                  margin: getMargin(
                    left: 0,
                    top: 13,
                    bottom: 9,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        sportsData.category ?? '',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: getFontSize(
                            15.418182373046875,
                          ),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 1.00,
                        ),
                      ),
                      VerticalSpace(height: 8),
                      /*  Padding(
                        padding: getPadding(
                          right: 0,
                        ),
                        child: Text(
                          "${categoryList[index].numOfWorkouts.toString()} workouts",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color:
                            ColorConstant.bluegray800,
                            fontSize: getFontSize(
                              13.490909576416016,
                            ),
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w400,
                            height: 1.00,
                          ),
                        ),
                      ),*/
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: getPadding(
                  top: 27,
                  right: 0,
                  bottom: 27,
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 13.0,
                ),
              ),
              HorizontalSpace(width: 16),
            ],
          ),
        ],
      ),
    ) /*Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      width: MediaQuery.of(context).size.width * 0.70,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: */ /*CachedNetworkImage(
                fit: BoxFit.cover,

                imageUrl:'${ApiUrl.imageUrl}${sportsData.sportImg}',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),*/ /*
                    sportsData.image == ""
                        ? Image.asset(
                            'assets/new-home-gym.png',
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          )
                        : Image.network(
                            '${sportsData.image}',

                            fit: BoxFit.contain,
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
    )*/
        ;
  }

  Widget providersItems(Providers user) {
    return Container(
      margin: getMargin(
        top: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            7.71,
          ),
        ),
        border: Border.all(
          color: AppColor.borderGrey,
          width: getHorizontalSize(
            0.96,
          ),
        ),
      ),
      padding: getPadding(
        left: 0,
        right: 0,
      ),
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
                HorizontalSpace(width: 7),
                Container(
                    height: getVerticalSize(53),
                    width: getHorizontalSize(53),
                    padding: getPadding(all: 8),
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius:
                            BorderRadius.circular(getHorizontalSize(8))),
                    child: user.userImage == ""
                        ? Image.asset(
                            'assets/new-home-gym.png',
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
                HorizontalSpace(width: 16),
                Container(
                  margin: getMargin(
                    left: 0,
                    top: 13,
                    bottom: 9,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        user.serviceProvider ?? '',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: getFontSize(
                            15.418182373046875,
                          ),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 1.00,
                        ),
                      ),
                      VerticalSpace(height: 8),
                      /*  Padding(
                        padding: getPadding(
                          right: 0,
                        ),
                        child: Text(
                          "${categoryList[index].numOfWorkouts.toString()} workouts",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color:
                            ColorConstant.bluegray800,
                            fontSize: getFontSize(
                              13.490909576416016,
                            ),
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w400,
                            height: 1.00,
                          ),
                        ),
                      ),*/
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: getPadding(
                  top: 27,
                  right: 0,
                  bottom: 27,
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 13.0,
                ),
              ),
              HorizontalSpace(width: 16),
            ],
          ),
        ],
      ),
    ) /* Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      width: MediaQuery.of(context).size.width * 0.70,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: */ /*CachedNetworkImage(
                fit: BoxFit.cover,

                imageUrl:'${ApiUrl.imageUrl}${sportsData.sportImg}',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),*/ /*
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
    )*/
        ;
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

  Widget searchField() {
    return  Container(
      width: 344,
      height: 47,
      alignment: Alignment.centerLeft,
      margin: getMargin(
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        focusNode: FocusNode(),
        controller: searchController,
        textAlignVertical: TextAlignVertical.center,
        onChanged: (value) => _runFilter(value),
        onSubmitted: (value) {},
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(
            left: 5,
            top: 0,
            right: 14,
            bottom: 5,
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          //hintText: 'searchByName'.tr,
          hintText: "Search by name",

          prefixIcon: Padding(
            padding: EdgeInsets.all(12),
            child: Icon(Icons.search),
          ),
        ),
      ),
    );
  }

  Widget categorySearchField() {
    return Container(
      width: 344,
      height: 47,
      alignment: Alignment.centerLeft,
      margin: getMargin(
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        focusNode: FocusNode(),
        controller: searchController,
        textAlignVertical: TextAlignVertical.center,
        onChanged: (value) => categoryrFilter(value),
        onSubmitted: (value) {},
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(
            left: 5,
            top: 0,
            right: 14,
            bottom: 5,
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          //hintText: 'searchByName'.tr,
          hintText: "Search by name",

          prefixIcon: Padding(
            padding: EdgeInsets.all(12),
            child: Icon(Icons.search),
          ),
        ),
      ),
    );
  }

  Widget exerciseSearchField() {
    return  Container(
      width: 344,
      height: 47,
      alignment: Alignment.centerLeft,
      margin: getMargin(
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        focusNode: FocusNode(),
        controller: searchController,
        textAlignVertical: TextAlignVertical.center,
        onChanged: (value) => _runExerciseFilter(value),
        onSubmitted: (value) {},
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(
            left: 5,
            top: 0,
            right: 14,
            bottom: 5,
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          //hintText: 'searchByName'.tr,
          hintText: "Search by name",

          prefixIcon: Padding(
            padding: EdgeInsets.all(12),
            child: Icon(Icons.search),
          ),
        ),
      ),
    );
  }

  void _runFilter(String enteredKeyword) {
    List<Providers>? results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = usersList;
    } else {
      results = usersList!
          .where((store) => store.serviceProvider!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      searchProviderList = results;
    });
  }

  void _runExerciseFilter(String enteredKeyword) {
    List<ServiceItem>? results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = servicesLists;
    } else {
      results = servicesLists!
          .where((store) => store.serviceTitle!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      searchExerciseList = results;
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
