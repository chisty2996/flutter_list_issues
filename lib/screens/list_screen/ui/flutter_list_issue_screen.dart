import 'package:flutter/material.dart';
import 'package:flutter_list_issues/screens/list_screen/models/flutter_issue_model.dart';
import 'package:flutter_list_issues/screens/list_screen/provider/flutter_issue_list_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class FlutterListIssueScreen extends ConsumerStatefulWidget {
  static const routeName = "flutter_list_issue_screen";

  const FlutterListIssueScreen({super.key});

  @override
  ConsumerState<FlutterListIssueScreen> createState() => _FlutterListIssueScreenState();
}

class _FlutterListIssueScreenState extends ConsumerState<FlutterListIssueScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Issues",
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 3.h,
              ),
              const Text(
                "Issues List",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(
                height: 2.h,
              ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  AsyncValue<List<FlutterIssueModel>> asyncIssues =
                      ref.watch(flutterIssueListProvider);
                  return asyncIssues.when(data: (issues) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
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
                                            issues[index].title,
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
                                          convertToShortString(issues[index].body),
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
                                          convertDateFormat(issues[index].creationDate),
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
                                          issues[index].authorName,
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: issues[index]
                                      .labels
                                      .map(
                                        (e) => Padding(
                                          padding: EdgeInsets.only(right: 2.w),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15.sp),
                                              color: hexStringToColor(e.labelColor),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(5.sp),
                                                child: Text(
                                                  e.name,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: issues.length,
                      shrinkWrap: true,
                      primary: false,
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 1.sp,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                        );
                      },
                    );
                  }, error: (e, s) {
                    return Center(
                      child: SizedBox(
                        width: 80.w,
                        child: Text(e.toString()),
                      ),
                    );
                  }, loading: () {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  String convertToShortString(String inputString) {
    if (inputString.length <= 25) {
      return inputString; // No need to convert, return the original string.
    } else {
      return '${inputString.substring(0, 22)}...'; // Clip the string and add "..." at the end.
    }
  }

  Color hexStringToColor(String hexColor) {
    // Remove the '#' character if it exists
    hexColor = hexColor.replaceAll("#", "");

    // Parse the hexadecimal color string to an integer
    int hexValue = int.parse(hexColor, radix: 16);

    // Create a Color object
    return Color(hexValue | 0xFF000000);
  }

  String convertDateFormat(String originalDateString) {
    if (originalDateString.isNotEmpty) {
      try {
        // Parse the original date string to DateTime
        DateTime originalDate = DateTime.parse(originalDateString);

        // Format the date using the intl package
        String formattedDateString = DateFormat('MM/dd/yyyy').format(originalDate);

        return formattedDateString;
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
      }
    }
    return '';
  }
}
