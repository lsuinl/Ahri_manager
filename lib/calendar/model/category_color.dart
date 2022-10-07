//카테고리 색상 선택 데이터 코드

import 'package:drift/drift.dart';

class CategoryColors extends Table {
  // PRIMARY KEY
  IntColumn get id => integer().autoIncrement()();

  // 색상 코드
  TextColumn get hexCode => text()();
}