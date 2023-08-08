import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flexo_app/appbar.dart';
import 'package:flexo_app/model/register_model.dart';
import 'package:flexo_app/services/api_constant.dart';
import 'package:flexo_app/storage/get_storage.dart';
import 'package:flexo_app/views/auth/payment_screen.dart';
import 'package:flexo_app/views/dashboard/sports.dart';
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';

import '../../constant/color_constant.dart';
import '../../constant/math_utils.dart';
import '../../helper_widget.dart';
import '../../model/common_response_model.dart';
import '../../model/profile_model.dart';
import '../../model/service_model.dart';
import '../../model/sports_model.dart';
import '../../model/time_slot_model.dart';
import '../../services/auth_services.dart';

class GymDetailScreen extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final String categoryId;

  const GymDetailScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.image,
    required this.categoryId,
  }) : super(key: key);

  @override
  State<GymDetailScreen> createState() => _GymDetailScreenState();
}

class _GymDetailScreenState extends State<GymDetailScreen> {
  ServiceModel? serviceModel;
  TimeSlotModel? timeSlotModel;
  final List<String> imgList = [''];
  String? _dropDownValue;
  String? _dropDownValue2;
  List<ServiceItem>? serviceItem;
  String? selectedServiceId;
  String? selectedCategoryId;
  String? selectedTimeSlotId;
  String? selectedPriceValue;
  String? selectedProvider;
  List<TimeSlot>? timeSlotList;
  ScrollController _controller = ScrollController();
  ProfileModel? profileModel;

