// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:fish/controllers/authentication/login_controller.dart';
import 'package:fish/pages/authentication/register_page.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:fish/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:fish/theme.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fish/service/url_api.dart';

import 'package:http/http.dart' as http;

import '../component/login_card_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late SharedPreferences prefs;
  final LoginController controller = Get.put(LoginController());
  @override
  void initState() {
    super.initState();
    initSharedPrefs();
  }

  void initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    inspect(prefs);
  }

  void login() async {
    final response = await http.post(
      Uri.parse(Urls.authentication),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: {
        "username": controller.usernameController.text,
        "password": controller.passwordController.text,
      },
    );
    var data = jsonDecode(response.body);
    // print(response.body);
    if (response.statusCode == 200) {
      var myToken = data['access_token'];
      prefs.setString(
        'token',
        myToken,
      );
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DashboardPage()));
      // print(response.body);
    } else {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Login Error',
                    style: TextStyle(color: Colors.red)),
                content: const Text(
                  'BreederID/Password salah',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: backgroundColor1,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Widget usernameInput() {
    //   return Container(
    //     margin: EdgeInsets.only(
    //         top: defaultSpace, right: defaultMargin, left: defaultMargin),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           'Username',
    //           style: primaryTextStyle.copyWith(
    //             fontSize: 16,
    //             fontWeight: medium,
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 12,
    //         ),
    //         Container(
    //           height: 50,
    //           padding: const EdgeInsets.symmetric(
    //             horizontal: 16,
    //           ),
    //           decoration: BoxDecoration(
    //             color: backgroundColor2,
    //             borderRadius: BorderRadius.circular(12),
    //           ),
    //           child: Center(
    //             child: TextFormField(
    //               style: primaryTextStyle,
    //               controller: controller.usernameController,
    //               decoration: InputDecoration.collapsed(
    //                 hintText: 'ex: 20',
    //                 hintStyle: subtitleTextStyle,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    // Widget passwordInput() {
    //   return Container(
    //     margin: EdgeInsets.only(
    //         top: defaultSpace, right: defaultMargin, left: defaultMargin),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           'Password',
    //           style: primaryTextStyle.copyWith(
    //             fontSize: 16,
    //             fontWeight: medium,
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 12,
    //         ),
    //         Container(
    //           height: 50,
    //           padding: const EdgeInsets.symmetric(
    //             horizontal: 16,
    //           ),
    //           decoration: BoxDecoration(
    //             color: backgroundColor2,
    //             borderRadius: BorderRadius.circular(12),
    //           ),
    //           child: Center(
    //             child: TextFormField(
    //               style: primaryTextStyle,
    //               controller: controller.passwordController,
    //               decoration: InputDecoration.collapsed(
    //                 hintText: '',
    //                 hintStyle: subtitleTextStyle,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    Widget formInput() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultSpace, right: defaultMargin, left: defaultMargin),
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemBuilder: ((context, index) {
            return LoginInputCard(
              loginfunc: login,
            );
          }),
          itemCount: 1,
        ),
      );
    }

    Widget logo() {
      return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 130,
            height: 130,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/logo.png',
                ),
              ),
            ),
          ),
          Text(
            "Assistive Aquaculture Breeding Management",
            textAlign: TextAlign.center,
            style: blueTextStyle.copyWith(
              fontSize: 16,
              fontWeight: bold,
            ),
          ),
          Text(
            "by Aquaculture Tech",
            style: secondaryTextStyle.copyWith(
              fontSize: 14,
              fontWeight: medium,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ]),
      );
    }

    Widget footer() {
      return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Login",
            style: whiteTextStyle.copyWith(
              fontSize: 24,
              fontWeight: bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Belum punya akun?",
                style: secondaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()));
                },
                child: Text(
                  'Register',
                  style: blueTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ]),
      );
    }

    // Widget submitButton() {
    //   return Container(
    //     height: 50,
    //     width: double.infinity,
    //     margin: EdgeInsets.only(
    //         top: defaultSpace * 3, right: defaultMargin, left: defaultMargin),
    //     child: TextButton(
    //       onPressed: () {
    //         // Get.back();
    //         login();
    //         // controller.getWeek();
    //       },
    //       style: TextButton.styleFrom(
    //         backgroundColor: primaryColor,
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(12),
    //         ),
    //       ),
    //       child: Text(
    //         'Submit',
    //         style: primaryTextStyle.copyWith(
    //           fontSize: 16,
    //           fontWeight: medium,
    //         ),
    //       ),
    //     ),
    //   );
    // }

    return Obx(() {
      if (controller.isLoading.value == false) {
        return Scaffold(
          backgroundColor: backgroundColor2,
          body: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              logo(),
              formInput(),
              const SizedBox(
                height: 16,
              ),
              footer(),
              // submitButton(),
              const SizedBox(
                height: 8,
              )
            ],
          ),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(
            color: secondaryColor,
          ),
        );
      }
    });
  }
}
