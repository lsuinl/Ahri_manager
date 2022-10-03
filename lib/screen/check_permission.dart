import 'package:ahri_manager/screen/home.dart';
import 'package:ahri_manager/screen/input_animal_information.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ahri_manager/data/user_information.dart';
import 'package:ahri_manager/plus/user_helper.dart';

class CheckPermissionScreen extends StatefulWidget {
  const CheckPermissionScreen({Key? key}) : super(key: key);
  @override
  State<CheckPermissionScreen> createState() => _CheckPermissionScreenState();
}

class _CheckPermissionScreenState extends State<CheckPermissionScreen> {
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
        backgroundColor: Colors.pink[100],
        body: FutureBuilder<String>(
            future: checkpermission(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == '허가')
                return _ok(
                  user_infotmations: user_infotmations,
                );
              if (snapshot.connectionState == ConnectionState.waiting)
                return _lodding();
              else
                return _error(
                  user_infotmations: user_infotmations,
                );
            }));
  }

  void updateScreen() {
    user_infotmations = helper.getuserinformation();
    setState(() {});
  }
}

Future<String> checkpermission() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.locationWhenInUse,
    Permission.photos,
    Permission.phone,
    Permission.camera,
  ].request();

  if (statuses.values.every((element) => element.isDenied)) {
    return '비허가';
  } else
    return '허가';
}

class _ok extends StatelessWidget {
  final List<user_information> user_infotmations;

  const _ok({required this.user_infotmations, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            'asset/imgs/unicorn.png',
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
                  primary: Colors.pink[300], //배경색
                  onPrimary: Colors.pink, //눌렀을 때
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _lodding extends StatelessWidget {
  const _lodding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'asset/imgs/unicorn.png',
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
  }
}

class _error extends StatelessWidget {
  final List<user_information> user_infotmations;

  const _error({required this.user_infotmations, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'asset/imgs/unicorn.png',
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
                      builder: (context) => InputAnimalInformationScreen()));
            else
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        Text(
          "권한 설정에 문제가 생겼습니다. 어플의 원활한 작동을 위해 설정에서 권한을 설정해주세요.",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'jua',
            fontSize: 20.0,
          ),
        ),
      ],
    );
  }
}
