import 'package:flutter/material.dart';

class VerticalSpacer extends StatelessWidget {
  final double height;
  const VerticalSpacer([this.height = 15, Key? key]) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
