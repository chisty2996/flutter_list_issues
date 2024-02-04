import 'package:flutter_list_issues/screens/list_screen/models/flutter_issue_model.dart';
import 'package:flutter_list_issues/screens/list_screen/provider/flutter_issue_list_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final flutterIssueListPageNoProvider = StateProvider.autoDispose<int>((ref) => 1);
final flutterIssueListPerPageProvider = StateProvider.autoDispose<int>((ref) => 20);

final flutterIssueListProvider =
    StateNotifierProvider.autoDispose<FlutterIssueListNotifier, AsyncValue<List<FlutterIssueModel>>>((ref) {
  int pageNo = ref.watch(flutterIssueListPageNoProvider);
  int perPage = ref.watch(flutterIssueListPerPageProvider);
  return FlutterIssueListNotifier(
    pageNo: pageNo,
    perPage: perPage,
  );
});
