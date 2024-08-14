import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/Screens/CameraScreen.dart';
import 'package:login/Screens/Login.dart';
import 'package:login/model/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Create_account extends StatefulWidget {
  const Create_account({super.key});

  @override
  State<Create_account> createState() => _Create_accountState();
}

class _Create_accountState extends State<Create_account> {
  final _formKey = GlobalKey<FormState>();
  User user = User("", "", "", "");

  Future<void> createAccount() async {
    var res = await http.post(
      Uri.parse('http://192.168.94.119:8080/signup'), // تأكد من أن المسار صحيح
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        "email": user.email ?? '',
        "password": user.password ?? '',
      }),
    );

    print("Response status: ${res.statusCode}");
    print("Response body: ${res.body}");

    if (res.statusCode == 200) {
      // إذا كانت الاستجابة ناجحة، انتقل إلى صفحة تسجيل الدخول
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    } else {
      // عرض رسالة خطأ للمستخدم في حال فشل عملية التسجيل
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to create account: ${res.body}"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F6F8), // لون الخلفية الكامل
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: SvgPicture.asset(
              'images/top.svg',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 5.3,
              color: Color(0xff0353A4), // لون الصورة العلوية
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 110,
                    ),
                    Text(
                      "Create an account",
                      style: GoogleFonts.pacifico(
                        fontWeight: FontWeight.bold,
                        fontSize: 45,
                        color: Color(0xff0466C8), // اللون الأساسي
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 175,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 5, 5, 5),
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  user.firstName = value;
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter text';
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'First name',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      BorderSide(color: Color(0xff0466C8)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      BorderSide(color: Color(0xff0466C8)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      BorderSide(color: Color(0xffD32F2F)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      BorderSide(color: Color(0xffD32F2F)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 175,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  user.lastName = value;
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter text';
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Last name',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      BorderSide(color: Color(0xff0466C8)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      BorderSide(color: Color(0xff0466C8)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      BorderSide(color: Color(0xffD32F2F)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      BorderSide(color: Color(0xffD32F2F)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            user.email = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter text';
                          } else if (RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return null;
                          } else {
                            return 'Enter valid email';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter Email',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Color(0xff0466C8)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Color(0xff0466C8)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Color(0xffD32F2F)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Color(0xffD32F2F)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Container(
                        height: 50,
                        width: 400,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => CameraScreen(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Color(0xff0466C8), // اللون الأساسي
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            "photo shoot",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Container(
                        height: 50,
                        width: 400,
                        child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              createAccount();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            } else {
                              print("Form not valid");
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Color(0xff0466C8), // اللون الأساسي
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            "Create",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(65, 20, 0, 0),
                      child: Row(
                        children: [
                          Text(
                            "Already have an Account?",
                            style: TextStyle(
                              color: Color(0xff33415C), // اللون الرمادي الداكن
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Color(0xff0466C8), // اللون الأساسي
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
