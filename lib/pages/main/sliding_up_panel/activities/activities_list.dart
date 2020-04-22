import 'package:eighttime/activities_repository.dart';
import 'package:eighttime/blocs/activities_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'activityEditForm.dart';

// ignore: must_be_immutable
class ActivitiesList extends StatefulWidget {
  List<Activity> activities;

  ActivitiesList({Key key, this.activities}) : super(key: key);

  @override
  _ActivitiesListState createState() => _ActivitiesListState();
}


class _ActivitiesListState extends State<ActivitiesList> {
  @override
  Widget build(BuildContext context) {
    if (widget.activities != null) {
      widget.activities.sort((a, b) => a.order.compareTo(b.order));
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (widget.activities != null) {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }

              final Activity item = widget.activities.removeAt(oldIndex);
              widget.activities.insert(newIndex, item);

              for (var i = 0; i < widget.activities.length; i++) {
                widget.activities[i] = widget.activities[i].copyWith(order: i);
              }

              BlocProvider.of<ActivitiesBloc>(context).add(
                UpdateActivities(widget.activities),
              );
            }
          });
        },
        children: <Widget>[
          if(widget.activities != null)
            for (final item in widget.activities)
              Card(
                key: ValueKey(item),
                child: ListTile(
                    key: ValueKey(item),
                    onTap: () {},
                    enabled: true,
                    contentPadding: EdgeInsets.only(left: 10.0),
                    leading: Container(
                      padding: EdgeInsets.only(right: 10.0),
                      decoration: new BoxDecoration(
                          border: new Border(
                              right: new BorderSide(
                                  width: 1.0, color: Colors.black12))),
                      child: Icon(
                        Activity.enumToIcon(item.icon),
                        color: Activity.enumToColor(item.color),
                        size: 35,
                      ),
                    ),
                    title: Container(
                      width: double.infinity,
                      child: Text(
                        item.name,
                        textWidthBasis: TextWidthBasis.longestLine,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    trailing: Wrap(
                      alignment: WrapAlignment.end,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.edit,
                              size: 20.0,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ActivityEditForm(editActivity: item)),
                              );
                            }),
                      ],
                    )),
              ),
        ],
      ),
    );
  }
}
