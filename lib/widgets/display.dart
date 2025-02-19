import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  final String value;

  const Display({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.centerRight,
      height: 100,
      child: Text(value, style: const TextStyle(fontSize: 40)),
    );
  }
}
