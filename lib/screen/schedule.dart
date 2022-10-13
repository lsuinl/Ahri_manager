// 사용자의 일정을 기록하는 스크린

import 'package:ahri_manager/calendar/component/calendar.dart';
import 'package:ahri_manager/calendar/component/schedule_bottom_sheet.dart';
import 'package:ahri_manager/calendar/component/schedule_card.dart';
import 'package:ahri_manager/calendar/component/schedule_banner.dart';
import 'package:ahri_manager/calendar/model/schedule_with_color.dart';
import 'package:ahri_manager/data/database/drift_database.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

  //final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[100],
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            '캘린더',
            style: TextStyle(
              fontFamily: 'jua',
              fontSize: 30.0,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black,
                  offset: Offset(1.0, 1.0),
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
      ),

      floatingActionButton: renderFloatingActionButton(), //add Button
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              selectedDay: selectedDay,
              focusedDay: focusedDay,
              onDaySelected: onDaySelected,
            ),
            SizedBox(
              height: 8.0,
            ),
            TodayBanner(
              selectedDay: selectedDay,
            ),
            SizedBox(height: 8.0), //여기 어디지
            _ScheduleList(
              selectedDate: selectedDay,
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton renderFloatingActionButton() { // 일정 추가 Button
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          //최대 사이즈가 화면의 반.
          context: context,
          isScrollControlled: true, //이렇게 설정하면 화면의 반보다 더 올라갈 수 있다.
          builder: (_) {
            return ScheduleBottomSheet(
              selectedDate: selectedDay,
            ); //Add 버튼을 누르면 하단에서 흰 공간이 올라오
          },
        );
      },
      backgroundColor: Colors.red[100],
      child: Icon(
        Icons.add,
      ),
    );
  }

  onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay; //9월 캘린더에서 8월 31일을 누르면 8월로 넘어갈 수 있는 코드
    });
  }
}

class _ScheduleList extends StatelessWidget {
  final DateTime selectedDate;

  const _ScheduleList({required this.selectedDate, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: StreamBuilder<List<ScheduleWithColor>>(
            stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasData && snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    '등록된 스케줄이 없어요.',
                    style: TextStyle(
                      //fontFamily: 'jua',
                      fontSize: 20.0,
                    ),
                  ),
                );
              }



              return ListView.separated(
                //스크롤 가능
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, index) {
                  //두 목록 사이에 끼워넣기
                  return SizedBox(height: 8.0); //두 목록 사이에 여백 추가
                },
                itemBuilder: (context, index) {
                  final scheduleWithColor = snapshot.data![index];

                  return Dismissible(
                    key: ObjectKey(scheduleWithColor.schedule.id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (DismissDirection direction) {
                      GetIt.I<LocalDatabase>()
                          .removeSchedule(scheduleWithColor.schedule.id);
                    },
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) {
                            return ScheduleBottomSheet(
                              selectedDate: selectedDate,
                              scheduleId: scheduleWithColor.schedule.id,
                            );
                          },
                        );
                      },
                      child: ScheduleCard(
                        title: scheduleWithColor.schedule.title,
                        color: Color(
                          int.parse(
                              'FF${scheduleWithColor.categoryColor.hexCode}',
                              radix: 16),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
