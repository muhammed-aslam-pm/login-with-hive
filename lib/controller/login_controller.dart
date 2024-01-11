import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:login_using_hive/view/home-screen.dart';
import 'package:login_using_hive/view/login_faile.dart';
import 'package:login_using_hive/view/register_success.dart';

class AuthenticationController {
  static register(
      {required String userName,
      required String password,
      required BuildContext context}) {
    var box = Hive.box('loginBox');

    box.put('userName', userName);
    box.put('password', password);

    print(box.get('userName'));
    print(box.get('password'));
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterSuccessScreen(),
        ));
  }

  static login(
      {required String userName,
      required String password,
      required BuildContext context}) async {
    var box = Hive.box('loginBox');

    final String regName = await box.get('userName');
    final String regPass = await box.get('password');

    if (userName == regName && password == regPass) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginFailedScreen(),
          ));
    }
  }

  static update(
      {required String userName,
      required String password,
      required String oldPassword,
      required BuildContext context}) async {
    var box = Hive.box('loginBox');

    final String regPass = await box.get('password');
    if (oldPassword == regPass) {
      box.put('userName', userName);
      box.put('password', password);

      print(box.get('userName'));
      print(box.get('password'));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Name And Password Updated!"),
        duration: Duration(seconds: 10),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Incorrect password"),
        duration: Duration(seconds: 10),
      ));
    }
  }
}
