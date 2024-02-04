import 'package:flutter_list_issues/screens/list_screen/models/flutter_issue_model.dart';
import 'package:flutter_list_issues/screens/list_screen/service/flutter_list_issue_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlutterIssueListNotifier extends StateNotifier<AsyncValue<List<FlutterIssueModel>>> {
  List<FlutterIssueModel> issueList = [];

  FlutterIssueListNotifier({required int pageNo, required int perPage})
      : super(const AsyncLoading()) {
    init(
      pageNo: pageNo,
      perPage: perPage,
    );
  }

  final FlutterListIssueService _flutterListIssueService = FlutterListIssueService();

  void init({
    required int pageNo,
    required int perPage,
  }) async {
    issueList = await _flutterListIssueService.getPreparedFlutterIssueList(
      pageNo: pageNo,
      perPage: perPage,
    );
    state = AsyncData(issueList);
  }

  void search(String key){
    if(key.isEmpty){
      state = AsyncData([...issueList]);
      return;
    }

    List<FlutterIssueModel> filteredList = [];
    for(FlutterIssueModel issue in issueList){
      if(issue.labels.isNotEmpty){
        for(FlutterIssueLabelModel label in issue.labels){
          if(label.name.toLowerCase().contains(key.toLowerCase())){
            filteredList.add(issue);
          }
        }
      }
      else{
        state = AsyncData([...issueList]);
        return;
      }
    }

    state = AsyncData([...filteredList]);
  }
}
