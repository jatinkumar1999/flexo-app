import 'package:flexo_app/storage/get_storage.dart';
import 'package:flexo_app/views/auth/login_screen.dart';
import 'package:flexo_app/views/auth/role_screen.dart';
import 'package:flexo_app/views/dashboard/bookingList.dart';
import 'package:flexo_app/views/dashboard/profile.dart';
import 'package:flexo_app/views/dashboard/sports.dart';
import 'package:flexo_app/views/service_provider/add_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constant/color_constant.dart';
import 'helper_widget.dart';

Widget myDrawer(BuildContext context) {
  String email = Storage().getStoreEmail().toString();
  String name = Storage().getStoreName().toString();

  return Drawer(
    child: ListView(
      padding: const EdgeInsets.all(0),
      children: [
        //DrawerHeader
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: AppColor.orangeColor,
          ),
          accountName: Text(name ?? ''),
          accountEmail: Text(email ?? ''),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.orange,
            child: Text(
              HelperWidget.getInitials(string: name, limitTo: 1),
              style: TextStyle(fontSize: 40.0),
            ),
          ),
        ),

        Storage().getStoreStoreMode() == 'service_provider'
            ? ListTile(
                leading: const Icon(Icons.cyclone),
                title: const Text(' Add Service '),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return AddCategory();
                  }), (r) {
                    return false;
                  });
                },
              )
            : ListTile(
                leading: const Icon(Icons.cyclone),
                title: const Text(' Sports '),
                onTap: () {
                  Navigator.pop(context);


                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return SportsScreen(
                      comingFrom: 'Sports',
                    );
                  }));
                },
              ),

        ListTile(
          leading: const Icon(Icons.person),
          title: const Text(' My Profile '),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return ProfileScreen();
            }));
          },
        ),
        ListTile(
          leading: const Icon(Icons.list_alt),
          title: const Text(' Bookings '),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return BookingListScreen();
            }));
          },
        ),
        /*   ListTile(
          leading: const Icon(Icons.privacy_tip_outlined),
          title: const Text(' Privacy Policy '),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.terminal_sharp),
          title: const Text(' Terms & Conditions '),
          onTap: () {
            Navigator.pop(context);
          },
        ),*/
        /*  ListTile(
          leading: const Icon(Icons.edit),
          title: const Text(' Edit Profile '),
          onTap: () {
            Navigator.pop(context);
          },
        ),*/
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('LogOut'),
          onTap: () {
            Storage().clearLocalDB();
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return RoleScreen();
            }), (r) {
              return false;
            });
          },
        ),
      ],
    ),
  );
}
