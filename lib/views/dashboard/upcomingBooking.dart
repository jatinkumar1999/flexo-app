import 'package:flexo_app/helper_widget.dart';
import 'package:flexo_app/model/bookingList_model.dart';
import 'package:flexo_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../storage/get_storage.dart';

class UpcomingBooking extends StatefulWidget {
  const UpcomingBooking({Key? key}) : super(key: key);

  @override
  State<UpcomingBooking> createState() => _UpcomingBookingState();
}

class _UpcomingBookingState extends State<UpcomingBooking> {
  List<BookingItem>? upcomingBookingItem = [];
  String? imageUrl;
  BookingListModel? bookingListModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await bookAppointmentList('upcoming').then((value) {
        upcomingBookingItem = value.results;
        print('upcomgLength=====>${upcomingBookingItem!.length}');
      });
    });

    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body:upcomingBookingItem?.length==0?Center(
      child: Text(
        'No record found',
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.black),
      ),
    ): ListView.builder(
        itemCount: upcomingBookingItem?.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return  upcomingItem(upcomingBookingItem![index]);
        })));
  }

  Widget upcomingItem(BookingItem bookingItem) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            bookingItem.image == ""
                ? ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'assets/new-home-gym.png',
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            )
                : ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  '${imageUrl}${bookingItem.image}',
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4.0),
                  child: Row(
                    children: [
                      Text(
                        'Category Name :',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      Text(
                        '  ${bookingItem.category ?? ''}',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Text(
                        'Service Name :',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      Text(
                        '  ${bookingItem.serviceTitle ?? ''}',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Text(
                        'Time :',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      Text(
                        ' ${bookingItem.timeSlotValue ?? ''}',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Text(
                        'Date :',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      Text(
                        '${DateFormat('dd-MM-yyyy').format(DateTime.parse(bookingItem.dateTime.toString()))}',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<BookingListModel> bookAppointmentList(String type) async {
    var userId = await Storage().getStoreUserId().toString();
    HelperWidget.showProgress(context);
    if (Storage().getStoreStoreMode() == 'customer') {
      bookingListModel = await ApiProvider().getBookingList(
        userId: userId,
        type: type,
      );
    } else {
      bookingListModel = await ApiProvider()
          .getBookingList(type: type, proiderId: userId);
    }
    Navigator.pop(context);
    if (bookingListModel!.success == true) {
      imageUrl = bookingListModel!.images;

      // HelperWidget.showToast(message: bookingListModel.message);
      setState(() {});
    } else if (bookingListModel!.success == false) {
      // HelperWidget.showToast(message: blockUserModel?.message);
    }

    return bookingListModel!;
  }
}
