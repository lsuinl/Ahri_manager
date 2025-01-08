import 'package:ahri_manager/common/widgets/basic.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingScreen extends ConsumerStatefulWidget {
  static String get routeName => 'loading';
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoadingScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    return Basic(child:
    Text("d")
    );

  }
}
//----------------------------------------------
//로딩 = 필요 데이터를 불러옴
// class LoadingScreen extends StatelessWidget {
//   const LoadingScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Basic(
//         child: Center(
//             child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Image.asset(
//           'asset/imgs/pet-food.png',
//           width: 100,
//         ),
//         SizedBox(height:50),
//         Container(
//             width: 100,
//             child: LoadingIndicator(
//               colors:[MainColor],
//               indicatorType: Indicator.orbit,
//             )),
//
//       ],
//     )));
//   }
// }
