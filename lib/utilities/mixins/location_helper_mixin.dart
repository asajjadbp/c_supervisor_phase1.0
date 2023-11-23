import 'dart:math' show cos, sqrt, asin;

import 'package:location/location.dart';

mixin LocationHelperMixin {
  late final Location _location;
  PermissionStatus? _permissionGranted;
  bool? _serviceEnabled;

  initLocationGPS() async {
    _location = Location();
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }
  }

  getPermission() async {
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  getLocationLatLong() async {
    if (_permissionGranted == PermissionStatus.granted) {
      print('asss');
      print(_location.getLocation());
      return await _location.getLocation();
    } else {
      //which mean no permission enabled
      return null;
    }
  }

  //calculate the distance in km
  //todo  200 m base
  double calculateDistanceInKM(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
