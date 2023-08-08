import 'package:flexo_app/model/common_response_model.dart';
import 'package:flexo_app/views/service_provider/add_category.dart';
import 'package:flutter/material.dart';

import '../../appbar.dart';
import '../../constant/color_constant.dart';
import '../../constant/math_utils.dart';
import '../../helper_widget.dart';
import '../../model/service_model.dart';
import '../../model/service_provider_list_model.dart';
import '../../model/sports_model.dart';
import '../../services/auth_services.dart';
import '../../storage/get_storage.dart';
import '../../widget/custom_search_view.dart';
import '../../widget/spacing.dart';
import '../dashboard/GymDetailScreen.dart';
import 'package:flexo_app/services/auth_services.dart';


class SeeAllServiceListing extends StatefulWidget {
  SeeAllServiceListing({Key? key}) : super(key: key);

  @override
  State<SeeAllServiceListing> createState() => _SeeAllServiceListingState();
}

class _SeeAllServiceListingState extends State<SeeAllServiceListing> {
  List<ServiceItem>? searchAllServiceList = [];
  TextEditingController searchController = TextEditingController();
  ServiceModel? serviceModel;
  String? userId,catId;
  List<ServiceItem>? serviceItemList = [];
  CommonResponseModel? commonResponseModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
       userId = await Storage().getStoreUserId().toString();
       catId = await Storage().getUserCategoryId().toString();
      await serviceList(userId.toString(), catId.toString()).then((value) {
        serviceItemList = value.services;
        searchAllServiceList = serviceItemList;
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
            title: Text(
              "Your Services",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize: getFontSize(
                  24.008163452148438,
                ),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 1.00,
              ),
            ),

            centerTitle: true,
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

              /* widget.listingType == "Categories"
                  ? categorySearchField()
                  : searchField(),*/
              SizedBox(
                height: 20,
              ),
              serviceUsers()
            ],
          ),
        ),
      ),
    ));
  }

  Widget serviceUsers() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: searchAllServiceList?.length,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return searchAllServiceList?.length == 0
              ? Center(
                  child: Text(
                    'No record found',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                )
              : serviceItems(searchAllServiceList![index]);
        });
  }

  Widget serviceItems(ServiceItem serviceItem) {
    return InkWell(
      onTap: (){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddCategory(serviceName: serviceItem.serviceTitle??"", price: serviceItem.price ??'',
            description: serviceItem.description ?? '',comingFrom: 'FromServiceList',serviceId: serviceItem.serviceId ??'',catId: serviceItem.categoryId ?? '',)));
      },
      child: Container(
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
                          serviceItem.serviceTitle ?? '',
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
                        Padding(
                          padding: getPadding(
                            right: 0,
                          ),
                          child: Text(
                            '${'₹'}${serviceItem.price.toString()}',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: AppColor.textGrey,
                              fontSize: getFontSize(
                                13.490909576416016,
                              ),
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w400,
                              height: 1.00,
                            ),
                          ),
                        ),
                        VerticalSpace(height: 8),
                        Padding(
                          padding: getPadding(
                            right: 0,
                          ),
                          child: Text(
                            '${serviceItem.description.toString()}',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: AppColor.textGrey,
                              fontSize: getFontSize(
                                13.490909576416016,
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
            ),
            Row(
              children: [

                Column(
                  children: [
                    Padding(
                      padding: getPadding(
                        top: 6,
                        right: 0,
                        bottom: 16,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 13.0,
                      ),
                    ),

                    InkWell(
                      onTap: (){
                        deleteServiceApiCall(serviceItem.serviceId.toString());
                      },
                      child: Padding(
                        padding: getPadding(
                          top: 2,
                          right: 0,
                          bottom: 4,
                        ),
                        child: Icon(
                          Icons.delete,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                HorizontalSpace(width: 16),
              ],
            ),
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
        style: TextStyle(color: AppColor.textBlack),
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

  void _runFilter(String enteredKeyword) {
    List<ServiceItem>? results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = searchAllServiceList;
    } else {
      results = searchAllServiceList!
          .where((store) => store.serviceTitle!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      searchAllServiceList = results;
    });
  }

  Future<ServiceModel> serviceList(String serviceId, String catId) async {
    HelperWidget.showProgress(context);
    serviceModel = await ApiProvider().getServiceList(serviceId, catId);
    Navigator.pop(context);
    if (serviceModel?.status == true) {
      // HelperWidget.showToast(message: userMatchListModel?.message);
      setState(() {});
    } else if (serviceModel?.status == false) {
      HelperWidget.showToast(message: 'No Service Found');
    }

    return serviceModel!;
  }

  void deleteServiceApiCall(String serviceIdItem) async {
    HelperWidget.showProgress(context);
    commonResponseModel = await ApiProvider().deleteServiceItem(serviceId:serviceIdItem );
    Navigator.pop(context);
    if (commonResponseModel!.status == true) {
      HelperWidget.showToast(message: commonResponseModel!.message);
      await serviceList(userId.toString(), catId.toString()).then((value) {
        serviceItemList = value.services;
        searchAllServiceList = serviceItemList;
      });

    } else if (commonResponseModel!.status == false) {
      HelperWidget.showToast(message: commonResponseModel!.message);
    } else if (commonResponseModel!.status == false) {
      HelperWidget.showToast(message: commonResponseModel!.message);

      print('signupm error messsga e==>${commonResponseModel!.message}');
    }
  }


}
