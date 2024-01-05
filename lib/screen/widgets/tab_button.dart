import 'package:flutter/material.dart';
import 'package:roqqu_test/theme/theme.dart';

class TabButton extends StatelessWidget {
  const TabButton({
    super.key,
    required this.isDarkMode,
    required this.onTap,
    required this.label,
    required this.selected,
    this.hasOutline = false,
    this.width,
  });

  final ValueNotifier<bool> isDarkMode;
  final VoidCallback? onTap;
  final String label;
  final bool selected;
  final bool hasOutline;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 8.5,
        ),
        width: width,
        decoration: selected
            ? BoxDecoration(
                color: isDarkMode.value
                    ? AppColors.brownColor
                    : AppColors.whiteColor,
                borderRadius: BorderRadius.circular(8),
                border:
                    hasOutline ? Border.all(color: AppColors.greenColor) : null,
              )
            : null,
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style: textTheme.titleMedium!.copyWith(
                color: isDarkMode.value
                    ? selected
                        ? AppColors.whiteColor
                        : AppColors.lightGreyColor
                    : selected
                        ? AppColors.blackColor
                        : AppColors.lightGreyColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
