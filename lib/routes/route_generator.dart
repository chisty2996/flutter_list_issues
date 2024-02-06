import 'package:flutter/material.dart';
import 'package:flutter_list_issues/screens/list_screen/ui/flutter_list_issue_screen.dart';
import 'package:flutter_list_issues/screens/splash_screen/ui/splash_screen.dart';

class RouteGenerator{

  static Route<dynamic> generateRoute(RouteSettings settings){

    switch(settings.name) {
      case FlutterListIssueScreen.routeName:
        return MaterialPageRoute(builder: (_) => const FlutterListIssueScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreenUI());
    }
  }
}