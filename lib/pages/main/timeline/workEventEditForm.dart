import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eighttime/blocs/work_events_bloc/bloc.dart';
import 'package:eighttime/main.dart';
import 'package:eighttime/pages/main/location_select.dart';
import 'package:eighttime/pages/main/sliding_up_panel/activities/activities_select.dart';
import 'package:eighttime/utils/date_util.dart';
import 'package:eighttime/work_events_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// ignore: must_be_immutable
class WorkEventEditForm extends StatefulWidget {
  WorkEvent editWorkEvent;

  WorkEventEditForm({Key key, this.editWorkEvent}) : super(key: key);

  @override
  _WorkEventEditFormState createState() => _WorkEventEditFormState();
}

enum ConfirmAction { CANCEL, ACCEPT }

class _WorkEventEditFormState extends State<WorkEventEditForm> {
  Timestamp _date;
  Timestamp _fromTime;
  Timestamp _toTime;
  Activity _activity;
  GeoPoint _geoPoint;

  final _descriptionController = TextEditingController();
  final _activityController = TextEditingController();
  final _locationController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeFromController = TextEditingController();
  final _timeToController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  PanelController _pc = new PanelController();
  Color _cursorColor = primaryColor;

  @override
  void initState() {
    super.initState();

    if (widget.editWorkEvent != null) {
      if (widget.editWorkEvent.date != null) {
        _descriptionController.text = widget.editWorkEvent.description;
      }
    }

    if (widget.editWorkEvent != null) {
      if (widget.editWorkEvent.activity != null) {
        _activity = widget.editWorkEvent.activity;
        _activityController.text = widget.editWorkEvent.activity.name;
      }
    }

    if (widget.editWorkEvent != null) {
      if (widget.editWorkEvent.geoPoint != null) {
        _geoPoint = widget.editWorkEvent.geoPoint;
        _locationController.text = widget.editWorkEvent.address;
      }
    }

    if (widget.editWorkEvent != null) {
      if (widget.editWorkEvent.date != null) {
        _date = widget.editWorkEvent.date;
        _dateController.text = DateUtil.getDayFromDateTime(
            DateUtil.getDateTimeFromTimestamp(widget.editWorkEvent.date));
      }
    } else {
      _date = Timestamp.fromDate(DateUtil.now());
      _dateController.text = DateUtil.getDayFromDateTime(DateUtil.now());
    }

    if (widget.editWorkEvent != null) {
      if (widget.editWorkEvent.fromTime != null) {
        _fromTime = widget.editWorkEvent.fromTime;
        _timeFromController.text = DateUtil.getTimeFromDateTime(
            DateUtil.getDateTimeFromTimestamp(widget.editWorkEvent.fromTime));
      }
    } else {
      _fromTime = Timestamp.fromDate(DateUtil.now());
      _timeFromController.text = DateUtil.getTimeFromDateTime(DateUtil.now());
    }

    if (widget.editWorkEvent != null) {
      if (widget.editWorkEvent.toTime != null) {
        _toTime = widget.editWorkEvent.toTime;
        _timeToController.text = DateUtil.getTimeFromDateTime(
            DateUtil.getDateTimeFromTimestamp(widget.editWorkEvent.toTime));
      }
    }
  }

