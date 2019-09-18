import 'package:flutter/material.dart';

class StreamInputTextField extends StatelessWidget {
  final String hint;
  final String helperText;
  final bool obscure;
  final Stream<String> stream;
  final Function(String) onChanged;
  final TextEditingController controller;

  StreamInputTextField({
    this.hint,
    this.helperText,
    this.obscure = false,
    @required this.stream,
    @required this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: stream,
        initialData: '',
        builder: (context, snapshot) {
          return TextField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              helperText: helperText,
              hintText: hint,
              errorText: snapshot.hasError ? snapshot.error : null,
            ),
            obscureText: obscure,
          );
        });
  }
}
