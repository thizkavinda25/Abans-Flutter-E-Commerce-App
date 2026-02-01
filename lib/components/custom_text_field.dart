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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.labelText),
          SizedBox(height: 5),
          TextField(
            controller: widget.controller,
            obscureText: widget.isPassword && isObsecureText,
            maxLines: widget.isPassword ? 1 : widget.maxLines,
            maxLength: widget.maxLength,
            minLines: widget.isPassword ? 1 : widget.minLines,
            keyboardType: widget.keyboardType,

            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade100,
              prefixText: widget.prefixText,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
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
