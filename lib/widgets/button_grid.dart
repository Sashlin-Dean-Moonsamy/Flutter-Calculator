import 'package:flutter/material.dart';

const List<dynamic> buttons = [
  {'text': 'C', 'icon': null},
  {'text': '⌫', 'icon': Icons.backspace},
  {'text': '%', 'icon': null},
  {'text': '÷', 'icon': null},
  {'text': '7', 'icon': null},
  {'text': '8', 'icon': null},
  {'text': '9', 'icon': null},
  {'text': '×', 'icon': null},
  {'text': '4', 'icon': null},
  {'text': '5', 'icon': null},
  {'text': '6', 'icon': null},
  {'text': '-', 'icon': null},
  {'text': '1', 'icon': null},
  {'text': '2', 'icon': null},
  {'text': '3', 'icon': null},
  {'text': '+', 'icon': null},
  {'text': '00', 'icon': null},
  {'text': '0', 'icon': null},
  {'text': '.', 'icon': null},
  {'text': '=', 'icon': null},
];

class ButtonGrid extends StatelessWidget {
  final void Function(String) onButtonPressed;

  const ButtonGrid({Key? key, required this.onButtonPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.7,
      ),
      itemCount: buttons.length,
      itemBuilder: (context, index) {
        final button = buttons[index];
        return GestureDetector(
          onTap: () => onButtonPressed(button['text']),
          child: Center(
            child: button['icon'] != null
                ? Icon(button['icon'], size: 36)
                : Text(button['text'], style: const TextStyle(fontSize: 24)),
          ),
        );
      },
    );
  }
}
