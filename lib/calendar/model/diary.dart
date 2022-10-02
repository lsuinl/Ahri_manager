import 'package:drift/drift.dart';

class Diary extends Table {

  //PRIMARY KEY
  IntColumn get id => integer().autoIncrement()();

  //제목
  TextColumn get title => text()();

  //내용
  TextColumn get content => text()();

  //일기날짜
  DateTimeColumn get date => dateTime()();

  //생성날짜
  DateTimeColumn get createAt => dateTime().clientDefault(
        () => DateTime.now(),
  )();
}