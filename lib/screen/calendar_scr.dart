import 'package:flutter/material.dart';
import '../component/calendar.dart';

//캘린더 관리창(초기설정을 기반으로+직접 지정하는 일정관리)

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Calendar(),
          ],
        ),
      ),
    );
  }
}
