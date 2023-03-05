import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:get/get.dart';

class SOS extends StatefulWidget {
  const SOS({super.key});

  @override
  State<SOS> createState() => _SOSState();
}

class _SOSState extends State<SOS> {
  _callNumber() async {
    const number = '198'; //set the number here
    bool res = await FlutterPhoneDirectCaller.callNumber(number) as bool;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SOS'),
        elevation: 0,
      ),
      body: Row(
        children: [
          ElevatedButton(
            onPressed: () async {
              // Navigator.pop(context);
              await _callNumber();
            },
            child: Text('Call'),
          ),
          ElevatedButton(
            onPressed: () async {
              // Navigator.pop(context);
              // await _callNumber();
              try {
                String _result =
                    await sendSMS(message: "Help me!", recipients: ["198"]);
              } catch (e) {
                print(e);
                Get.closeAllSnackbars();
                Get.snackbar("Error", "Error sending SMS");
              }
            },
            child: Text('SMS'),
          ),
        ],
      ),
    );
  }
}
