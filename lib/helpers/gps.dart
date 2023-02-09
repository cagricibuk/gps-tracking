import 'dart:async';

import 'package:geolocator/geolocator.dart';

typedef PositionCallback = Function(Position position);

class GPS {
  late StreamSubscription<Position> _positionStream;
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

  Future<void> startPositionStream(Function(Position position) callback) async {
    bool permissionGranted = await requestPermission();

    if (!permissionGranted) {
      throw Exception("User did not grant gps perm!");
    }

    _positionStream = Geolocator.getPositionStream(
            locationSettings:
                LocationSettings(accuracy: LocationAccuracy.bestForNavigation))
        .listen(callback);
  }

  Future<void> stopPositionStream() async {
    await _positionStream.cancel();
  }
}
