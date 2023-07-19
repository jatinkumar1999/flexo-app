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
      appBar: MyAppBarPage(title: 'Detail'),
      body: SingleChildScrollView(
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
                          )) /*CarouselSlider(
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
              ),*/
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
      ),
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
      setState(() {});
    } else if (timeSlotModel?.success == false) {
      // HelperWidget.showToast(message: blockUserModel?.message);
    }

    return timeSlotModel!;
  }

  Future<ProfileModel> getProfile() async {
    // HelperWidget.showProgress(context);
    profileModel = await ApiProvider().getUserProfile(widget.id);
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
