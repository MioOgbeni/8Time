import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QrCodeScreen extends StatefulWidget {
  QrCodeScreen({Key key}) : super(key: key);

  @override
  _QrCodeScreenState createState() => new _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text("QRCodePage")],
        ),
      ),
    );
  }
}
