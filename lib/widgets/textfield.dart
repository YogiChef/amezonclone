import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  const InputTextField({
    super.key,
    this.controller,
    required this.icon,
    this.hintText,
    this.isObsecre = false,
    this.enabled = true,
    this.validator,
    this.maxline = 1,
    this.maxlength,
    required this.keyboardType,
  });
  final TextEditingController? controller;
  final IconData icon;
  final String? hintText;
  final bool isObsecre;
  final bool enabled;
  final String? Function(String?)? validator;
  final int maxline;
  final int? maxlength;
  final TextInputType keyboardType;

  @override
  State<InputTextField> createState() => _TextFieldState();
}

class _TextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
      child: TextFormField(
        enabled: widget.enabled,
        controller: widget.controller,
        obscureText: widget.isObsecre,
        validator: widget.validator,
        cursorColor: Colors.deepOrange,
        maxLength: widget.maxlength,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          prefixIcon: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.deepOrange.shade600,
                  borderRadius: BorderRadius.circular(8)),
              child: Icon(
                widget.icon,
                size: 20,
                color: Colors.white,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.transparent,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 2,
                color: Colors.grey.shade300,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 2,
                color: Colors.red,
              )),
          hintText: widget.hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Colors.white,
          filled: true,
          focusColor: Colors.purple,
        ),
      ),
    );
  }
}
