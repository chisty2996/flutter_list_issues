import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../enums/enums.dart';

class Alerts {
  final BuildContext context;

  Alerts({required this.context});

  void snackBar({
    required String massage,
    int duration = 3,
    bool isSuccess = true,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: EdgeInsets.only(
          bottom: 5.h,
        ),
        content: Text(
          massage,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        duration: Duration(
          seconds: duration,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      ),
    );
  }
}
