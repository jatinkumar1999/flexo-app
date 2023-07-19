import 'package:flexo_app/storage/get_storage.dart';
import 'package:flexo_app/views/auth/login_screen.dart';
import 'package:flexo_app/views/auth/welcomeScreen.dart';
import 'package:flexo_app/views/dashboard/sports.dart';
import 'package:flexo_app/views/service_provider/add_category.dart';
import 'package:flutter/material.dart';

import '../constant/color_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    print('getStoreUserId messsga e==>${Storage().getStoreUserId()}');


    Future.delayed(const Duration(seconds: 3), () async {
      // getVerificationData();
      if (await Storage().getStoreUserId() == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
      } else {

        Storage().getStoreStoreMode().toString() ==
            'service_provider' ?   Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AddCategory())):
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SportsScreen(comingFrom: 'Splash')));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
         color:  Colors.white,
        ),
        child: const Center(
            child: Text('Flexiyoo',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColor.orangeColor,
                  fontSize: 35,
                ))),
      ),
    );
  }
}
