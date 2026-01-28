import 'package:flutter/material.dart';

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
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    // Initialize obscureText to true if it's a password field
    obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white, fontSize: 16),
      decoration: InputDecoration(
        hintText: widget.placeholder,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  size: 24,
                ),
              )
            : const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(Icons.alternate_email, size: 24),
              ),
        suffixIconColor: Colors.white38,
      ),
      controller: widget.controller,
      obscureText: widget.isPassword && obscureText,
    );
  }
}
