import 'dart:typed_data';
import 'dart:ui';

import 'package:eighttime/activities_repository.dart';
import 'package:eighttime/main.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ignore: must_be_immutable
class GeneratedQr extends StatefulWidget {
  Activity activity;

  GeneratedQr({Key key, @required this.activity}) : super(key: key);

  @override
  _GeneratedQrState createState() => new _GeneratedQrState();
}

class _GeneratedQrState extends State<GeneratedQr> {
  GlobalKey qrImageKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          title: Row(
            children: <Widget>[
              Text(
                "Generated ",
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "QR",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        body: InkWell(
            onTap: _captureAndSharePng,
            child: Container(
              color: Colors.white,
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
                          SizedBox(
                            width: 270,
                            height: 270,
                            child: RepaintBoundary(
                              key: qrImageKey,
                              child: QrImage(
                                data: widget.activity.documentUid,
                                foregroundColor: primaryColor,
                                backgroundColor: Colors.white,
                                embeddedImage: AssetImage(
                                    "assets/app_icon/eighttime_216_qr.png"),
                                embeddedImageStyle: QrEmbeddedImageStyle(
                                  size: Size(60, 60),
                                ),
                                version: QrVersions.auto,
                                size: 600.0,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "QR code for your activity",
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 3),
                        ),
                        Text(
                          "Click anywhere to save QR code to your galery",
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
              ),
            )));
  }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
          qrImageKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      String activityName = widget.activity.name;

      await Share.file(
          "$activityName QR Image", "image.png", pngBytes, 'image/png');
    } catch (e) {
      print(e.toString());
    }
  }
}
