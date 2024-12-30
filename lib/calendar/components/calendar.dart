// TableCalendar을 이용한 달력 구현 코드

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final DateTime? selectedDay;
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

    return TableCalendar(
      focusedDay: focusedDay,
      firstDay: DateTime(2000),
      lastDay: DateTime(3000),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20.0,
        ),
      ),
      calendarStyle: CalendarStyle(
          // markerDecoration:
          //     BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          isTodayHighlighted: false,
          markersAlignment: Alignment.bottomCenter,
          markersOffset: const PositionedOffset(),
          //오늘 날짜 하이라이트 X
          defaultTextStyle: defaultTextStyle,
          //주중
          holidayTextStyle: TextStyle()
              .copyWith(color: Colors.red, fontWeight: FontWeight.w700),
          weekendTextStyle: weekendTextStyle,
          //주말
          selectedDecoration: BoxDecoration(
            color: Colors.red[100],
            shape: BoxShape.circle,
          )),

      onDaySelected: onDaySelected,
      selectedDayPredicate: (DateTime date) {
        if (selectedDay == null) {
          return false;
        }

        return date.year == selectedDay!.year &&
            date.month == selectedDay!.month &&
            date.day == selectedDay!.day;
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
    );
  }
}
