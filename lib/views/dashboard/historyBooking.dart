import 'package:flexo_app/helper_widget.dart';
import 'package:flexo_app/model/bookingList_model.dart';
import 'package:flexo_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../storage/get_storage.dart';

class PastBooking extends StatefulWidget {
  const PastBooking({Key? key}) : super(key: key);

  @override
  State<PastBooking> createState() => _PastBookingState();
}

class _PastBookingState extends State<PastBooking> {
  List<BookingItem>? PastBookingItem = [];
  String? imageUrl;
  BookingListModel? bookingListModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await bookAppointmentList('past').then((value) {
        PastBookingItem = value.results;
        print('upcomgLength=====>${PastBookingItem!.length}');
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: PastBookingItem?.length == 0
                ? Center(
                    child: Text(
                      'No record found',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                  )
                : ListView.builder(
                    itemCount: PastBookingItem?.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return upcomingItem(PastBookingItem![index]);
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
                      'assets/placeHolderIg.png',
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
                      SizedBox(
                        width: 150.0,
                        child: Text(
                          ' ${bookingItem.serviceTitle ?? ''}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: null,
                          softWrap: false,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black),
                        ),
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
    if (bookingListModel?.success == true) {
      imageUrl = bookingListModel?.images;

      // HelperWidget.showToast(message: bookingListModel.message);
      setState(() {});
    } else if (bookingListModel?.success == false) {
      // HelperWidget.showToast(message: blockUserModel?.message);
    }

    return bookingListModel!;
  }
}
