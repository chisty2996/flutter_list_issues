import 'package:flutter/material.dart';
import 'package:flutter_list_issues/globals/utils.dart';
import 'package:flutter_list_issues/screens/list_screen/models/flutter_issue_model.dart';
import 'package:sizer/sizer.dart';

class ListTileWidget extends StatefulWidget {
  final FlutterIssueModel flutterIssueModel;
  const ListTileWidget({super.key, required this.flutterIssueModel});

  @override
  State<ListTileWidget> createState() => _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget> {
  final Utils utils = Utils();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 50.w,
                      child: Text(
                        widget.flutterIssueModel.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    Text(
                      utils.convertToShortString(widget.flutterIssueModel.body),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      utils.convertDateFormat(widget.flutterIssueModel.creationDate),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    Text(
                      widget.flutterIssueModel.authorName,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            SizedBox(
              width: 80.w,
              height: 5.h,
              child: ListView.builder(
                itemBuilder: (context, index1) {
                  return Padding(
                    padding: EdgeInsets.only(right: 2.w),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.sp),
                        color: utils.hexStringToColor(widget.flutterIssueModel.labels[index1].labelColor),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(5.sp),
                          child: Text(
                            widget.flutterIssueModel.labels[index1].name,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: widget.flutterIssueModel.labels.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
