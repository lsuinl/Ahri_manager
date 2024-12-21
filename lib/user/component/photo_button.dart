import 'package:ahri_manager/common/utils/color.dart';
import 'package:flutter/material.dart';

class PhotoButton extends StatelessWidget {
  const PhotoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
            onPressed: (){},
            color: MainColor,
            icon: Icon(Icons.add_box_outlined));
  }
}
