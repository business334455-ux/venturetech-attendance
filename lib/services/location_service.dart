import 'package:geolocator/geolocator.dart';

class LocationService {
  // VentureTech Campuses Coordinates
  static const double sheikhupuraLat = 31.7131;
  static const double sheikhupuraLng = 73.9783;

  static const double hardevLat = 31.6850;
  static const double hardevLng = 74.0120;

  static const double allowedRadiusMeters = 150.0;

  static Future<Map<String, dynamic>> verifyLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return {'valid': false, 'error': 'Location service is disabled'};
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return {'valid': false, 'error': 'Location permission denied'};
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return {'valid': false, 'error': 'Location permission permanently denied'};
    }

    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    double distSheikhupura = Geolocator.distanceBetween(
      pos.latitude,
      pos.longitude,
      sheikhupuraLat,
      sheikhupuraLng,
    );

    double distHardev = Geolocator.distanceBetween(
      pos.latitude,
      pos.longitude,
      hardevLat,
      hardevLng,
    );

    if (distSheikhupura <= allowedRadiusMeters) {
      return {'valid': true, 'branch': 'sheikhupura', 'distance': distSheikhupura};
    } else if (distHardev <= allowedRadiusMeters) {
      return {'valid': true, 'branch': 'hardev', 'distance': distHardev};
    }

    return {
      'valid': false,
      'error': 'Campus se bahar hain. Kiosk / Campus radius ke andar jayein.'
    };
  }
}
