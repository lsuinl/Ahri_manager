import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
class Lodding extends StatefulWidget {
  const Lodding({Key? key}) : super(key: key);

  @override
  State<Lodding> createState() => _LoddingState();
}

class _LoddingState extends State<Lodding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            '/Users/kimsu-in/Desktop/icecream/flutter-sw/imgs/unicorn.png',
          ),
          CircularProgressIndicator(
            color: Colors.white,
          )
        ],
      ),
    );
    // if() 정보가 저장되어 있는경우 home

    // 없는 경우 start
  }
}
//     return Scaffold(
//       backgroundColor: Colors.lightBlueAccent,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             '/Users/kimsu-in/Desktop/icecream/flutter-sw/imgs/unicorn.png',
//           ),
//           CircularProgressIndicator(
//             color: Colors.white,
//           )
//         ],
//       ),
//     );
// //
// Future<String> checkPermission() async {
//   //권한을 사용할 수 있는지를 확인
//   final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
//
//   if (!isLocationEnabled) {
//     return '위치 서비스를 활성화 해주세요.';
//   }
//   //현재 앱이 가지고 있는 위치서비스에 대한 권한 값을 location이라는 형식으로 반환
//   LocationPermission checkPermission = await Geolocator.checkPermission();
//   if (checkPermission == LocationPermission.denied) {
//     //권한을 사용할 수 없지만 요청할 수는 있는 경우
//     checkPermission = await Geolocator.requestPermission();
//
//     if (checkPermission == LocationPermission.denied) {
//       return '위치 권한을 허가해주세요';
//     }
//   }
//   if (checkPermission == LocationPermission.deniedForever) {
//     return '앱의 위치 권한을 셋팅에서 허가해주세요';
//   }
//   return '위치 권한이 허가되었습니다.';
// }
