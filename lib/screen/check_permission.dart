import 'package:ahri_manager/screen/home.dart';
import 'package:ahri_manager/screen/input_user_information.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ahri_manager/data/user_information.dart';
import 'package:ahri_manager/plus/user_helper.dart';

class LoddingScreen extends StatefulWidget {
  const LoddingScreen({Key? key}) : super(key: key);
  @override
  State<LoddingScreen> createState() => _LoddingScreenState();
}

class _LoddingScreenState extends State<LoddingScreen> {
  List<user_information> user_infotmations = [];
  final UserHelper helper = UserHelper();

  @override
  void initState() {
    helper.init().then((value) {updateScreen();});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: FutureBuilder<String>(
          future: checkpermission(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == '허가')
              return _ok(user_infotmations: user_infotmations,);
            if (snapshot.connectionState == ConnectionState.waiting)
              return _lodding();
            else
              return _error();
          }));
  }

  void updateScreen() {
    user_infotmations = helper.getuserinformation();
    setState(() {});
  }
}

Future<String> checkpermission() async {
  var locationper=Permission.locationWhenInUse.request();
  var photoper= Permission.photos.request();
  if(locationper.isDenied==true) Permission.locationWhenInUse.request();
  if(photoper.isDenied==true) Permission.locationWhenInUse.request();
  if((await locationper.isGranted==false||await locationper.isLimited==false) &&
      await photoper.isGranted==false ||await photoper.isLimited==false )
    return '허가';
  else
    return '문제 발생';
}

class _ok extends StatelessWidget {
  final List<user_information> user_infotmations;

  const _ok({
    required this.user_infotmations,
    Key? key}) : super(key: key);

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
            if (user_infotmations.length<1) //정보저장여부
              Navigator.push(context, MaterialPageRoute(builder: (context) => StartScreen()));
            else
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
      ],
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
  const _error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'asset/imgs/unicorn.png',
        ),
        Text(
          "권한 설정에 문제가 생겼습다. 권한을 설정해주세요.",
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}

