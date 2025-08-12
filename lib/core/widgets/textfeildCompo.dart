import 'package:flutter/material.dart';
import '../theme/colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final void Function(String?)? onChange;
  final bool isPassword;
  final bool readOnly;
  final void Function()? onTap;
  final double borderRadius;
  final Color borderColor;
  final bool enabled;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;

  CustomTextField({
    Key? key,
    required this.hintText,
    this.prefixIcon,
    this.controller,
    this.onChange,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.readOnly = false,
    this.onTap,
    required this.borderRadius,
    required this.borderColor,
    this.enabled = true,
    this.textInputAction,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        onChanged: widget.onChange,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword && !_isPasswordVisible,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        enabled: widget.enabled,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(color: widget.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(color: widget.borderColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(color: widget.borderColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: const BorderSide(color: Colors.red),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: AppColors.smallTextColor),
          prefixIcon: Icon(widget.prefixIcon, color: widget.borderColor),
          suffixIcon: widget.isPassword
              ? GestureDetector(
            onTap: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
            child: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: widget.borderColor,
            ),
          )
              : null,
        ),
        validator: widget.validator,
      ),
    );
  }
}
