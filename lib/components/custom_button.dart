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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          border: Border.all(
            width: isOutlineButton ? 1 : 0,
            color: CustomColors.primaryColor,
          ),
          color: isOutlineButton ? Colors.white : CustomColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              color: isOutlineButton ? CustomColors.primaryColor : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
