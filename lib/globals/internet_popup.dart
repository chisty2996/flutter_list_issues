import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetPopup {
  final Connectivity _connectivity = Connectivity();

  static final InternetPopup _internetPopup = InternetPopup._internal();

  factory InternetPopup() {
    return _internetPopup;
  }

  InternetPopup._internal();

  Future<bool> checkInternet() async {
    bool isConnected = false;
    ConnectivityResult connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      isConnected = await InternetConnectionChecker().hasConnection;
    }
    return isConnected;
  }
}
