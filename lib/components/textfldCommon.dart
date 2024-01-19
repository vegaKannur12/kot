
import 'package:flutter/material.dart';

class Widget_TextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueNotifier<bool> obscureNotifier;
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final String? Function(String?) validator;

  Widget_TextField({
    required this.controller,
    required this.obscureNotifier,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: obscureNotifier,
      builder: (context, isObscure, child) {
        return TextFormField(
          controller: controller,
          obscureText: isPassword ? isObscure : false,
          validator: validator,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.only(left: 10.0, top: 15.0, bottom: 15.0),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 119, 119, 119), width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 119, 119, 119), width: 1),
            ),
            prefixIcon: Icon(prefixIcon, size: 16),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      isObscure ? Icons.visibility_off : Icons.visibility,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    onPressed: () {
                      obscureNotifier.value = !isObscure;
                    },
                  )
                : null,
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 14),
          ),
        );
      },
    );
  }
}
