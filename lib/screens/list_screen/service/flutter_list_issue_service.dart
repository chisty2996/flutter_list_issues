import 'package:flutter/cupertino.dart';
import 'package:flutter_list_issues/enums/enums.dart';
import 'package:flutter_list_issues/screens/list_screen/models/flutter_issue_model.dart';
import 'package:flutter_list_issues/screens/list_screen/models/returned_data_model.dart';
import 'package:flutter_list_issues/screens/list_screen/repository/flutter_list_issue_repository.dart';

class FlutterListIssueService {
  final FlutterListIssueRepository _flutterListIssueRepository = FlutterListIssueRepository();

  Future<List<FlutterIssueModel>> getPreparedFlutterIssueList({
    required int pageNo,
    required int perPage,
  }) async {
    List<FlutterIssueModel> flutterIssueList = [];

    try {
      ReturnedDataModel returnedDataModel =
          await _flutterListIssueRepository.getFlutterIssueListFromApi(
        pageNo: pageNo,
        perPage: perPage,
      );
      if (returnedDataModel.status == ReturnedStatus.success) {
        List jsonResponse = returnedDataModel.data;
        if (jsonResponse.isNotEmpty) {
          for (var issueItem in jsonResponse) {
            flutterIssueList.add(
              FlutterIssueModel.fromJson(json: issueItem),
            );
          }
        }
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
    return flutterIssueList;
  }
}
