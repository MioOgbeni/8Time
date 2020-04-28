import 'package:eighttime/main.dart';
import 'package:eighttime/utils/secret.dart';
import 'package:eighttime/utils/secret_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';


class LocationSelect extends StatefulWidget {
  LatLng mapInitialPosition;

  LocationSelect({Key key, this.mapInitialPosition}) : super(key: key);

  @override
  _LocationSelectState createState() => _LocationSelectState();
}

class _LocationSelectState extends State<LocationSelect> {
  @override
  void initState() {
    if (widget.mapInitialPosition == null) {
      widget.mapInitialPosition = LatLng(50.20398, 15.82931);
    }
    super.initState();
  }

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
                "Select ",
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "Location",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        body: FutureBuilder(
            future: SecretLoader(secretPath: "assets/secure.json").load(),
            builder: (BuildContext context, AsyncSnapshot<Secret> snapshot) {
              if (snapshot.hasData) {
                return PlacePicker(
                  apiKey: snapshot.data.apiKey,
                  onPlacePicked: (PickResult result) {
                    print(snapshot.data.apiKey);
                    Navigator.of(context).pop(result);
                  },
                  enableMapTypeButton: false,
                  pinBuilder: (context, state) {
                    if (state == PinState.Idle) {
                      return Icon(Icons.location_on,
                          color: primaryColor, size: 35);
                    } else {
                      return SpinKitDoubleBounce(
                        color: primaryColor,
                        size: 35.0,
                      );
                    }
                  },
                  selectInitialPosition: true,
                  resizeToAvoidBottomInset: true,
                  automaticallyImplyAppBarLeading: false,
                  initialPosition: widget.mapInitialPosition,
                  useCurrentLocation: false,
                );
              } else {
                return SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                );
              }
            }));
  }
}
