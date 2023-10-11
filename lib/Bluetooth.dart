import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BluetoothScanScreen(),
    );
  }
}

class BluetoothScanScreen extends StatefulWidget {
  @override
  _BluetoothScanScreenState createState() => _BluetoothScanScreenState();
}

class _BluetoothScanScreenState extends State<BluetoothScanScreen> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devices = [];

  @override
  void initState() {
    super.initState();
    // Start scanning for nearby Bluetooth devices
    flutterBlue.scanResults.listen((scanResult) {
      for (ScanResult result in scanResult) {
        if (!devices.contains(result.device)) {
          setState(() {
            devices.add(result.device);
          });
        }
      }
    });

    // Start scanning
    flutterBlue.startScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Scan Example'),
      ),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(devices[index].name),
            subtitle: Text(devices[index].id.id.toString()),
            onTap: () {
              // Connect to the selected Bluetooth device and perform actions
              // You can add your Bluetooth-related code here
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // Stop scanning when the screen is disposed (e.g., when navigating away)
    flutterBlue.stopScan();
  }
}
