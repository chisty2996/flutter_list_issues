import 'package:flutter_list_issues/screens/list_screen/models/flutter_issue_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final flutterIssueListPageNoProvider = StateProvider.autoDispose<int>((ref) => 1);
final flutterIssueListPerPageProvider = StateProvider.autoDispose<int>((ref) => 20);
final flutterIssueListToViewProvider = StateProvider.autoDispose<List<FlutterIssueModel>> ((ref) => []);
final flutterIssueListToHoldProvider = StateProvider.autoDispose<List<FlutterIssueModel>> ((ref) => []);
final isLoadingProvider = StateProvider.autoDispose<bool> ((ref) =>true);
final firstLoadingProvider = StateProvider.autoDispose<bool>((ref) => true);
final labelListToFilterProvider = StateProvider.autoDispose<List<FlutterIssueLabelModel>>((ref) => []);
