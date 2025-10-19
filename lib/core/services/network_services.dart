import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkServices {
  Future<bool> isConnected();
}

class NetworkServicesImpl extends NetworkServices {
  final Connectivity connectivity;

  NetworkServicesImpl({required this.connectivity});

  @override
  Future<bool> isConnected() async {
    final connectivityResult = await connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return Future.value(false);
    }
    return Future.value(true);
  }
}
