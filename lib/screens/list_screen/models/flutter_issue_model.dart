class FlutterIssueModel {
  String title;
  String body;
  String authorName;
  String creationDate;
  List<FlutterIssueLabelModel> labels;

  FlutterIssueModel({
    required this.title,
    required this.body,
    required this.authorName,
    required this.creationDate,
    required this.labels,
  });

  factory FlutterIssueModel.fromJson({required Map json}) {
    List<FlutterIssueLabelModel> labels = [];
    if (json.containsKey("labels")) {
      if (json["labels"].isNotEmpty) {
        for (Map labelItem in json["labels"]) {
          labels.add(
            FlutterIssueLabelModel.fromJson(
              json: labelItem,
            ),
          );
        }
      }
    }

    return FlutterIssueModel(
      title: json["title"] ?? '',
      body: json["body"] ?? '',
      authorName: json["user"]["login"] ?? '',
      creationDate: json["created_at"] ?? '',
      labels: labels,
    );
  }
}

class FlutterIssueLabelModel {
  int id;
  String name;
  String labelColor;

  FlutterIssueLabelModel({
    required this.id,
    required this.name,
    required this.labelColor,
  });

  factory FlutterIssueLabelModel.fromJson({required Map json}) {
    return FlutterIssueLabelModel(
      id: json["id"],
      name: json["name"],
      labelColor: json["color"],
    );
  }
}
