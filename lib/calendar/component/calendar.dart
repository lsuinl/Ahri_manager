import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../data/database/drift_database.dart';
import '../model/schedule_with_color.dart';

class Calendar extends StatelessWidget {
  final DateTime selectedDay; // 이 세가지는 외부에서 관리
  final DateTime focusedDay;
  final OnDaySelected? onDaySelected;

  const Calendar(
      {required this.selectedDay,
      required this.focusedDay,
      required this.onDaySelected,
      Key? key})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    final defaultBoxDeco = BoxDecoration(
      borderRadius: BorderRadius.circular(6.0),
      color: Colors.grey[200],
    );
    final defaultTextStyle = TextStyle(
      //평일
      fontWeight: FontWeight.w700,
      fontSize: 18.0,
    );
    final weekendTextStyle = TextStyle(
      //주말
      color: Colors.red,
      fontWeight: FontWeight.w700,
      fontSize: 18.0,
    );

    //List<Event> _getEventsForDay(DateTime day) {
      //return _groupEvents[day] ?? [];
    ///}

    //final List<T> Function(DateTime day)? eventLoader;

    //int count = 0;

   //StreamBuilder<List<ScheduleWithColor>>(
    //    stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDay),
    //    builder: (context, snapshot) {
    //      if (snapshot.hasData) count = snapshot.data!.length;
    //      return Text(
    //        '$count개',
    //      );
    //    });

    return TableCalendar(
      //locale: 'ko-KR',
      focusedDay: focusedDay,
      firstDay: DateTime(2000),
      lastDay: DateTime(3000),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          //맨위에 ~년 ~월
          fontWeight: FontWeight.w700,
          fontSize: 20.0,
        ),
      ),
      calendarStyle: CalendarStyle(
          //markerSize: 0.3,
          markerDecoration:
              BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          //markersAnchor : 0.7,
          //markerMargin : const EdgeInsets.symmetric(horizontal: 0.3),
          isTodayHighlighted: false,
          markersAlignment : Alignment.bottomCenter,
          markersOffset : const PositionedOffset(),
          //오늘 날짜 하이라이트 X
          defaultTextStyle: defaultTextStyle,
          //주중
          holidayTextStyle: TextStyle()
              .copyWith(color: Colors.red, fontWeight: FontWeight.w700),
          //홀리!
          weekendTextStyle: weekendTextStyle,
          //주말
          selectedDecoration: BoxDecoration(
            color: Colors.red[100],
            shape: BoxShape.circle,
          )
          //selectedColor: Theme.of(context).primaryColor, //왜안되지요?
          ),

      onDaySelected: onDaySelected,
      selectedDayPredicate: (DateTime date) {
        if (selectedDay == null) {
          return false;
        }

        return date.year == selectedDay.year &&
            date.month == selectedDay.month &&
            date.day == selectedDay.day;
      },
      //우리가 선택한 날짜(selectedDay)와 비교해서 모두 같으면 true 반환 -> 우리가 선택한 날에 색깔생김
      calendarBuilders:
          CalendarBuilders(markerBuilder: (context, date, dynamic event) {
        if (event.isNotEmpty) {
          return Container(
            width: 35,
            decoration: BoxDecoration(
              color: Colors.pink.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
          );
        }
      }),
      //eventLoader: _getEventsForDay,
    );
  }
}

class Event {
  String title;
  Event(this.title);
}
