import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  NetworkInfo(this.connectivity);

  final Connectivity connectivity;

  Future<bool> isConnected() async {
    final res = await connectivity.checkConnectivity();
    if (res == ConnectivityResult.bluetooth || res == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}
