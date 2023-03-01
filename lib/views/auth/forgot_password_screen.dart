import 'package:flutter/material.dart';

class ForGotPassword extends StatefulWidget {
  ForGotPassword({Key? key}) : super(key: key);

  @override
  _ForGotPasswordState createState() => _ForGotPasswordState();
}

class _ForGotPasswordState extends State<ForGotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/bg.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      height: 200,
                      width: 88,
                      left: 15,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/light-1.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      height: 150,
                      width: 88,
                      left: 115,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/light-1.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      height: 160,
                      width: 88,
                      right: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/clock.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      height: 425,
                      left: 110,
                      child: Container(
                        child: Center(
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5.0,
                            color: Color.fromRGBO(143, 148, 251, 1),
                            offset: Offset(0, 2),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade100))),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "email",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                        height: 50,
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(143, 148, 251, 1),
                            Color.fromRGBO(143, 148, 251, 5),
                          ]),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
