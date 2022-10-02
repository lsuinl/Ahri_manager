import 'package:ahri_manager/calendar/model/diary.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

part 'drift_diary_database.g.dart'; //자동으로 파일이 생성

@DriftDatabase(
  tables: [
    Diary,
  ],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

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
    return (select(diary)..where((tbl)=>tbl.date.equals(date))).watch();

  }

  @override
  int get schemaVersion => 1; //데이터베이스에 설정한 테이블들의 상태 버전

}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    //데이터 베이스를 저장할 폴더
    final file = File(p.join(dbFolder.path, 'db.sqlite')); //데이터 베이스를 저장할 파일
    return NativeDatabase(file);
  });
}
