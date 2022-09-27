import 'package:ahri_manager/screen/home.dart';
import 'package:ahri_manager/screen/start.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ahri_manager/data/user_data.dart';
import 'package:ahri_manager/plus/user_helper.dart';

class Lodding extends StatefulWidget {
  const Lodding({Key? key}) : super(key: key);

  @override
  State<Lodding> createState() => _LoddingState();
}

class _LoddingState extends State<Lodding> {
  List<user_information> user_infotmations = [];
  final UserHelper helper = UserHelper();

  @override
  void initState() {
    helper.init().then((value) {
      updateScreen();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: FutureBuilder<String>(
          future: checkpermission(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == '권한이 허가되었습니다.') {
              //권한설정이 완료되었는지.
              //초기설정완료된 상태인지.
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    '/Users/kimsu-in/Desktop/icecream/flutter-sw/asset/imgs/unicorn.png',
                  ),
                  ElevatedButton(
                    child: Text(
                      "시작하기",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(),
                    onPressed: () {
                      if (user_infotmations.length<1) { //정보저장여부
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StartScreen()));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      }
                    },
                  ),
                ],
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    '/Users/kimsu-in/Desktop/icecream/flutter-sw/asset/imgs/unicorn.png',
                  ),
                  CircularProgressIndicator(
                    color: Colors.white,
                  ),
                  Text(
                    "데이터를 확인 중입니다.",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              );
            } else
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    '/Users/kimsu-in/Desktop/icecream/flutter-sw/asset/imgs/unicorn.png',
                  ),
                  Text(
                    "권한 설정에 문제가 생겼습다. 권한을 설정해주세요.",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              );
          }),
    );
  }

  void updateScreen() {
    user_infotmations = helper.getuserinformation();
    setState(() {});
  }
}

Future<String> checkpermission() async {
  Permission.locationWhenInUse.request();
  Permission.photos.request();
  if ((await Permission.photos.isGranted ||
      await Permission.photos.isLimited)&&(
      await Permission.locationWhenInUse.isGranted ||
          await Permission.locationWhenInUse.isLimited
  )) {
    //권한확인
    return '권한이 허가되었습니다.';
  } else {
    return '권한에 문제가 발생했습니다.';
  }
}
