import 'dart:math';

import 'package:eighttime/activities_repository.dart';
import 'package:eighttime/blocs/activities_bloc/bloc.dart';
import 'package:eighttime/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// ignore: must_be_immutable
class ActivityEditForm extends StatefulWidget {
  Activity editActivity;

  ActivityEditForm({Key key, this.editActivity}) : super(key: key);

  @override
  _ActivityEditFormState createState() => _ActivityEditFormState();
}

enum ConfirmAction { CANCEL, ACCEPT }

class _ActivityEditFormState extends State<ActivityEditForm> {
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  PanelController _pc = new PanelController();
  Color _cursorColor = primaryColor;
  int _currentColor;
  int _currentIcon;

  @override
  void initState() {
    super.initState();

    _textController.text =
        widget.editActivity != null ? widget.editActivity.name : "";
    _currentColor = widget.editActivity != null
        ? widget.editActivity.color.index
        : ColorEnum.red.index;
    _currentIcon = widget.editActivity != null
        ? widget.editActivity.icon.index
        : IconEnum.playArrow.index;
  }

  Future<ConfirmAction> _deleteAlert(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete this activity?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
              'With this activity will be deleted also related timetracking records.'),
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
                BlocProvider.of<ActivitiesBloc>(context)
                    .add(
                  DeleteActivity(widget.editActivity),
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
                      widget.editActivity != null ? "Edit " : "New ",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "Activity",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                actions: <Widget>[
                  Visibility(
                    child: Material(
                      child: InkWell(
                          onTap: () async {
                            final ConfirmAction action =
                                await _deleteAlert(context);
                            if (action == ConfirmAction.ACCEPT) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: Container(
                            width: 55,
                            child: Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                          )),
                    ),
                    visible: widget.editActivity != null ? true : false,
                  ),
                ],
              ),
              body: Container(
                color: Colors.white,
                child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(30),
                          child: Stack(
                            overflow: Overflow.visible,
                            alignment: Alignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: MaterialButton(
                                  onPressed: () {
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);
                                    currentFocus.unfocus();
                                    _pc.animatePanelToPosition(
                                      1.0,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.decelerate,
                                    );
                                  },
                                  color: Colors.white,
                                  textColor: Activity.enumToColor(
                                      ColorEnum.values[_currentColor]),
                                  child: Icon(
                                    Activity.enumToIcon(
                                        IconEnum.values[_currentIcon]),
                                    size: 60,
                                  ),
                                  shape: CircleBorder(),
                                ),
                              ),
                              Positioned(
                                  bottom: -8,
                                  left:
                                      (MediaQuery.of(context).size.width / 2) -
                                          40,
                                  child: MaterialButton(
                                    height: 30,
                                    onPressed: () {
                                      FocusScopeNode currentFocus =
                                          FocusScope.of(context);
                                      currentFocus.unfocus();
                                      _pc.animatePanelToPosition(
                                        1.0,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.decelerate,
                                      );
                                    },
                                    color: Colors.grey,
                                    textColor: Colors.red,
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                    shape: CircleBorder(),
                                  ))
                            ],
                          )),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          controller: _textController,
                          cursorColor: _cursorColor,
                          autofocus: false,
                          maxLength: 30,
                          decoration: InputDecoration(
                            counterText: '',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 15.0),
                            alignLabelWithHint: true,
                            labelText: "Activity name",
                            border: OutlineInputBorder(
                              gapPadding: 5,
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(),
                            ),
                          ),
                          validator: (val) {
                            if (val.length == 0) {
                              setState(() {
                                _cursorColor = Theme.of(context).errorColor;
                              });
                              return "This field cannot be empty";
                            } else {
                              setState(() {
                                _cursorColor = Theme.of(context).primaryColor;
                              });
                              return null;
                            }
                          },
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: RaisedButton(
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                  ),
                                  textTheme: ButtonTextTheme.primary,
                                  onPressed: () {
                                    // Validate returns true if the form is valid, otherwise false.
                                    if (_formKey.currentState.validate()) {
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
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text(
                                    widget.editActivity != null
                                        ? "Update activity"
                                        : "Save activity",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                )),
                          ),
                        ),
                      )
                    ])),
              )),
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
                Container(
                    height: 70,
                    width: double.infinity,
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: IconEnum.values.length,
                      itemBuilder: (BuildContext context, int index) {
                        return MaterialButton(
                          onPressed: () {
                            setState(() {
                              _currentIcon = index;
                            });
                          },
                          color: Color.fromRGBO(240, 240, 240, 1),
                          textColor: Activity.enumToColor(
                              ColorEnum.values[_currentColor]),
                          child:
                              Icon(Activity.enumToIcon(IconEnum.values[index])),
                          shape: CircleBorder(
                              side: BorderSide(
                                  width: 2,
                                  color: _currentIcon == index
                                      ? Color.fromRGBO(200, 200, 200, 0.8)
                                      : Colors.transparent)),
                        );
                      },
                    )),
                Container(
                    height: 70,
                    width: double.infinity,
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: ColorEnum.values.length,
                      itemBuilder: (BuildContext context, int index) {
                        return MaterialButton(
                          onPressed: () {
                            setState(() {
                              _currentColor = index;
                            });
                          },
                          color: Activity.enumToColor(ColorEnum.values[index]),
                          shape: CircleBorder(
                              side: BorderSide(
                                  width: 2,
                                  color: _currentColor == index
                                      ? Color.fromRGBO(200, 200, 200, 0.8)
                                      : Colors.black12)),
                        );
                      },
                    )),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
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
                          _pc.animatePanelToPosition(
                            0.0,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.decelerate,
                          );
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      )),
                ),
              ],
            )),
          )
        ],
      ),
    );
  }
}
