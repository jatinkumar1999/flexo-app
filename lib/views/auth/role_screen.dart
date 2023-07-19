import 'package:flutter/material.dart';

import '../../constant/color_constant.dart';
import '../../storage/get_storage.dart';
import 'login_screen.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({Key? key}) : super(key: key);

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  List<String> roleList = [
    "Customer",
    "Fitness Studio/service provider"
  ];
  int selectSubscriptionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/download.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Select Role Type",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            const SizedBox(height: 8),
            Text("To better meet your expectations, please select the user mode.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey)),
            const SizedBox(height: 6),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: roleList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return subscription(roleList[index], index);
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  backgroundColor: AppColor.orangeColor,
                  foregroundColor: AppColor.orangeColor,
                ),
                onPressed: () {
                  if(selectSubscriptionIndex== 0){
                    Storage().storeMode('Customer');
                  }else if(selectSubscriptionIndex== 1){
                    Storage().storeMode('service_provider');
                  }else{
                    Storage().storeMode('Customer');
                  }
                  print('Role=====>${Storage().getStoreStoreMode()}');

                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Login()));
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget subscription(a, index) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          selectSubscriptionIndex = index;
          Storage().storeMode(a);
          print('imageList=====>${a}');

          setState(() {});
        },
        child: Container(
          height: 50,
          decoration: selectSubscriptionIndex == index
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: AppColor.orangeColor),
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black),
                ),
          child: Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            width: 24,
                            height: 242,
                            decoration: selectSubscriptionIndex == index
                                ? BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: AppColor.orangeColor, width: 7),
                                  )
                                : BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.grey, width: 7),
                                    color: Colors.white)),
                      ),
                    ),
                    Text(
                      a,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
