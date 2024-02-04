import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../enums/enums.dart';

class Alerts {
  final BuildContext context;

  Alerts({required this.context});

  void floatingLoading({String? message}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.sp),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.blueAccent, // Color of the shadow
                    offset: Offset(0, 4), // Offset in the X and Y directions
                    blurRadius: 15, // Spread of the shadow
                  ),
                ],
              ),
              height: 25.w,
              width: 10.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(
                    height: 2.w,
                  ),
                  Padding(
                    padding: EdgeInsets.all(3.sp),
                    child: Text(
                      message ?? "Loading",
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future? showModalWithWidget({required Widget child, bool dismissible = false}) {
    showDialog(
        context: context,
        barrierDismissible: dismissible,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              return dismissible;
            },
            child: Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              child: child,
            ),
          );
        });
    return null;
  }

  void customDialog({
    required AlertType type,
    String? message,
    String? fontFamily,
    String? description,
    String? button1,
    String? button2,
    bool twoButtons = false,
    VoidCallback? onTap1,
    VoidCallback? onTap2,
  }) {
    IconData iconData;
    String defaultMessage;
    Color color;

    if (type == AlertType.success) {
      iconData = Icons.check_circle;
      defaultMessage = "SUCCESS";
      color = Colors.green;
    } else if (type == AlertType.error) {
      iconData = Icons.cancel;
      defaultMessage = "ERROR";
      color = Colors.red;
    } else if (type == AlertType.warning) {
      iconData = Icons.warning;
      defaultMessage = "WARNING";
      color = Colors.yellow;
    } else {
      iconData = Icons.info;
      defaultMessage = "INFO";
      color = Colors.blue;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            backgroundColor: Colors.transparent,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    width: 40.h,
                    padding: EdgeInsets.only(left: 1.5.h, top: 6.w, right: 1.5.h, bottom: 2.5.w),
                    margin: EdgeInsets.only(top: 5.6.w),
                    decoration: BoxDecoration(
                      color:  Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.white, width: 1.5.sp),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.blueAccent, // Color of the shadow
                          offset: Offset(0, 4), // Offset in the X and Y directions
                          blurRadius: 15, // Spread of the shadow
                        ),

                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Icon(
                            iconData,
                            color: color,
                            size: 25.sp,
                          ),
                        ),
                        SizedBox(
                          height: 2.w,
                        ),
                        Text(
                          message ?? defaultMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: fontFamily,
                            color:  Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 2.0.w,
                        ),
                        (description == null)
                            ? const SizedBox()
                            : Flexible(
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    Center(
                                      child: Text(
                                        description,
                                        style: TextStyle(
                                          fontSize: 10.0.sp,
                                          color: Colors.black,
                                          fontFamily: fontFamily,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        SizedBox(
                          height: 2.7.w,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: (twoButtons == false)
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                    // side: BorderSide(color: Colors.white, width: 1.0.sp),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0.sp),
                                    )
                                  ),
                                  onPressed: onTap1 ??
                                      () {
                                        Navigator.pop(context);
                                      },
                                  child: Text(
                                    button1 ?? 'Okay',
                                    style: TextStyle(
                                      fontSize: 8.5.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blueAccent,
                                        // side: BorderSide(color: Colors.white, width: 1.0.sp),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4.0.sp),
                                          ),
                                      ),
                                      onPressed: onTap1 ??
                                          () {
                                            Navigator.pop(context);
                                          },
                                      child: Text(
                                        button1 ?? 'Yes',
                                        style: TextStyle(
                                          fontSize: 8.5.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.0.w,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:  Colors.blueAccent,
                                        // side: BorderSide(color: Colors.white, width: 1.0.sp),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4.0.sp),
                                          )
                                      ),
                                      onPressed: onTap2 ??
                                          () {
                                            Navigator.pop(context);
                                          },
                                      child: Text(
                                        button2 ?? 'No',
                                        style: TextStyle(
                                          fontSize: 8.5.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void snackBar({
    required String massage,
    int duration = 3,
    bool isSuccess = true,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      margin: EdgeInsets.only(bottom: 40.h),
      content: Text(
        massage,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: duration),
      behavior: SnackBarBehavior.floating,
      backgroundColor: isSuccess ? Colors.green : Colors.red,
    ));
  }

}
