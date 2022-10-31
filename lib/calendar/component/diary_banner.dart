//달력과 투두리스트 사이에 있는 바 관리 코드 (날짜|일정버튼)

import 'package:ahri_manager/screen/schedule.dart';
import 'package:flutter/material.dart';

class DiaryBanner extends StatelessWidget {
  final DateTime selectedDay;

  const DiaryBanner({
    required this.selectedDay,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle( //투데이배너 글씨 style
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );


    return Container(
      color: Colors.pink[100],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '''${selectedDay.year}년 ${selectedDay.month}월 ${selectedDay.day}일
     Our Diary''',
              style: textStyle,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, MaterialPageRoute(builder: (context) => CalendarScreen()),);
              },

              style: ElevatedButton.styleFrom(primary: Colors.pink[200]),
              child: Text("일정",
              style: TextStyle(
                fontFamily: 'jua',
              fontSize: 17.5),),
            )
          ],
        ),
      ),
    );
  }
}