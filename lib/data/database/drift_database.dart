// drift DataBase에 연결할 코드 작성
// 일기, 스케줄 데이터 관리

import 'dart:io';
import 'package:ahri_manager/calendar/model/category_color.dart';
import 'package:ahri_manager/calendar/model/schdule.dart';
import 'package:ahri_manager/calendar/model/schedule_with_color.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:ahri_manager/calendar/model/diary.dart';

part 'drift_database.g.dart'; //자동으로 파일 생성

@DriftDatabase( //어떤 클래스를 table로 사용할지 설정
  tables: [
    Schedules,
    CategoryColors,
    Diary,
  ],
)


class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  Future<Schedule> getScheduleById(int id) =>
      (select(schedules)
        ..where((tbl) => tbl.id.equals(id))).getSingle();


  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  Future<int> createCategoryColor(CategoryColorsCompanion data) =>
      into(categoryColors).insert(data);

  Future<List<CategoryColor>> getCategoryColors() =>
      select(categoryColors).get();

  Future<int> updateScheduleById(int id, SchedulesCompanion data) =>
      (update(schedules)
        ..where((tbl) => tbl.id.equals(id))).write(data);

  Future<int> removeSchedule(int id) =>
      (delete(schedules)
        ..where((tbl) => tbl.id.equals(id))).go();

  Stream<List<ScheduleWithColor>> watchSchedules(DateTime date) {
    final query = select(schedules).join([
      innerJoin(categoryColors, categoryColors.id.equalsExp(schedules.colorId))
    ]);

    query.where(schedules.date.equals(date));

    return query.watch().map(
          (rows) =>
          rows
              .map(
                (row) =>
                ScheduleWithColor(
                  schedule: row.readTable(schedules),
                  categoryColor: row.readTable(categoryColors),
                ),
          )
              .toList(),
    );
  }

  Future<DiaryData> getDiaryById(int id) =>
      (select(diary)
        ..where((tbl) => tbl.id.equals(id))).getSingle();

  //일기 작성
  Future<int> createDiary(DiaryCompanion data) => into(diary).insert(data);

  //일기 수정
  Future<int> updateDiaryById(int id, DiaryCompanion data) =>
      (update(diary)
        ..where((tbl) => tbl.id.equals(id))).write(data);

  //일기 삭제
  Future<int> removeDiary(int id) =>
      (delete(diary)
        ..where((tbl) => tbl.id.equals(id))).go();

  //일기 띄우기
  Stream<List<DiaryData>> watchDiary(DateTime date) {
    return (select(diary)
      ..where((tbl) => tbl.date.equals(date))).watch();
  }

  @override
  int get schemaVersion => 1; //데이터베이스에 설정한 테이블들의 상태 버전

}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite')); //데이터 베이스를 저장할 파일
    return NativeDatabase(file);
  });
}