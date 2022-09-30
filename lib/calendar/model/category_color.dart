import 'package:drift/drift.dart';
/*
카테고리 색상 선택 데이터 코드
 */
class CategoryColors extends Table {
  // PRIMARY KEY
  IntColumn get id => integer().autoIncrement()();

  // 색상 코드
  TextColumn get hexCode => text()();
}