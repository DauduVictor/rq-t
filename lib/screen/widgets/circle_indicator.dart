import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roqqu_test/theme/theme.dart';

class CircleProgressIndicator extends StatelessWidget {
  const CircleProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? const CupertinoActivityIndicator(
            radius: 16, color: AppColors.greenColor2)
        : const CircularProgressIndicator(
            strokeWidth: 3.0,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.greenColor2),
          );
  }
}
