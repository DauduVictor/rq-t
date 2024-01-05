import 'package:flutter/material.dart';
import 'package:roqqu_test/theme/theme.dart';

class StrokeContainerWidget extends StatelessWidget {
  const StrokeContainerWidget({
    super.key,
    required this.isDarkMode,
    required this.child,
    this.usePadding = true,
  });

  final ValueNotifier<bool> isDarkMode;
  final Widget child;
  final bool usePadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.1,
          color: isDarkMode.value
              ? AppColors.darkStrokeColor
              : AppColors.lightStrokeColor,
        ),
        color: isDarkMode.value ? AppColors.blackColor : AppColors.whiteColor,
      ),
      child: Padding(
        padding:
            usePadding ? const EdgeInsets.all(16.0) : const EdgeInsets.all(0),
        child: child,
      ),
    );
  }
}
