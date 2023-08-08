import 'package:flutter/material.dart';

import '../../constant/color_constant.dart';
import '../../constant/math_utils.dart';
import '../../model/title_subtitle_model.dart';
import '../../storage/get_storage.dart';
import 'login_screen.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({Key? key}) : super(key: key);

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {

  int selectedIndex=0;
  List<TitleSubtitleModel> levelList=[
    TitleSubtitleModel(title: "Customer",subtitle: 'I want to start training'),
    TitleSubtitleModel(title: "Service Provider",subtitle: 'I train 1-2 times a week'),

  ];



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
                padding: EdgeInsets.only(top: 16),
                itemCount: levelList.length,
                shrinkWrap: true,

                itemBuilder: (context,index){
                  return subscription(index) ;

                }),
            const SizedBox(height: 18),
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
                  if(selectedIndex== 0){
                    Storage().storeMode('Customer');
                  }else if(selectedIndex== 1){
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

  Widget subscription(index) {
    return Container(
      width: double.infinity,
      margin:  EdgeInsets.only(
        left: 14,
        top: 15,
        right: 14,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            7.70,
          ),
        ),
        border: Border.all(
          color:selectedIndex==index? AppColor.orangeColor: AppColor.textGrey,
          width: getHorizontalSize(
            0.96,
          ),
        ),
      ),
      child: InkWell(
        onTap: (){
          setState(() {
            selectedIndex = index;
            Storage().storeMode( levelList[index].title);
            print('imageList=====>${levelList[index].title}');

            setState(() {});

          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: getPadding(
                left: 23,
                top: 28,
                right: 23,
              ),
              child: Text(
                levelList[index].title,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColor.textBlack,
                  fontSize: getFontSize(
                    15.396379470825195,
                  ),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 1.00,
                ),
              ),
            ),
            Padding(
              padding: getPadding(
                left: 23,
                top: 7,
                right: 23,
                bottom: 25,
              ),
              child: Text(
                levelList[index].subtitle,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColor.textBlack,
                  fontSize: getFontSize(
                    13.471831321716309,
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
    );
  }
}
