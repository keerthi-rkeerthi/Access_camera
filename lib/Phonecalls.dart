import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const MaterialApp(
      home: PhoneCallScreen(),
    ));

class PhoneCallScreen extends StatelessWidget {
  const PhoneCallScreen({super.key});
  // Phone number to call
  final String phoneNumber = '7094913263';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make a Phone Call'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _launchPhoneCall(phoneNumber);
          },
          child: Text('Call $phoneNumber'),
        ),
      ),
    );
  }

  // Function to launch the phone call
  _launchPhoneCall(String phoneNumber) async {
    final String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
