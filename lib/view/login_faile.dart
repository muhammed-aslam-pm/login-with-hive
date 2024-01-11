import 'package:flutter/material.dart';
import 'package:login_using_hive/view/loging.dart';

class LoginFailedScreen extends StatefulWidget {
  const LoginFailedScreen({super.key});

  @override
  State<LoginFailedScreen> createState() => _LoginFailedScreenState();
}

class _LoginFailedScreenState extends State<LoginFailedScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        )));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.black,
              child: Icon(
                Icons.cancel_outlined,
                size: 50,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Login Failed!\n Back to Login",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
            )
          ],
        ),
      ),
    );
  }
}
