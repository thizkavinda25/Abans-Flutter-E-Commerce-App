import 'package:flutter/material.dart';
import '../utils/custom_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isOutlineButton;
  final VoidCallback onTap;
  const CustomButton({
    super.key,
    required this.text,
    this.isOutlineButton = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    const baseWidth = 375.0;
    final scale = ((mq.size.width / baseWidth).clamp(0.8, 1.2));

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15 * scale),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 13 * scale),
        decoration: BoxDecoration(
          border: Border.all(
            width: isOutlineButton ? 1.0 * scale : 0.0,
            color: CustomColors.primaryColor,
          ),
          color: isOutlineButton ? Colors.white : CustomColors.primaryColor,
          borderRadius: BorderRadius.circular(10 * scale),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15 * scale,
              color: isOutlineButton ? CustomColors.primaryColor : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
