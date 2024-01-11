import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:login_using_hive/controller/login_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final oldPasswordController = TextEditingController();
  String name = '';

  var box = Hive.box('loginBox');

  @override
  void initState() {
    fetchData();
    name = box.get('userName');
    // TODO: implement initState
    super.initState();
  }

  void fetchData() async {
    name = await box.get('userName');
    setState(() {});
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "welcome",
          style: TextStyle(
              fontSize: 35, color: Colors.black, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            editForm(context, _formKey, userNameController, passwordController,
                oldPasswordController);
          },
          child: Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.black),
            child: const Center(
              child: Text(
                "Edit Credentials",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> editForm(
    BuildContext context,
    GlobalKey<FormState> _formKey,
    TextEditingController userNameController,
    TextEditingController passwordController,
    TextEditingController oldPasswordController,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "New Name ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: userNameController,
                decoration: InputDecoration(
                    hintText: "New name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black, width: 2))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a name";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "New Password ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: "New Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Password";
                  } else if (value.length < 6) {
                    return "Password must contain atleast 6 characters";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Old Password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: oldPasswordController,
                decoration: InputDecoration(
                    hintText: "Old Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Password";
                  } else if (value.length < 6) {
                    return "Password must contain atleast 6 characters";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  AuthenticationController.update(
                      userName: userNameController.text.trim(),
                      password: passwordController.text.trim(),
                      oldPassword: oldPasswordController.text.trim(),
                      context: context);
                  userNameController.clear();
                  passwordController.clear();
                  oldPasswordController.clear();
                  Navigator.pop(context);
                  setState(() {});
                  fetchData();
                },
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black),
                  child: const Center(
                    child: Text(
                      "Edit ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
