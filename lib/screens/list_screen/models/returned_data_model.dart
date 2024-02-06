
import '../../../enums/enums.dart';

class ReturnedDataModel {
  ReturnedStatus status;
  String? errorMessage;
  dynamic data;

  ReturnedDataModel({required this.status, this.data, this.errorMessage});
}
