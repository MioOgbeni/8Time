import 'package:barcode_scan/barcode_scan.dart';
import 'package:eighttime/blocs/work_events_bloc/bloc.dart';
import 'package:eighttime/main.dart';
import 'package:eighttime/pages/main/qr_code/create_qr_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QrCodeScreen extends StatefulWidget {
  QrCodeScreen({Key key}) : super(key: key);

  @override
  _QrCodeScreenState createState() => new _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  bool _successScan;

  @override
  void initState() {
    _successScan = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            Text(
              "QR ",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              "Code",
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 7),
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateQrCode()),
              );
            },
          ),
        ],
      ),
      body: InkWell(
        onTap: scan,
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(
                        _successScan == false ? Icons.photo_camera : Icons
                            .check_circle,
                        color: _successScan == false ? Colors.black.withOpacity(
                            0.09) : primaryColor,
                        size: 200.0,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _successScan == false
                          ? "Click to scan QR code"
                          : "Work successfully started",
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 3),),
                    Text(
                      _successScan == false
                          ? "Click anywhere to scan QR code and start work"
                          : "For new scan click again",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                    ),
                  ],
                ),
              )
            ],
          ),),
      ),
    );
  }

  Future scan() async {
    ScanResult result = await BarcodeScanner.scan();

    if (result != null && result.rawContent.isNotEmpty) {
      print("SCAN CONTENT ***************");
      print(result.rawContent);

      BlocProvider.of<WorkEventsBloc>(context)
          .add(
        AddWorkByActivityEvent(result.rawContent),
      );

      setState(() {
        _successScan = true;
      });
    } else {
      print(result.rawContent);
      setState(() {
        _successScan = false;
      });
    }
  }
}
