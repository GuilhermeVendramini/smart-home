import 'package:flutter/material.dart';

class StreamInputCheckboxField extends StatelessWidget {
  final Stream<bool> stream;
  final Function(bool) onChanged;
  final bool defaultValue;

  StreamInputCheckboxField({
    @required this.stream,
    @required this.onChanged,
    this.defaultValue = false,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: stream,
        initialData: defaultValue,
        builder: (context, snapshot) {
          return Checkbox(
            value: snapshot.data,
            onChanged: onChanged,
          );
        });
  }
}
