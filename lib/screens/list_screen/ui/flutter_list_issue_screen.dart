
import 'package:flutter/material.dart';
import 'package:flutter_list_issues/globals/utils.dart';
import 'package:flutter_list_issues/screens/list_screen/controller/flutter_issue_list_controller.dart';
import 'package:flutter_list_issues/screens/list_screen/models/flutter_issue_model.dart';
import 'package:flutter_list_issues/screens/list_screen/provider/flutter_issue_list_providers.dart';
import 'package:flutter_list_issues/screens/list_screen/widgets/list_tile_widget.dart';
import 'package:flutter_list_issues/screens/list_screen/widgets/search_bar_label_item_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class FlutterListIssueScreen extends ConsumerStatefulWidget {
  static const routeName = "flutter_list_issue_screen";

  const FlutterListIssueScreen({super.key});

  @override
  ConsumerState<FlutterListIssueScreen> createState() => _FlutterListIssueScreenState();
}

class _FlutterListIssueScreenState extends ConsumerState<FlutterListIssueScreen> {
  late TextEditingController searchController;
  late FlutterIssueListController flutterIssueListController;
  final ScrollController _scrollController = ScrollController();
  final Utils utils = Utils();

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    flutterIssueListController = FlutterIssueListController(context: context, ref: ref);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      flutterIssueListController.getPreparedFlutterIssueList();
    });
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    _scrollController.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      bool loading = ref.read(isLoadingProvider);
      if (!loading) {
        ref.read(isLoadingProvider.notifier).state = true;
      }

      // Load the next batch of items when the user reaches the end of the list
      Future.delayed(const Duration(seconds: 1), () {
        flutterIssueListController.getPreparedFlutterIssueList();
      });
    }
  }

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 3.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: const Text(
              "Issues List",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),

          // ClipRRect(
          //   borderRadius: BorderRadius.circular(15.sp),
          //   child: TextFormField(
          //     controller: searchController,
          //     decoration: InputDecoration(
          //       filled: true,
          //       fillColor: Colors.white,
          //       hintText: "Label",
          //       hintStyle: TextStyle(
          //         fontSize: 11.sp,
          //       ),
          //       border: InputBorder.none,
          //       errorBorder: InputBorder.none,
          //       focusedBorder: InputBorder.none,
          //       disabledBorder: InputBorder.none,
          //       enabledBorder: InputBorder.none,
          //       focusedErrorBorder: InputBorder.none,
          //       prefixIcon: const Icon(
          //         Icons.search,
          //         color: Colors.lightBlueAccent,
          //       ),
          //     ),
          //     onChanged: (val) {
          //       flutterIssueListController.filterList(val);
          //       // ref.read(flutterIssueListProvider.notifier).search(val);
          //     },
          //     onFieldSubmitted: (val) {
          //       flutterIssueListController.filterList(val);
          //       // ref.read(flutterIssueListProvider.notifier).search(val);
          //     },
          //   ),
          // ),

          /// As the requirement is not clear to me, I am commenting out the search bar by user
          /// which will filter the issues
          /// the below widget is a filter container consisting of all available labels
          /// in the repo by which clicking on each label will do the filtering

          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              List<FlutterIssueLabelModel> labels = ref.watch(labelListToFilterProvider);
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.sp),
                  child: Container(
                    height: 6.h,
                    width: 97.w,
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(15.sp)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(
                            Icons.search,
                            color: Colors.lightBlueAccent,
                          ),
                          labels.isNotEmpty
                              ? SizedBox(
                                  height: 6.h,
                                  width: 75.w,
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return SearchBarLabelItemWidget(
                                        labelModel: labels[index],
                                        onTap: () {
                                          flutterIssueListController.filterList(labels[index].name);
                                        },
                                        utils: utils,
                                      );
                                    },
                                    itemCount: labels.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                  ),
                                )
                              : const Text(
                                  "Please wait...",
                                ),
                          InkWell(
                              onTap: () {
                                flutterIssueListController.filterList("");
                              },
                              child: const Icon(
                                Icons.clear,
                                color: Colors.red,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 2.h,
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              List<FlutterIssueModel> flutterIssueList =
                  ref.watch(flutterIssueListToViewProvider);
              List<FlutterIssueModel> flutterIssueToHold =
                  ref.watch(flutterIssueListToHoldProvider);
              bool isLoading = ref.watch(isLoadingProvider);
              bool firstLoading = ref.watch(firstLoadingProvider);
              int pageNo = ref.watch(flutterIssueListPageNoProvider);
              if (firstLoading) {
                return Padding(
                  padding: EdgeInsets.only(top: 15.h),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (flutterIssueList.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 15.h),
                    child: const Text(
                      "No Data Found!",
                    ),
                  ),
                );
              }
              return Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    if (index == flutterIssueList.length && isLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return ListTileWidget(flutterIssueModel: flutterIssueList[index]);
                    }
                  },
                  itemCount: flutterIssueList.length + (isLoading ? 1 : 0),
                  shrinkWrap: true,
                  // primary: false,
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 1.sp,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
