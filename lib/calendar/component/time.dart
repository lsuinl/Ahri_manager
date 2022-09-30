import 'package:day_night_time_picker/lib/constants.dart';
import 'package:flutter/material.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';

class TimePick extends StatefulWidget {
  const TimePick({Key? key}) : super(key: key);

  @override
  State<TimePick> createState() => _TimePickState();
}

class _TimePickState extends State<TimePick> {
  TimeOfDay _time = TimeOfDay.now().replacing(hour: 11, minute: 30);
  bool iosStyle = true;

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 5),
            child: Row(
              children: [
                Text('시간',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 10),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        showPicker(
                          context: context,
                          value: _time,
                          onChange: onTimeChanged,
                        ),
                      );
                    },
                    icon: Icon(Icons.favorite)
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}
