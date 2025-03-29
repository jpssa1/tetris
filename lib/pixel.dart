import 'package:flutter/material.dart';

class Pixel extends StatelessWidget {
  final cor;

  const Pixel({
    super.key,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: cor, borderRadius: BorderRadius.circular(4)),
      margin: EdgeInsets.all(2),
      child: Center(),
    );
  }
}
