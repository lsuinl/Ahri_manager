import 'package:ahri_manager/calendar/component/calendar.dart';
import 'package:ahri_manager/calendar/component/diary_banner.dart';
import 'package:ahri_manager/calendar/component/diary_bottom_sheet.dart';
import 'package:ahri_manager/calendar/component/diary_card.dart';
import 'package:ahri_manager/calendar/model/diary.dart';
import 'package:ahri_manager/calendar/model/diary_day.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../data/database/drift_diary_database.dart';


class DiaryScreen extends StatefulWidget {
  const DiaryScreen({Key? key}) : super(key: key);

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            DiaryBanner(
              selectedDay: selectedDay,
            ),
            SizedBox(height: 8.0),
            _ShowDiary(selectedDate: selectedDay),
          ],
        ),
      ),
    );
  }

  FloatingActionButton renderFloatingActionButton() {
    // 일정 추가 Button
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          //최대 사이즈가 화면의 반.
          context: this.context,
          isScrollControlled: true, //이렇게 설정하면 화면의 반보다 더 올라갈 수 있다.
          builder: (_) {
            return DiaryBottomSheet(
              selectedDate: selectedDay,
            ); //Add 버튼을 누르면 하단에서 흰 공간이 올라오
          },
        );
      },
      backgroundColor: Colors.blue,
      child: Icon(
        Icons.add,
        color: Colors.white,
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

class _ShowDiary extends StatelessWidget {
  final DateTime selectedDate;

  const _ShowDiary({required this.selectedDate, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: StreamBuilder<List<DiaryData>>(
            stream: GetIt.I<LocalDatabase>().watchDiary(selectedDate),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasData && snapshot.data!.isEmpty) {
                return Center(
                  child: Text('일기가 없어요.'),
                );
              }

              return ListView.separated(
                scrollDirection: Axis.vertical,
                //스크롤 가능
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, index) {
                  //두 목록 사이에 끼워넣기
                  return SizedBox(height: 8.0); //두 목록 사이에 여백 추가
                },
                itemBuilder: (context, index) {
                  final DiaryData = snapshot.data![index];

                  return Dismissible(
                    key: ObjectKey(DiaryData.id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (DismissDirection direction) {
                      GetIt.I<LocalDatabase>()
                          .removeDiary(DiaryData.id);
                    },
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) {
                            return DiaryBottomSheet(
                              selectedDate: selectedDate,
                              diaryId: DiaryData.id,
                            );
                          },
                        );
                      },
                      child: DiaryCard(
                        title: DiaryData.title,
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
