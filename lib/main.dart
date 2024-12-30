import 'package:ahri_manager/user/screen/loading_screen.dart';
import 'package:ahri_manager/user/screen/login_screen.dart';
import 'package:ahri_manager/user/screen/register_screen.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

const defaultColors = [
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
  await NaverMapSdk.instance.initialize(clientId: "");
  // await initializeDateFormatting();
  //runApp 전에 우리가 실행해야 하는 코드가 있기 때문에 WidgetFlutterBinding 함수를 사용하는 것


  runApp(ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return const MaterialApp(
            debugShowCheckedModeBanner: false, 
            home: LoadingScreen()
            );
      }));
}