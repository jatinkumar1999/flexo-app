import 'package:flexo_app/views/auth/forgot_password_screen.dart';
import 'package:flexo_app/views/auth/register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email, password;
  bool clicked = true;
  bool isloading = false;
  final formkey = GlobalKey<FormState>();

  login() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        isloading = true;
      });
      // await AuthServices().signInwithEmailAndPassword(email, password).then(
      //       (value) {
      //     if (value != null) {
      //       HelperMethods.savedUserLoggedInDetails(true);
      //       Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => Home(),
      //         ),
      //       );
      //     }
      //   },
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Container(
            color: Colors.indigo[100],
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    height: 400,
                    decoration: const BoxDecoration(
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
                            decoration: const BoxDecoration(
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
                            decoration: const BoxDecoration(
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
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/clock.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          child: Container(
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35.0,
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
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5.0,
                                color: Color.fromRGBO(143, 148, 251, 1),
                                offset: Offset(0, 2),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Form(
                            key: formkey,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade100))),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      setState(() {
                                        email = value;
                                      });
                                    },
                                    validator: (value) => value!.isEmpty
                                        ? "enter a valid email"
                                        : null,
                                    decoration: const InputDecoration(
                                      hintText: "email",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade100))),
                                  child: TextFormField(
                                    obscureText: clicked,
                                    onChanged: (value) {
                                      setState(() {
                                        password = value;
                                      });
                                    },
                                    validator: (value) => value!.length < 6
                                        ? "enter a 6+ chars password"
                                        : null,
                                    decoration: InputDecoration(
                                      suffixIcon: clicked
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  clicked = false;
                                                  print(clicked);
                                                });
                                              },
                                              child: Icon(
                                                FontAwesomeIcons.eyeSlash,
                                                color: Colors.indigo[400],
                                              ))
                                          : GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  clicked = true;
                                                });
                                              },
                                              child: Icon(
                                                FontAwesomeIcons.eye,
                                                color: Colors.indigo[400],
                                              )),
                                      hintText: "Password",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForGotPassword()));
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                color: Colors.indigo[400],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        GestureDetector(
                          onTap: login,
                          child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                gradient: const LinearGradient(colors: [
                                  Color.fromRGBO(143, 148, 251, 1),
                                  Color.fromRGBO(143, 148, 251, 5),
                                ]),
                              ),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                        ),
                        // const SizedBox(
                        //   height: 20.0,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Container(
                        //       alignment: Alignment.center,
                        //       height: 50,
                        //       width: 50,
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(30.0),
                        //         image: const DecorationImage(
                        //           image: AssetImage('assets/fb.png'),
                        //         ),
                        //       ),
                        //     ),
                        //     const SizedBox(width: 30.0),
                        //     Container(
                        //       alignment: Alignment.center,
                        //       height: 50,
                        //       width: 50,
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(30.0),
                        //         image: const DecorationImage(
                        //           image: AssetImage('assets/gg.png'),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(height: 30),
                        RichText(
                          text: TextSpan(
                              text: "Don\'t have an account ?",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                    text: "Register",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.indigo[400],
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Register()));
                                      }),
                              ]),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
  }
}
