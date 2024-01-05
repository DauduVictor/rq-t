import 'package:flutter/material.dart';
import 'package:roqqu_test/theme/theme.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final Color labelColor;
  final Color color;
  final Widget? child;
  final double verticalPadding;

  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.labelColor = AppColors.whiteColor,
    this.child,
    required this.color,
    this.verticalPadding = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TextButton(
      style: TextButton.styleFrom(
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FittedBox(
              child: child ??
                  Text(
                    label,
                    textScaleFactor: 1,
                    style: textTheme.labelMedium,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
