import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_list_issues/routes/route_generator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

//route observer
final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return MaterialApp(
          title: 'Flutter List Issues',
          navigatorObservers: [routeObserver],
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.generateRoute,
          theme: ThemeData(
            scaffoldBackgroundColor: CupertinoColors.systemGrey4,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
        );
      },
    );
  }
}

