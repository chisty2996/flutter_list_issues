class Urls {
  Urls._();

  static getFlutterIssueListUrl({
    required int pageNo,
    required int perPage,
  }) =>
      "https://api.github.com/repos/flutter/flutter/issues?per_page=$perPage&page=$pageNo";
}
