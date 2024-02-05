import 'package:flutter/cupertino.dart';
import 'package:flutter_list_issues/screens/list_screen/provider/flutter_issue_list_providers.dart';
import 'package:flutter_list_issues/screens/list_screen/repository/flutter_list_issue_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../enums/enums.dart';
import '../../../globals/widgets/custom_dialog.dart';
import '../models/flutter_issue_model.dart';
import '../models/returned_data_model.dart';

class FlutterIssueListController {
  late BuildContext context;
  late final Alerts _alerts;
  late WidgetRef ref;

  FlutterIssueListController({required this.context, required this.ref})
      : _alerts = Alerts(context: context);

  final FlutterListIssueRepository _flutterListIssueRepository = FlutterListIssueRepository();

  Future<void> getPreparedFlutterIssueList() async {
    List<FlutterIssueModel> flutterIssueList = [];
    List<FlutterIssueModel> flutterIssueListToView = ref.read(flutterIssueListToViewProvider);
    int pageNo = ref.read(flutterIssueListPageNoProvider);
    int perPage = ref.read(flutterIssueListPerPageProvider);
    bool loading = ref.read(isLoadingProvider);
    if (!loading) {
      ref.read(isLoadingProvider.notifier).state = true;
    }

    try {
      ReturnedDataModel returnedDataModel =
          await _flutterListIssueRepository.getFlutterIssueListFromApi(
        pageNo: pageNo,
        perPage: perPage,
      );
      if (returnedDataModel.status == ReturnedStatus.success) {
        _alerts.snackBar(
          massage: "Data fetched successfully!",
          isSuccess: true,
        );
        List jsonResponse = returnedDataModel.data;
        if (jsonResponse.isNotEmpty) {
          for (var issueItem in jsonResponse) {
            flutterIssueList.add(
              FlutterIssueModel.fromJson(json: issueItem),
            );
          }
          flutterIssueListToView.addAll(flutterIssueList);
          List<FlutterIssueLabelModel> labels = ref.read(labelListToFilterProvider);
          List<FlutterIssueLabelModel> newLabel = [];
          for (FlutterIssueModel issueModel in flutterIssueListToView) {
            if (issueModel.labels.isNotEmpty) {
              for (FlutterIssueLabelModel label in issueModel.labels) {
                if (!labels.contains(label)) {
                  newLabel.add(label);
                }
              }
            }
          }
          labels.addAll(newLabel);
          ref.read(labelListToFilterProvider.notifier).state = [...labels];
          ref.read(flutterIssueListToViewProvider.notifier).state = [...flutterIssueListToView];
          ref.read(flutterIssueListToHoldProvider.notifier).state = [...flutterIssueListToView];
          ref.read(flutterIssueListPageNoProvider.notifier).state++;
          ref.read(isLoadingProvider.notifier).state = false;
          ref.read(firstLoadingProvider.notifier).state = false;
        }
      } else {
        ref.read(isLoadingProvider.notifier).state = false;
        ref.read(firstLoadingProvider.notifier).state = false;
        _alerts.snackBar(
          massage: returnedDataModel.errorMessage.toString(),
          isSuccess: false,
        );
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

  void filterList(String key) {
    List<FlutterIssueModel> currentList = ref.read(flutterIssueListToHoldProvider);

    if (key.isEmpty) {
      ref.read(flutterIssueListToViewProvider.notifier).state = [...currentList];
      return;
    }

    List<FlutterIssueModel> filteredList = [];

    for (FlutterIssueModel issue in currentList) {
      if (issue.labels.isNotEmpty) {
        for (FlutterIssueLabelModel label in issue.labels) {
          if (label.name.toLowerCase().contains(key.toLowerCase())) {
            filteredList.add(issue);
          }
        }
      }
    }

    ref.read(flutterIssueListToViewProvider.notifier).state = [...filteredList];
  }
}
