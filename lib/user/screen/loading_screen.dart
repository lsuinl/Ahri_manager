import 'package:ahri_manager/common/widgets/basic.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Basic(
        child: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'asset/imgs/pet-food.png',
          width: 100,
        ),
        SizedBox(height:50),
        Container(
            width: 100,
            child: LoadingIndicator(
              indicatorType: Indicator.orbit,
            ))
      ],
    )));
  }
}
