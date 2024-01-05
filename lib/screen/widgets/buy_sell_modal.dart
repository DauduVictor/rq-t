import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roqqu_test/screen/widgets/widget.dart';
import 'package:roqqu_test/theme/theme.dart';
import 'package:roqqu_test/utils/asset_path.dart';

class BuySellModalSheet extends StatefulWidget {
  const BuySellModalSheet({
    super.key,
    required this.isDarkMode,
    required this.isBuy,
  });

  final ValueNotifier<bool> isDarkMode;
  final bool isBuy;

  @override
  State<BuySellModalSheet> createState() => _BuySellModalSheetState();
}

class _BuySellModalSheetState extends State<BuySellModalSheet> {
  final selectedButtonCategory = ValueNotifier('limit');
  final isPost = ValueNotifier(false);
  final limitPriceController = TextEditingController();
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final tabSelected = ValueNotifier(widget.isBuy ? 'buy' : 'sell');
    final mqr = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.fromLTRB(34, 30, 34, 28),
      height: mqr.height * 0.8,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(23),
          topRight: Radius.circular(23),
        ),
        color: widget.isDarkMode.value
            ? AppColors.darkBgColor
            : AppColors.lightBgColor,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ValueListenableBuilder(
              valueListenable: selectedButtonCategory,
              builder: (context, _, val) {
                return ValueListenableBuilder(
                  valueListenable: tabSelected,
                  builder: (context, val, _) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2.5),
                          width: mqr.width * 0.8,
                          decoration: BoxDecoration(
                            color: widget.isDarkMode.value
                                ? AppColors.pureBlackColor.withOpacity(0.3)
                                : AppColors.lightStrokeColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TabButton(
                                  isDarkMode: widget.isDarkMode,
                                  onTap: () => tabSelected.value = 'buy',
                                  label: 'Buy',
                                  selected: tabSelected.value == 'buy',
                                  hasOutline: true,
                                ),
                              ),
                              Expanded(
                                child: TabButton(
                                  isDarkMode: widget.isDarkMode,
                                  onTap: () => tabSelected.value = 'sell',
                                  label: 'Sell',
                                  selected: tabSelected.value == 'sell',
                                  hasOutline: true,
                                  width: mqr.width * 0.35,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 17),
                        if (tabSelected.value == 'sell')
                          SizedBox(
                            height: mqr.height * 0.66,
                            child: Center(
                              child: Text(
                                'No Sell Data',
                                style: textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: widget.isDarkMode.value
                                      ? AppColors.darkGreyColor
                                      : AppColors.lightGreyColor,
                                ),
                              ),
                            ),
                          ),
                        if (tabSelected.value == 'buy') ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SelectionButton(
                                buttonLabel: 'Limit',
                                isDarkMode: widget.isDarkMode,
                                isSelected:
                                    selectedButtonCategory.value == 'limit',
                                onTap: () =>
                                    selectedButtonCategory.value = 'limit',
                              ),
                              SelectionButton(
                                buttonLabel: 'Market',
                                isDarkMode: widget.isDarkMode,
                                isSelected:
                                    selectedButtonCategory.value == 'market',
                                onTap: () =>
                                    selectedButtonCategory.value = 'market',
                              ),
                              SelectionButton(
                                buttonLabel: 'Stop-Limit',
                                isDarkMode: widget.isDarkMode,
                                isSelected:
                                    selectedButtonCategory.value == 'stop',
                                onTap: () =>
                                    selectedButtonCategory.value = 'stop',
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (['market', 'stop']
                              .contains(selectedButtonCategory.value))
                            SizedBox(
                              height: mqr.height * 0.6,
                              child: Center(
                                child: Text(
                                  selectedButtonCategory.value == 'market'
                                      ? 'No Market Data'
                                      : 'No Stop-Limit Data',
                                  style: textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: widget.isDarkMode.value
                                        ? AppColors.darkGreyColor
                                        : AppColors.lightGreyColor,
                                  ),
                                ),
                              ),
                            ),
                          if (selectedButtonCategory.value == 'limit') ...[
                            InputWidget(
                              isDarkMode: widget.isDarkMode,
                              fieldLabel: 'Limit Price',
                              child: InputWidgetTextField(
                                textEditingController: limitPriceController,
                                isDarkMode: widget.isDarkMode,
                              ),
                            ),
                            InputWidget(
                              isDarkMode: widget.isDarkMode,
                              fieldLabel: 'Amount',
                              child: InputWidgetTextField(
                                textEditingController: amountController,
                                isDarkMode: widget.isDarkMode,
                              ),
                            ),
                            InputWidget(
                              isDarkMode: widget.isDarkMode,
                              fieldLabel: 'Type',
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Good till cancelled',
                                    style: textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: widget.isDarkMode.value
                                          ? AppColors.darkGreyColor
                                          : AppColors.lightGreyColor,
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 15,
                                    color: widget.isDarkMode.value
                                        ? AppColors.darkGreyColor
                                        : AppColors.lightGreyColor,
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ValueListenableBuilder(
                                    valueListenable: isPost,
                                    builder: (context, val, _) {
                                      return Checkbox(
                                        value: isPost.value,
                                        onChanged: (value) =>
                                            isPost.value = !isPost.value,
                                      );
                                    },
                                  ),
                                  Text(
                                    'Post Only',
                                    style: textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: widget.isDarkMode.value
                                          ? AppColors.darkGreyColor
                                          : AppColors.lightGreyColor,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  SvgPicture.asset(
                                    AssetsPath.infoIcon,
                                    color: widget.isDarkMode.value
                                        ? AppColors.darkGreyColor
                                        : AppColors.lightGreyColor,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 13, top: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total',
                                    style: textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: widget.isDarkMode.value
                                          ? AppColors.darkGreyColor
                                          : AppColors.lightGreyColor,
                                    ),
                                  ),
                                  Text(
                                    '0.00',
                                    style: textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: widget.isDarkMode.value
                                          ? AppColors.darkGreyColor
                                          : AppColors.lightGreyColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.greenColor,
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.gradientColor1,
                                      AppColors.gradientColor2,
                                      AppColors.gradientColor3,
                                    ],
                                  ),
                                  boxShadow: widget.isDarkMode.value
                                      ? null
                                      : [
                                          BoxShadow(
                                            color: AppColors.blackColor
                                                .withOpacity(0.2),
                                            blurRadius: 1.1,
                                            offset: const Offset(0, 1.5),
                                          ),
                                        ],
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: FittedBox(
                                      child: Text(
                                        'Buy BTC',
                                        textScaleFactor: 1,
                                        style: textTheme.labelMedium,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Divider(
                              color: widget.isDarkMode.value
                                  ? AppColors.greenColor4
                                  : AppColors.lightStrokeColor,
                              thickness: 1.3,
                            ),
                            const SizedBox(height: 11),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total account value',
                                      style: textTheme.titleSmall!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: widget.isDarkMode.value
                                            ? AppColors.darkGreyColor
                                            : AppColors.lightGreyColor,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      '0.00',
                                      style: textTheme.titleMedium!.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: widget.isDarkMode.value
                                            ? AppColors.whiteColor
                                            : AppColors.darkBgColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'NGN',
                                      style: textTheme.titleSmall!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: widget.isDarkMode.value
                                            ? AppColors.darkGreyColor
                                            : AppColors.lightGreyColor,
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 15,
                                      color: widget.isDarkMode.value
                                          ? AppColors.darkGreyColor
                                          : AppColors.lightGreyColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Open Orders',
                                      style: textTheme.titleSmall!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: widget.isDarkMode.value
                                            ? AppColors.darkGreyColor
                                            : AppColors.lightGreyColor,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      '0.00',
                                      style: textTheme.titleMedium!.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: widget.isDarkMode.value
                                            ? AppColors.whiteColor
                                            : AppColors.darkBgColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Available',
                                      style: textTheme.titleSmall!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: widget.isDarkMode.value
                                            ? AppColors.darkGreyColor
                                            : AppColors.lightGreyColor,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      '0.00',
                                      style: textTheme.titleMedium!.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: widget.isDarkMode.value
                                            ? AppColors.whiteColor
                                            : AppColors.darkBgColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 30.h),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: 78.w,
                                height: 33,
                                child: CustomButton(
                                  onPressed: () {},
                                  color: AppColors.blueColor,
                                  label: 'Deposit',
                                ),
                              ),
                            ),
                          ],
                        ],
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class InputWidgetTextField extends StatelessWidget {
  const InputWidgetTextField({
    super.key,
    required this.textEditingController,
    required this.isDarkMode,
  });

  final TextEditingController textEditingController;
  final ValueNotifier<bool> isDarkMode;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TextField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      controller: textEditingController,
      textAlign: TextAlign.right,
      cursorColor:
          isDarkMode.value ? AppColors.whiteColor : AppColors.darkGreyColor,
      cursorHeight: 15.h,
      style: textTheme.bodyMedium!.copyWith(
        color: isDarkMode.value ? AppColors.whiteColor : AppColors.blackColor,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.3,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(bottom: 16),
        border: InputBorder.none,
        hintText: '0.00 USD',
        hintStyle: textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w500,
          color: isDarkMode.value
              ? AppColors.darkGreyColor
              : AppColors.lightGreyColor,
        ),
      ),
    );
  }
}

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key,
    required this.isDarkMode,
    required this.fieldLabel,
    required this.child,
  });

  final ValueNotifier<bool> isDarkMode;
  final String fieldLabel;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mqr = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 13),
      width: mqr.width,
      height: 50.h,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: isDarkMode.value
              ? AppColors.greenColor4
              : AppColors.lightStrokeColor,
        ),
        borderRadius: BorderRadius.circular(8),
        color: Colors.transparent,
      ),
      child: Row(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                fieldLabel,
                style: textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isDarkMode.value
                      ? AppColors.darkGreyColor
                      : AppColors.lightGreyColor,
                ),
              ),
              const SizedBox(width: 4),
              SvgPicture.asset(
                AssetsPath.infoIcon,
                color: isDarkMode.value
                    ? AppColors.darkGreyColor
                    : AppColors.lightGreyColor,
              ),
            ],
          ),
          SizedBox(width: 30.w),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}

class SelectionButton extends StatelessWidget {
  const SelectionButton({
    super.key,
    required this.buttonLabel,
    required this.isDarkMode,
    required this.isSelected,
    required this.onTap,
    this.child,
  });

  final String buttonLabel;
  final ValueNotifier<bool> isDarkMode;
  final bool isSelected;
  final VoidCallback? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        backgroundColor: isDarkMode.value
            ? isSelected
                ? AppColors.greenColor3
                : AppColors.transparentColor
            : isSelected
                ? AppColors.greyColor
                : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: child ??
          Text(
            buttonLabel,
            style: textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w500,
              color: isDarkMode.value
                  ? isSelected
                      ? AppColors.whiteColor
                      : AppColors.darkGreyColor
                  : isSelected
                      ? AppColors.darkBgColor
                      : AppColors.lightGreyColor,
            ),
          ),
    );
  }
}
