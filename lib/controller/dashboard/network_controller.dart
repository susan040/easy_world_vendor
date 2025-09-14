import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  var connectivityStatus = Rxn<ConnectivityResult>();

  @override
  void onInit() {
    super.onInit();

    Connectivity().checkConnectivity().then((results) {
      if (results.isNotEmpty) {
        connectivityStatus.value = results.first;
      }
    });

    Connectivity().onConnectivityChanged.listen((results) {
      if (results.isNotEmpty) {
        connectivityStatus.value = results.first;
      }
    });
  }

  bool get isOnline =>
      connectivityStatus.value != null &&
      connectivityStatus.value != ConnectivityResult.none;
}
