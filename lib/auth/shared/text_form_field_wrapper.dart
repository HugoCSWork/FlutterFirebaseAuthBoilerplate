import 'package:flutter/material.dart';

class TextFormFieldWrapper extends StatelessWidget {
  final String title;
  final Widget child;
  const TextFormFieldWrapper({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(title), child],
    );
  }
}
