import 'package:geolocator/geolocator.dart';

typedef PositionCallback = Function(Position position);

class GPS {
  isAccesGranted(LocationPermission permission) {
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  Future<bool> requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (isAccesGranted(permission)) {
      return true;
    }
    permission = await Geolocator.checkPermission();
    return isAccesGranted(permission);
  }

  startPositionStream(Function(Position position) callback) async {
    bool permissionGranted = await requestPermission();

    if (!permissionGranted) {
      throw Exception("User did not grant gps perm!");
    }

    Geolocator.getPositionStream().listen(callback);
  }
}
