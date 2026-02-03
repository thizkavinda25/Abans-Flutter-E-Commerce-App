import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController? controller;
  final bool isPassword;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final String? prefixText;
  final int? minLines;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.controller,
    this.isPassword = false,
    this.maxLength,
    this.maxLines,

    this.minLines,
    this.keyboardType,
    this.prefixText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObsecureText = true;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    const baseWidth = 375.0;
    final scale = ((mq.size.width / baseWidth).clamp(0.8, 1.2));

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.labelText, style: TextStyle(fontSize: 14 * scale)),
          SizedBox(height: 5 * scale),
          TextField(
            controller: widget.controller,
            obscureText: widget.isPassword && isObsecureText,
            maxLines: widget.isPassword ? 1 : widget.maxLines,
            maxLength: widget.maxLength,
            minLines: widget.isPassword ? 1 : widget.minLines,
            keyboardType: widget.keyboardType,
            style: TextStyle(fontSize: 14 * scale),

            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade100,
              prefixText: widget.prefixText,
              contentPadding: EdgeInsets.symmetric(
                vertical: 12 * scale,
                horizontal: 12 * scale,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8 * scale),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8 * scale),
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isObsecureText = !isObsecureText;
                        });
                      },
                      icon: Icon(
                        isObsecureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey.shade600,
                        size: 20 * scale,
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
