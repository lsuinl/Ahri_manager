import 'package:ahri_manager/screen/calendar.dart';
import 'package:flutter/material.dart';

/*
달력과 투두리스트 사이에 있는 바 관리 코드 (날짜|할 일 개수)
 */

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
      color: Colors.pink[100], //배너 배경 색깔
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => CalendarScreen()),);
              },

              style: ElevatedButton.styleFrom(primary: Colors.pink[200]),
              child: Text("일정"),
            )
          ],
        ),
      ),
    );
  }
}