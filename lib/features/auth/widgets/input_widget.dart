import 'package:flutter/material.dart';
import 'package:rename/platform_file_editors/ios_platform_file_editor.dart';

class LoginInputWidget extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String placeholder;
  final bool isPassword;
  const LoginInputWidget(
      {super.key,
      required this.label,
      required this.placeholder,
      required this.controller,
      this.isPassword = false});

  @override
  State<LoginInputWidget> createState() => _LoginInputWidgetState();
}

class _LoginInputWidgetState extends State<LoginInputWidget> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          labelText: widget.label,
          hintText: widget.placeholder,
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: showPassword
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.password),
                )
              : const Icon(Icons.mail),
          suffixIconColor: Colors.white),
      controller: widget.controller,
      obscureText: showPassword,
      obscuringCharacter: '⨌',
    );
  }
}
