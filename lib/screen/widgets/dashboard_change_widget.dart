import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roqqu_test/theme/theme.dart';

class DashboardChangeField extends StatelessWidget {
  const DashboardChangeField({
    super.key,
    required this.isDarkMode,
    required this.assetPath,
    required this.fieldTitle,
    required this.fieldText,
    this.useSolidColor = false,
    this.showDivider = true,
  });

  final ValueNotifier<bool> isDarkMode;
  final String assetPath;
  final String fieldTitle;
  final String fieldText;
  final bool useSolidColor;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  assetPath,
                  color: !isDarkMode.value ? null : AppColors.darkGreyColor,
                ),
                const SizedBox(width: 4),
                Text(
                  fieldTitle,
                  style: textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDarkMode.value
                        ? AppColors.darkGreyColor
                        : AppColors.lightGreyColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            FittedBox(
              child: Text(
                fieldText,
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: useSolidColor
                      ? AppColors.greenColor
                      : isDarkMode.value
                          ? AppColors.whiteColor
                          : AppColors.darkBgColor,
                ),
              ),
            ),
          ],
        ),
        if (showDivider)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            color: isDarkMode.value
                ? AppColors.skyeBlueColor.withOpacity(0.04)
                : AppColors.lightGreyColor.withOpacity(0.1),
            width: 1,
            height: 40.h,
          ),
      ],
    );
  }
}