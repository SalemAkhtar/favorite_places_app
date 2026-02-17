import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  LocationInput({super.key});
  @override
  State<StatefulWidget> createState() {
    return _LocationInput();
  }
}

class _LocationInput extends State<LocationInput> {
  Location? _pickedLocation;
  var _isGetingLocation = false;

  void _getcurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      _isGetingLocation = true;
    });
    locationData = await location.getLocation();
    setState(() {
      _isGetingLocation = false;
    });
    print(locationData.longitude);
    print(locationData.latitude);
  }

  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No location choosen',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: Theme.of(context).colorScheme.onBackground,
      ),
    );
    if (_isGetingLocation) {
      previewContent = CircularProgressIndicator();
    }
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).primaryColor.withOpacity(0.2),
            ),
          ),
          height: 170,
          width: double.infinity,

          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getcurrentLocation,
              icon: Icon(Icons.location_on),
              label: Text('Get Current Location'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.map),
              label: Text('Choose On Map'),
            ),
          ],
        ),
      ],
    );
  }
}
