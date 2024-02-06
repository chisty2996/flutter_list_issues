import 'package:flutter/material.dart';
import 'package:flutter_list_issues/globals/utils.dart';
import 'package:flutter_list_issues/screens/list_screen/models/flutter_issue_model.dart';
import 'package:sizer/sizer.dart';

class SearchBarLabelItemWidget extends StatelessWidget {
  final FlutterIssueLabelModel labelModel;
  final Function() onTap;
  final Utils utils;

  const SearchBarLabelItemWidget({
    super.key,
    required this.labelModel,
    required this.onTap,
    required this.utils,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 2.w),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.sp),
            color: utils.hexStringToColor(labelModel.labelColor),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(5.sp),
              child: Text(
                labelModel.name,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
