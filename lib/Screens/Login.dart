import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/Screens/dashboard.dart';
import 'package:login/Screens/Create_account.dart';
import 'package:login/model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  User user = User("", "", "", "");

  Future<void> save() async {
    var res = await http.post(
      Uri.parse('http://192.168.94.119:8080/signin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        "email": user.email ?? '',
        "password": user.password ?? '',
      }),
    );
    print(res.body);
    if (res.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashBoard(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to log in: ${res.body}"),
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
                      height: 120,
                    ),
                    Text(
                      "Login",
                      style: GoogleFonts.pacifico(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: Color(0xff0466C8), // اللون الأساسي
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            user.password = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter text';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
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
                            if (_formKey.currentState!.validate()) {
                              save();
                            } else {
                              print("Not Ok");
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Color(0xff0466C8), // اللون الأساسي
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            "Login",
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
                            "Don't have an Account? ",
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
                                  builder: (context) => Create_account(),
                                ),
                              );
                            },
                            child: Text(
                              "Create account",
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
