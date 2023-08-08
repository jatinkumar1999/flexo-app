
import 'package:flexo_app/views/auth/see_all_listing_screen.dart';
import 'package:flexo_app/views/service_provider/AddGalleryImages.dart';
import 'package:flutter/material.dart';

import '../../constant/color_constant.dart';
import '../../constant/math_utils.dart';
import '../dashboard/profile.dart';
import '../dashboard/sports.dart';
import '../service_provider/add_category.dart';
import '../service_provider/see_all_service_screen.dart';
import 'dashboard.dart';

class ProviderHomeScreen extends StatefulWidget {
  static String id="ProviderHomeScreen";
  const ProviderHomeScreen({ Key? key }) : super(key: key);

  @override
  State<ProviderHomeScreen> createState() => _ProviderHomeScreen();
}

class _ProviderHomeScreen extends State<ProviderHomeScreen> {
   List<Widget> screens=[
     AddCategory(serviceName: '', price: '', description: '',comingFrom: '',serviceId:'',catId:''),
     SeeAllServiceListing(),
     AddGalleryImage(),
     ProfileScreen(),


  ];

  int selectedNavBarIndex=0;
  
  bool pop=false;
  @override
  Widget build(BuildContext context) {
    bool isDark =Theme.of(context).brightness==Brightness.dark;
    return Scaffold(
     bottomNavigationBar: BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
     showSelectedLabels: true,
     showUnselectedLabels: true,
      
      selectedItemColor:AppColor.orangeColor ,
      unselectedItemColor:AppColor.textGrey ,
  
      
        selectedLabelStyle: TextStyle(
          color: AppColor.textGrey,
          fontSize: getFontSize(
            10,
          ),
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(
          color: AppColor.textGrey,
          fontSize: getFontSize(
            10,
          ),
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        currentIndex: selectedNavBarIndex,
        onTap: (index){
          setState(() {
            selectedNavBarIndex=index;
          });
         
        },
        items: [

          BottomNavigationBarItem(

            icon: Image.asset('assets/inActiveHome.png',
              width: getHorizontalSize(24),
              height: getVerticalSize(24),
            ),
            activeIcon: Image.asset('assets/activeHome.png',
              width: getHorizontalSize(24),
              height: getVerticalSize(24),
              color: AppColor.orangeColor,
            ),
            label: "Add Service",


          ),
         BottomNavigationBarItem(icon: Image.asset('assets/inActive2.png',
           width: getHorizontalSize(24),
            height: getVerticalSize(24),
          ),
              activeIcon:Image.asset('assets/active2.png',
                color: AppColor.orangeColor,

                width: getHorizontalSize(24),
            height: getVerticalSize(24),) ,
              label: "Your Categories"
          ),
          BottomNavigationBarItem(icon: Image.asset('assets/inActive3.png',
           width: getHorizontalSize(24),
            height: getVerticalSize(24),),
              activeIcon: Image.asset('assets/active3.png',
                color: AppColor.orangeColor,

                width: getHorizontalSize(24),
            height: getVerticalSize(24),),
              label: "Add Banner"),

          BottomNavigationBarItem(icon: Image.asset('assets/inActive4.png',
           width: getHorizontalSize(24),
            height: getVerticalSize(24),
         ),
              activeIcon: Image.asset('assets/active4.png',
                color: AppColor.orangeColor,

                width: getHorizontalSize(24),
            height: getVerticalSize(24),),
              label: "Profile"),
        
        ],

      ),
      body:WillPopScope(
        onWillPop: ()async {
        return  (await showDialog(

            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              content: Text(
               "Are you sure",
                style: TextStyle(fontSize: 13,fontFamily: "Poppins"),
              ),
              title: Text(
               "Do you want to exit the app?",
                style: TextStyle(fontSize: 13,fontFamily: "Poppins",fontWeight: FontWeight.w500),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);

                  },
                  child: Text(
                    "No",
                    style: TextStyle(
                      color: isDark?Colors.white:Colors.black,
                      fontWeight: FontWeight.w500,
                       fontSize: 13,fontFamily: "Poppins"),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);

                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(color: Colors.red, fontSize: 13,fontFamily: "Poppins",fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ))
        )??

         false;

        },

        child: screens[selectedNavBarIndex]) ,
      
    );
  }
}