  Future<ConfirmAction> _deleteAlert(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete this work?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text('Delete cannot be reverted.'),
          actions: <Widget>[
            RaisedButton(
              color: errorColor,
              child: Text(
                'No',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            RaisedButton(
              color: primaryColor,
              child: Text(
                'Yes',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                BlocProvider.of<WorkEventsBloc>(context).add(
                  DeleteWorkEvent(widget.editWorkEvent),
                );
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: Colors.white,
              title: Row(
                children: <Widget>[
                  Text(
                    widget.editWorkEvent != null ? "Edit " : "New ",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    "Work",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              actions: <Widget>[
                Visibility(
                  child: IconButton(
                    padding: EdgeInsets.only(right: 7),
                    icon: Icon(Icons.delete, color: Colors.black),
                    onPressed: () async {
                      final ConfirmAction action = await _deleteAlert(context);
                      if (action == ConfirmAction.ACCEPT) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                  visible: widget.editWorkEvent != null ? true : false,
                ),
              ],
            ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _dateController,
                        cursorColor: _cursorColor,
                        autofocus: false,
                        maxLength: 30,
                        decoration: InputDecoration(
                          counterText: '',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15.0),
                          alignLabelWithHint: true,
                          labelText: "Date",
                          border: OutlineInputBorder(
                            gapPadding: 5,
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                        onTap: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());

                            DateTime selected = await showRoundedDatePicker(
                              context: context,
                              theme: ThemeData(
                                  primaryColor: primaryColor,
                                  accentColor: primaryColor,
                                  primarySwatch: Colors.green),
                              initialDate: DateTime.now(),
                              firstDate: DateTime(DateTime.now().year - 1),
                              lastDate: DateTime(DateTime.now().year + 1),
                              borderRadius: 10,
                            );
                          setState(() {
                            if (selected != null) {
                              _date = Timestamp.fromDate(selected);
                              _dateController.text =
                                  DateUtil.getDayFromDateTime(selected);
                            }
                          });
                        },
                        validator: (val) {
                          if (val.length == 0) {
                            setState(() {
                              _cursorColor = Theme.of(context).errorColor;
                            });
                            return "Cannot be empty";
                          } else {
                            setState(() {
                              _cursorColor = Theme.of(context).primaryColor;
                            });
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(right: 7),
                              child: TextFormField(
                                controller: _timeFromController,
                                cursorColor: _cursorColor,
                                autofocus: false,
                                maxLength: 30,
                                onTap: () async {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  TimeOfDay selected =
                                  await showRoundedTimePicker(
                                    context: context,
                                    theme: ThemeData(
                                        primaryColor: primaryColor,
                                        accentColor: primaryColor,
                                        primarySwatch: Colors.green),
                                    borderRadius: 10,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  setState(() {
                                    if (selected != null) {
                                      final now = DateTime.now();
                                      final datetime = DateTime(
                                          now.year,
                                          now.month,
                                          now.day,
                                          selected.hour,
                                          selected.minute);
                                      _fromTime = Timestamp.fromDate(datetime);
                                      _timeFromController.text =
                                          DateUtil.getTimeFromDateTime(
                                              datetime);
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                  counterText: '',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 15.0),
                                  alignLabelWithHint: true,
                                  labelText: "Time from",
                                  border: OutlineInputBorder(
                                    gapPadding: 5,
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                                validator: (val) {
                                  if (val.length == 0) {
                                    setState(() {
                                      _cursorColor =
                                          Theme.of(context).errorColor;
                                    });
                                    return "Cannot be empty";
                                  } else {
                                    setState(() {
                                      _cursorColor =
                                          Theme.of(context).primaryColor;
                                    });
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(left: 7),
                              child: TextFormField(
                                controller: _timeToController,
                                cursorColor: _cursorColor,
                                autofocus: false,
                                maxLength: 30,
                                onTap: () async {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                    TimeOfDay selected =
                                        await showRoundedTimePicker(
                                      context: context,
                                      theme: ThemeData(
                                          primaryColor: primaryColor,
                                          accentColor: primaryColor,
                                          primarySwatch: Colors.green),
                                      borderRadius: 10,
                                      initialTime: TimeOfDay.now(),
                                    );
                                  setState(() {
                                    if (selected != null) {
                                      final now = DateTime.now();
                                      final datetime = DateTime(
                                          now.year,
                                          now.month,
                                          now.day,
                                          selected.hour,
                                          selected.minute);
                                      _toTime = Timestamp.fromDate(datetime);
                                      _timeToController.text =
                                          DateUtil.getTimeFromDateTime(
                                              datetime);
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                  counterText: '',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 15.0),
                                  alignLabelWithHint: true,
                                  labelText: "Time to",
                                  border: OutlineInputBorder(
                                    gapPadding: 5,
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                                validator: (val) {
                                  if (val.length == 0) {
                                    setState(() {
                                      _cursorColor =
                                          Theme.of(context).errorColor;
                                    });
                                    return "Cannot be empty";
                                  } else {
                                    setState(() {
                                      _cursorColor =
                                          Theme.of(context).primaryColor;
                                    });
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                      TextFormField(
                        controller: _activityController,
                        cursorColor: _cursorColor,
                        autofocus: false,
                        maxLength: 255,
                        decoration: InputDecoration(
                          counterText: '',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15.0),
                          alignLabelWithHint: true,
                          labelText: "Activity",
                          border: OutlineInputBorder(
                            gapPadding: 5,
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                        onTap: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          Activity result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ActivitiesSelect()),
                          );

                          setState(() {
                            if (result != null) {
                              _activity = result;
                              _activityController.text = result.name;
                            }
                          });
                        },
                        validator: (val) {
                          if (val.length == 0) {
                            setState(() {
                              _cursorColor = Theme
                                  .of(context)
                                  .errorColor;
                            });
                            return "Cannot be empty";
                          } else {
                            setState(() {
                              _cursorColor = Theme
                                  .of(context)
                                  .primaryColor;
                            });
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                      TextFormField(
                        controller: _locationController,
                        cursorColor: _cursorColor,
                        autofocus: false,
                        maxLength: 255,
                        decoration: InputDecoration(
                          counterText: '',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15.0),
                          alignLabelWithHint: true,
                          labelText: "Location",
                          border: OutlineInputBorder(
                            gapPadding: 5,
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                        onTap: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());

                          LatLng currentPosition;
                          if (_geoPoint != null) {
                            currentPosition =
                                LatLng(_geoPoint.latitude, _geoPoint.longitude);
                          }

                          PickResult result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                LocationSelect(
                                    mapInitialPosition: currentPosition)),
                          );

                          setState(() {
                            if (result != null) {
                              _geoPoint = GeoPoint(result.geometry.location.lat,
                                  result.geometry.location.lng);
                              _locationController.text =
                                  result.formattedAddress;
                            }
                          });
                        },
                        keyboardType: TextInputType.text,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        cursorColor: _cursorColor,
                        autofocus: false,
                        maxLength: 255,
                        decoration: InputDecoration(
                          counterText: '',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15.0),
                          alignLabelWithHint: true,
                          labelText: "Description",
                          border: OutlineInputBorder(
                            gapPadding: 5,
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                      )
                    ],
                  ),
                )
              ])),
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0),
                    ),
                    textTheme: ButtonTextTheme.primary,
                    onPressed: () {
                      // Validate returns true if the form is valid, otherwise false.
                      if (_formKey.currentState.validate()) {
                        /*
    if (widget.editActivity != null) {
    BlocProvider.of<ActivitiesBloc>(context)
        .add(
    UpdateActivity(widget.editActivity
        .copyWith(
    name: _textController.text,
    icon: IconEnum
        .values[_currentIcon],
    color: ColorEnum
        .values[_currentColor],
    order: widget
        .editActivity.order)),
    );
    } else {
    BlocProvider.of<ActivitiesBloc>(context)
        .add(
    AddActivity(Activity(
    _textController.text,
    IconEnum.values[_currentIcon],
    ColorEnum.values[_currentColor],
    Random().nextInt(80000),
    )),
    );
    }
    
       */
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      widget.editWorkEvent != null
                          ? "Update work"
                          : "Save work",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  )),
            ),
          ),
          SlidingUpPanel(
            controller: _pc,
            backdropEnabled: true,
            backdropOpacity: 0.6,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            maxHeight: MediaQuery.of(context).size.height / 1.8,
            minHeight: 0,
            panel: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Select icon and color"),
              ],
            )),
          )
        ],
      ),
    );
  }
}
