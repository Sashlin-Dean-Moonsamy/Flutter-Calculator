import 'package:flutter/material.dart';
import '../controllers/calculator_controller.dart';
import '../widgets/button_grid.dart';
import '../widgets/display.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorController controller = CalculatorController();

  @override
  void initState() {
    super.initState();
    controller.loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Display(value: controller.displayText),
          Expanded(child: ButtonGrid(onButtonPressed: (text) {
            setState(() {
              controller.buttonPressed(text);
            });
          })),
        ],
      ),
    );
  }
}
