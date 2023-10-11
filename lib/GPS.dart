import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LocationScreen(),
    );
  }
}

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String locationMessage = "";

  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    setState(() {
      locationMessage =
          "Latitude: ${position.latitude}\nLongitude: ${position.longitude}\nAltitude: ${position.altitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                getCurrentLocation();
              },
              child: const Text("Get Location"),
            ),
            const SizedBox(height: 20),
            Text(locationMessage),
          ],
        ),
      ),
    );
  }
}
