import 'package:flutter/material.dart';
import 'package:flutter_list_issues/screens/list_screen/ui/flutter_list_issue_screen.dart';
import 'package:sizer/sizer.dart';

class SplashScreenUI extends StatefulWidget {
  static const routeName = "splash_screen_ui";
  const SplashScreenUI({super.key});

  @override
  State<SplashScreenUI> createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {
  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.pushNamed(context, FlutterListIssueScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // height: 100.h,
      // width: 100.w,
      backgroundColor: Colors.blueAccent,
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.blueAccent],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )),
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text(
              "Please wait for a moment",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24),
            ),
            SizedBox(
              height: 2.h,
            ),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ]),
        ),
      ),
    );
  }
}
