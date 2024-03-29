import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_list_issues/enums/enums.dart';
import 'package:flutter_list_issues/globals/global_http.dart';
import 'package:flutter_list_issues/globals/urls.dart';
import '../models/returned_data_model.dart';

class FlutterListIssueRepository {
  Future<ReturnedDataModel> getFlutterIssueListFromApi({
    required int pageNo,
    required int perPage,
  }) async {
    ReturnedDataModel returnedDataModel = ReturnedDataModel(
      status: ReturnedStatus.error,
    );
    try {
      String apiToken = dotenv.env['API_TOKEN']!;
      returnedDataModel = await GlobalHttp(
        uri: Urls.getFlutterIssueListUrl(
          pageNo: pageNo,
          perPage: perPage,
        ),
        httpType: HttpType.get,
        accessToken: apiToken,
      ).fetch();
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
    return returnedDataModel;
  }
}
