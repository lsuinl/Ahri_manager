// 일기창을 관리하는 스크린

import 'package:ahri_manager/calendar/component/calendar.dart';
import 'package:ahri_manager/calendar/component/diary_banner.dart';
import 'package:ahri_manager/calendar/component/diary_bottom_sheet.dart';
import 'package:ahri_manager/calendar/component/diary_card.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../data/database/drift_database.dart';


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

  StreamBuilder<List<DiaryData>> renderFloatingActionButton() {
    // 일정 추가 Button
    return StreamBuilder<List<DiaryData>>(
        stream: GetIt.I<LocalDatabase>().watchDiary(selectedDay),
        builder: (context, snapshot) {
          if (!snapshot.hasData) { //데이터가 안 뜨면
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData && snapshot.data!.isEmpty) { //데이터가 없으면
            return FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  //최대 사이즈가 화면의 반.
                  context: context,
                  isScrollControlled: true, //이렇게 설정하면 화면의 반보다 더 올라갈 수 있다.
                  builder: (_) {
                    return DiaryBottomSheet(
                      selectedDate: selectedDay,
                    ); //Add 버튼을 누르면 하단에서 흰 공간이 올라옴
                  },
                );
              },
              backgroundColor: Colors.red[100],
              child: Icon(
                Icons.add,
              ),
            );
          }

          else {
            final diary = snapshot.data![0];
            return FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) {
                    return DiaryBottomSheet(
                      selectedDate: selectedDay,
                      diaryId: diary.id,
                    );
                  },
                );
              },
              backgroundColor: Colors.red[100],
              child: Icon(
                Icons.edit,
              ),
            );
          };
        }
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
            builder: (context, snapshot) { //snapshot은 return 값을 의미
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasData && snapshot.data!.isEmpty) {
                return Center(
                  child: Text('작성된 일기가 없어요!',
                    style: TextStyle(
                      //fontFamily: 'jua',
                      //fontWeight: FontWeight.w200,
                      fontSize: 20.0,
                    ),
                  ),
                );
              }

              return ListView.separated(
                scrollDirection: Axis.vertical,
                //스크롤 가능
                itemCount: snapshot.data!.length, //일기 개수
                separatorBuilder: (context, index) {
                  return SizedBox(height: 8.0); //두 목록 사이에 여백 추가
                },
                itemBuilder: (context, index) {
                  final diaryData = snapshot.data![index];

                  return Dismissible( //왼쪽으로 스크롤하면 삭제
                    key: ObjectKey(diaryData.id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (DismissDirection direction) {
                      GetIt.I<LocalDatabase>()
                          .removeDiary(diaryData.id);
                    },
                    child: GestureDetector( //이미 적은 걸 클릭하면 수정
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) {
                            return DiaryBottomSheet(
                              selectedDate: selectedDate,
                              diaryId: diaryData.id,
                            );
                          },
                        );
                      },
                      child: DiaryCard( //일기 내용 띄우기
                        date: selectedDate,
                        title: diaryData.title,
                        content: diaryData.content,
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

