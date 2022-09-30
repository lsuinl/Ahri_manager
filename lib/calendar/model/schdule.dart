import 'package:drift/drift.dart';

class Schedules extends Table {
  // PRIMARY KEY
  IntColumn get id => integer().autoIncrement()();

  //autoIncrement: 자동으로 숫자를 늘려라.

  // 제목
  TextColumn get title => text()();

  // 메모
  TextColumn get memo => text()();

  // 일정 날짜
  DateTimeColumn get date => dateTime()();

  // Category Color Table ID
  IntColumn get colorId => integer()();

  // 생성날짜
  DateTimeColumn get createAt => dateTime().clientDefault(
        () => DateTime.now(),
  )();
}
