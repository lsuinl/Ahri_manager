import 'package:ahri_manager/data/database/drift_database.dart';
import 'package:ahri_manager/screen/hospital_list.dart';
import 'package:ahri_manager/screen/input_animal_information.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

const DEFAULT_COLORS = [
  'F44336', //red
  'E91E63', //pink
  'FF9800', //orange
  'FFEB3B', //yellow
  'B2FF59', //lightGreen
  '558B2F', //green
  '64FFDA', //mint
  '2196F3', //blue
  '3F51B5', //indigo
  '9C27B0', //purple
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //플러터가 준비될 때까지 대기.
  await initializeDateFormatting(); //intl안에 있는 모든 언어 사용 가능. 특히 날짜 관련.
  //runApp 전에 우리가 실행해야 하는 코드가 있기 때문에 WidgetFlutterBinding 함수를 사용하는 것

  final database = LocalDatabase();

  //GetIt을 사용하여 어디서든 데이터베이스를 가져올 수 있다.
  GetIt.I.registerSingleton<LocalDatabase>(database);

  //데이터베이스 속 색깔 불러오기
  final colors = await database.getCategoryColors();

  if (colors.isEmpty) {
    //color가 비어있다면 위에 리스트에서 색깔을 가져옴.
    for (String hexCode in DEFAULT_COLORS) {
      await database.createCategoryColor(
        CategoryColorsCompanion(
          hexCode: Value(hexCode),
        ),
      );
    }
  }

  runApp(
    MaterialApp(
        //앱 스타일
        home: MapHospitalListScreen() //
        ),
  );
}
