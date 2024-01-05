import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roqqu_test/theme/theme.dart';

class OrderBookFieldWidget extends StatelessWidget {
  const OrderBookFieldWidget({
    super.key,
    required this.isDarkMode,
    required this.price,
    required this.amount,
    required this.total,
    required this.bgColor,
    this.bgWidth = 0.0,
  });

  final ValueNotifier<bool> isDarkMode;
  final String price;
  final String amount;
  final String total;
  final Color bgColor;
  final double bgWidth;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mqr = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                price,
                style: textTheme.titleSmall!.copyWith(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: bgColor,
                ),
              ),
            ),
            SizedBox(width: mqr.width * 0.16),
            Expanded(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: mqr.width * bgWidth,
                      height: 25.5,
                      color: bgColor.withOpacity(0.15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          amount,
                          style: textTheme.titleSmall!.copyWith(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode.value
                                ? AppColors.whiteColor
                                : AppColors.blackColor,
                          ),
                        ),
                        Text(
                          total,
                          style: textTheme.titleSmall!.copyWith(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode.value
                                ? AppColors.whiteColor
                                : AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
