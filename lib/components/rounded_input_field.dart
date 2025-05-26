import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final double borderRadius;
  final TextEditingController? controller;
  final IconButton? suffixIcon;
  final Icon? preicon;
  final Icon? suficon;
  final double height;

  const RoundedInputField({
    Key? key,
    required this.labelText,
    required this.obscureText,
    this.borderRadius = 10.0,
    this.height=16.0,
    this.controller,
    this.suffixIcon,
    this.suficon,
    this.preicon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.white,
        border: Border.all(
          color: Colors.blue,
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12,),
          Expanded(
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                icon:preicon,
                suffixIcon: suficon,
                labelText: labelText,
                contentPadding:  EdgeInsets.all(height),
                border: InputBorder.none,
              ),
            ),
          ),
          if (suffixIcon != null) suffixIcon!,
        ],
      ),
    );
  }
}
