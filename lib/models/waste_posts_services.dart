import 'package:location/location.dart';
import 'package:intl/intl.dart';

class WastePostServices {
  var location = Location();
  LocationData locationData;

  //helper function that retrieves the location of the user given permission was granted
  void retrieveLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        return;
      }
    }
    locationData = await location.getLocation();
  }

  //returns string formated current date and day of the week
  String getCurrentDate() {
    var currentDate = DateTime.now();
    var formatter = DateFormat('EEEE, MMM. d');
    return formatter.format(currentDate);
  }
}
