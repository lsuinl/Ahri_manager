import 'package:ahri_manager/screen/home.dart';
import 'package:ahri_manager/screen/input_animal_information.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ahri_manager/data/user_information.dart';
import 'package:ahri_manager/plus/user_helper.dart';

// 어플이름, 하단 메인 문구 텍스트, 위젯별 크기 및 위치 변경만 처리하면 됩니다.
class CheckPermissionScreen extends StatefulWidget {
  const CheckPermissionScreen({Key? key}) : super(key: key);

  @override
  State<CheckPermissionScreen> createState() => _CheckPermissionScreenState();
}

class _CheckPermissionScreenState extends State<CheckPermissionScreen> {
  List<user_information> user_infotmations = [];
  final UserHelper helper = UserHelper();
  String check = "";

  @override
  void initState() {
    helper.init().then((value) {updateScreen();});
    checkpermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (check == '허가')
      return _ok(user_infotmations: user_infotmations,);
    else if (check == '비허가')
      return _error(user_infotmations: user_infotmations,);
    else
      return _lodding();
  }


  void updateScreen() {
    user_infotmations = helper.getuserinformation();
    setState(() {});
  }
  checkpermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.locationWhenInUse,
      Permission.photos,
    ].request();
    setState(() {
      if (statuses.values.every((element) => element.isDenied))
        check = '비허가';
      else
        check = '허가';
    });
  }
}

class _ok extends StatelessWidget {
  final List<user_information> user_infotmations;

  const _ok({required this.user_infotmations, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[100],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "수인효선지유",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'jua',
                      fontSize: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                child: Image.asset(
                  'asset/imgs/unicorn.png', width: 300, height: 300,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80.0),
                    child: Text(
                      "소외된 특수반려동물들의 공간",
                      style: TextStyle(
                        color: Colors.black12,
                        fontFamily: 'jua',
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: SizedBox(
                  height: 50.0,
                  child: ElevatedButton(
                    child: Text(
                      "시작하기",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'jua',
                        fontSize: 30.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink[300],
                      //배경색
                      onPrimary: Colors.pink,
                      //눌렀을 때
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        //테두리 둥글게
                        borderRadius: BorderRadius.circular(
                          (10.0),
                        ),
                      ),
                      elevation: 3.0,
                    ),
                    onPressed: () {
                      if (user_infotmations.length < 1) //정보저장여부
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    InputAnimalInformationScreen()));
                      else
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}

class _lodding extends StatelessWidget {
  const _lodding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[100],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "수인효선지유",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'jua',
                    fontSize: 50.0,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20),
              child: Image.asset(
                'asset/imgs/unicorn.png', width: 300, height: 300,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 80.0),
                  child: Text(
                    "소외된 특수반려동물들의 공간",
                    style: TextStyle(
                      color: Colors.black12,
                      fontFamily: 'jua',
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ],
            ),
            CircularProgressIndicator(
              color: Colors.white,
            ),
            Text(
              "데이터를 확인 중입니다.",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ));
  }
}

class _error extends StatelessWidget {
  final List<user_information> user_infotmations;

  const _error({required this.user_infotmations, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[100],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "수인효선지유",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'jua',
                    fontSize: 50.0,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20),
              child: Image.asset(
                'asset/imgs/unicorn.png', width: 100, height: 100,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 80.0),
                  child: Text(
                    "소외된 특수반려동물들의 공간",
                    style: TextStyle(
                      color: Colors.black12,
                      fontFamily: 'jua',
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              child: Text(
                "시작하기",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(),
              onPressed: () {
                if (user_infotmations.length < 1) //정보저장여부
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              InputAnimalInformationScreen()));
                else
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            Text(
              "권한이 거부되었습니다. 어플의 원활한 작동을 위해 설정에서 권한을 설정해주세요.",
              style: TextStyle(
                color: Colors.orange,
                fontFamily: 'jua',
                fontSize: 20.0,)
            ),
          ],
        )
    );
  }
}