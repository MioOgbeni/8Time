import 'package:eighttime/models/activity.dart';
import 'package:eighttime/models/user.dart';
import 'package:eighttime/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'activityEditForm.dart';

class ActivitiesList extends StatefulWidget {
  @override
  _ActivitiesListState createState() => _ActivitiesListState();
}

class _ActivitiesListState extends State<ActivitiesList> {
  @override
  Widget build(BuildContext context) {
    final activities = Provider.of<List<Activity>>(context);

    if (activities != null) {
      activities.sort((a, b) => a.order.compareTo(b.order));
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (activities != null) {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }

              final Activity item = activities.removeAt(oldIndex);
              activities.insert(newIndex, item);

              for (var i = 0; i < activities.length; i++) {
                activities[i].order = i;
                DatabaseService(Provider
                    .of<User>(context, listen: false)
                    .uid)
                    .editActivity(activities[i]);
              }
            }
          });
        },
        children: <Widget>[
          if(activities != null)
            for (final item in activities)
              Card(
                key: ValueKey(item),
                child: ListTile(
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
