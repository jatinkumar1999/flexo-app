import 'package:flexo_app/appbar.dart';
import 'package:flexo_app/helper_widget.dart';
import 'package:flexo_app/model/bookingList_model.dart';
import 'package:flexo_app/services/api_constant.dart';
import 'package:flexo_app/storage/get_storage.dart';
import 'package:flexo_app/views/dashboard/upcomingBooking.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constant/color_constant.dart';
import '../../services/auth_services.dart';
import 'historyBooking.dart';

class BookingListScreen extends StatefulWidget {
  const BookingListScreen({Key? key}) : super(key: key);

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.orangeColor,
            title: Text('Booking List'),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [Tab(text: "Upcoming Bookings"), Tab(text: "History")],
            ),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),

            children: [UpcomingBooking(), PastBooking()],
          ),
        ),
      ),
    );
  }



}