  Token? paymentToken;
  PaymentMethod? _paymentMethod;
  String? error;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await serviceList(widget.id.toString(), widget.categoryId).then((value) {
        serviceItem = value.services;
      });
      await timeSlotsList().then((value) {
        timeSlotList = value.results;
      });
      await getProfile().then((value) {});
      imgList.add(widget.image);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.colorWhite,
        title: Text(
          "Details",
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      //   appBar: AppBar(title: Text('Details'),),
      body: Container(
        height: getVerticalSize(
          750.00,
        ),
        width: size.width,
        child: SingleChildScrollView(
          child: Align(
            child: Container(
              margin: getMargin(
                top: 0,
                bottom: 1,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    getHorizontalSize(
                      23.12,
                    ),
                  ),
                  topRight: Radius.circular(
                    getHorizontalSize(
                      23.12,
                    ),
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: getVerticalSize(
                        292.00,
                      ),
                      width: getHorizontalSize(
                        344.00,
                      ),
                      margin: getMargin(
                        left: 15,
                        top: 2,
                        right: 14,
                      ),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 0,
                        margin: EdgeInsets.all(0),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            getHorizontalSize(
                              7.71,
                            ),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: getPadding(
                                  right: 1,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    getHorizontalSize(
                                      7.71,
                                    ),
                                  ),
                                  child: Image.network(
                                   widget.image,
                                    height: getVerticalSize(
                                      292.00,
                                    ),
                                    width: getHorizontalSize(
                                      344.00,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      left: 15,
                      top: 29,
                      right: 15,
                    ),
                    child: Text(
                     widget.name,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getFontSize(
                          26.008264541625977,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 1.00,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: getHorizontalSize(
                        340.00,
                      ),
                      margin: getMargin(
                        left: 15,
                        top: 10,
                        right: 15,
                      ),
                      child: Text(
                        "To further challenge yourself, try widening your stance to perform a sumo squat instead. This variation can add variety to your lower body strength training routine",
                        maxLines: null,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: getFontSize(
                            15.412304878234863,
                          ),
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w400,
                          height: 1.44,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      left: 15,
                      top: 31,
                      right: 15,
                    ),
                    child: Text(
                      "Equipment",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getFontSize(
                          19.265380859375,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 1.00,
                      ),
                    ),
                  ),
                  Container(
                    height: getVerticalSize(
                      77.00,
                    ),
                    width: getHorizontalSize(
                      103.00,
                    ),
                    margin: getMargin(
                      left: 15,
                      top: 16,
                      right: 15,
                    ),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 0,
                      margin: EdgeInsets.all(0),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.grey,
                          width: getHorizontalSize(
                            0.96,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(
                          getHorizontalSize(
                            7.71,
                          ),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: getPadding(
                                top: 1,
                                right: 1,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  getHorizontalSize(
                                    7.71,
                                  ),
                                ),
                                child: Image.network(
                                  widget.image,
                                  height: getVerticalSize(
                                    76.00,
                                  ),
                                  width: getHorizontalSize(
                                    102.00,
                                  ),
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
                      left: 15,
                      top: 11,
                      right: 15,
                    ),
                    child: Text(
                      "2 Dumbells",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getFontSize(
                          15.412304878234863,
                        ),
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w400,
                        height: 1.00,
                      ),
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      left: 15,
                      top: 30,
                      right: 15,
                    ),
                    child: Text(
                      "Exercise technique",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getFontSize(
                          19.265380859375,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 1.00,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: getHorizontalSize(
                        331.00,
                      ),
                      margin: getMargin(
                        left: 15,
                        top: 22,
                        right: 15,
                      ),
                      child: Text(
                        "1. Inhale while pushing your hips back and lowering into a squat position. Keep your core tight, back straight, and knees forward during this movement.\n2. Exhale while returning to the starting position. Focus on keeping your weight evenly distributed throughout your heel and midfoot.",
                        maxLines: null,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: getFontSize(
                            15.412304878234863,
                          ),
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      ),
                    ),
                  ), const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      hint: _dropDownValue == null
                          ? const Text('Select Service')
                          : Text(
                        _dropDownValue!,
                        style: const TextStyle(color: Colors.black),
                      ),
                      isExpanded: true,
                      isDense: true,
                      iconSize: 30.0,
                      style: const TextStyle(color: Colors.black),
                      items: serviceItem
                          ?.map<DropdownMenuItem<ServiceItem>>((ServiceItem value) {
                        return DropdownMenuItem<ServiceItem>(
                          value: value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(value.serviceTitle.toString()),
                              Text("${'₹'}${value.price.toString()}"),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (ServiceItem? value) {
                        setState(
                              () {
                            _dropDownValue = value?.serviceTitle.toString();
                            selectedServiceId = value?.serviceId.toString();
                            selectedPriceValue = value?.price.toString();
                            selectedCategoryId = value?.categoryId.toString();
                          },
                        );
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Text(
                      'Appointment',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      hint: _dropDownValue2 == null
                          ? const Text('Select Time Slot')
                          : Text(
                        _dropDownValue2!,
                        style: TextStyle(color: Colors.black),
                      ),
                      isExpanded: true,
                      isDense: true,
                      iconSize: 30.0,
                      style: TextStyle(color: Colors.black),
                      items: timeSlotList
                          ?.map<DropdownMenuItem<TimeSlot>>((TimeSlot value) {
                        return DropdownMenuItem<TimeSlot>(
                          value: value,
                          child: Text(value.timeSlotValue.toString()),
                        );
                      }).toList(),
                      onChanged: (TimeSlot? val) {
                        setState(
                              () {
                            _dropDownValue2 = val?.timeSlotValue.toString();
                            selectedTimeSlotId = val?.timeSlotId.toString();
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentScreen(
                                comingFrom: 'BookingScreen',
                                catId: selectedCategoryId.toString(),
                                serviceId: selectedServiceId.toString(),
                                timeSlotId: selectedTimeSlotId.toString(),
                                providerId: widget.id,
                              )));
                    },
                    child: Container(
                        margin: getMargin(
                          left: 15,
                          top: 42,
                          right: 14,
                          bottom: 38,
                        ),
                        height: 50,
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: AppColor.orangeColor,
                        ),
                        child: const Text(
                          "Book Appointment",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ) /* SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    width: double.infinity,
                    child: widget.image == ""
                        ? Image.asset(
                            'assets/new-home-gym.png',
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            widget.image,
                            fit: BoxFit.cover,
                            height: 180,
                          )) */ /*CarouselSlider(
                options: CarouselOptions(autoPlay: true),
                items: imgList
                    .map((item) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Container(
                            width: double.infinity,
                            child: Image.network(item, fit: BoxFit.fitHeight),
                          ),
                        ))
                    .toList(),
              ),*/ /*
                ),
            Padding(
              padding: EdgeInsets.only(left: 8.0, top: 12.0),
              child: Text(
                widget.name ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0, top: 8.0),
              child: Text(
                profileModel?.user?.email ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.black),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0, top: 8.0),
              child: Text(
                'Services',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton(
                hint: _dropDownValue == null
                    ? const Text('Select Service')
                    : Text(
                        _dropDownValue!,
                        style: const TextStyle(color: Colors.black),
                      ),
                isExpanded: true,
                isDense: true,
                iconSize: 30.0,
                style: const TextStyle(color: Colors.black),
                items: serviceItem
                    ?.map<DropdownMenuItem<ServiceItem>>((ServiceItem value) {
                  return DropdownMenuItem<ServiceItem>(
                    value: value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(value.serviceTitle.toString()),
                        Text("${'₹'}${value.price.toString()}"),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (ServiceItem? value) {
                  setState(
                    () {
                      _dropDownValue = value?.serviceTitle.toString();
                      selectedServiceId = value?.serviceId.toString();
                      selectedPriceValue = value?.price.toString();
                      selectedCategoryId = value?.categoryId.toString();
                    },
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0, top: 8.0),
              child: Text(
                'Appointment',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton(
                hint: _dropDownValue2 == null
                    ? const Text('Select Time Slot')
                    : Text(
                        _dropDownValue2!,
                        style: TextStyle(color: Colors.black),
                      ),
                isExpanded: true,
                isDense: true,
                iconSize: 30.0,
                style: TextStyle(color: Colors.black),
                items: timeSlotList
                    ?.map<DropdownMenuItem<TimeSlot>>((TimeSlot value) {
                  return DropdownMenuItem<TimeSlot>(
                    value: value,
                    child: Text(value.timeSlotValue.toString()),
                  );
                }).toList(),
                onChanged: (TimeSlot? val) {
                  setState(
                    () {
                      _dropDownValue2 = val?.timeSlotValue.toString();
                      selectedTimeSlotId = val?.timeSlotId.toString();
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            GestureDetector(
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentScreen(
                              comingFrom: 'BookingScreen',
                              catId: selectedCategoryId.toString(),
                              serviceId: selectedServiceId.toString(),
                              timeSlotId: selectedTimeSlotId.toString(),
                              providerId: widget.id,
                            )));
              },
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  height: 50,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColor.orangeColor,
                  ),
                  child: const Text(
                    "Book Appointment",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
            ),
          ],
        ),
      )*/
      ,
    ));
  }

  void setError(dynamic error) {
    HelperWidget.showToast(message: error.toString());

    setState(() {
      error = error.toString();
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

  Future<TimeSlotModel> timeSlotsList() async {
    //HelperWidget.showProgress(context);
    timeSlotModel = await ApiProvider().getTimeSlotsList();
    // Navigator.pop(context);
    if (timeSlotModel?.success == true) {
      // HelperWidget.showToast(message: userMatchListModel?.message);
      //setState(() {});
    } else if (timeSlotModel?.success == false) {
      // HelperWidget.showToast(message: blockUserModel?.message);
    }

    return timeSlotModel!;
  }

  Future<ProfileModel> getProfile() async {
    // HelperWidget.showProgress(context);
    profileModel = await ApiProvider().getUserProfile('');
    //  Navigator.pop(context);
    if (profileModel?.status == true) {
      HelperWidget.showToast(message: profileModel?.message);
      setState(() {});
    } else if (profileModel?.status == false) {
      HelperWidget.showToast(message: profileModel?.message);
    }

    return profileModel!;
  }
}
