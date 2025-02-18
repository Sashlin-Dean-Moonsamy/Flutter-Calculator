import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

// Button List with Icons
const List<dynamic> buttons = [
  {'text': 'C', 'icon': null},
  {'text': '⌫', 'icon': Icons.backspace},
  {'text': '%', 'icon': null},
  {'text': '÷', 'icon': null},

  {'text': '7', 'icon': null},
  {'text': '8', 'icon': null},
  {'text': '9', 'icon': null},
  {'text': '×', 'icon': Icons.close},

  {'text': '4', 'icon': null},
  {'text': '5', 'icon': null},
  {'text': '6', 'icon': null},
  {'text': '-', 'icon': Icons.remove},

  {'text': '1', 'icon': null},
  {'text': '2', 'icon': null},
  {'text': '3', 'icon': null},
  {'text': '+', 'icon': Icons.add},

  {'text': '00', 'icon': null},
  {'text': '0', 'icon': null},
  {'text': '.', 'icon': null},
  {'text': '=', 'icon': null},
];

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String displayText = '0';

  void _buttonPressed(String buttonText) {
    setState(() {
      if (displayText == 'Error') {
        displayText = buttonText;
      } else if (buttonText == 'C') {
        displayText = '0'; // Clear display
      } else if (buttonText == '=') {
        // Handle calculation
        try {
          displayText = evaluateExpression(displayText).toString();
        } catch (e) {
          displayText = "Error"; // Handle invalid expression
        }
      } else if (buttonText == '⌫') {
        displayText = displayText.substring(0, displayText.length - 1);
      } else {
        if (displayText == "0") {
          displayText = buttonText; // If display is '0', replace it
        } else {
          displayText += buttonText; // Add the button text to the display
        }
      }
    });
  }

  // Function to evaluate the mathematical expression
  double evaluateExpression(String expression) {
    // Replace custom symbols with their mathematical equivalents
    expression = expression
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('%', '/100'); // Replace symbols

    try {
      // Create an expression using the string
      final expressionObj = Expression.parse(expression);

      // Evaluate the expression and return the result
      final evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expressionObj, {});

      return result.toDouble();
    } catch (e) {
      // Handle errors like invalid expression
      print("Error: $e");
      return double.nan; // Return NaN if the expression is invalid
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: Scaffold(
        body: Column(
          children: [
            Container(
              // Display
              padding: const EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              height: 150,
              child: Text(displayText, style: const TextStyle(fontSize: 40),),
            ),

            Expanded(
              // Buttons
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  return CalculatorButton(
                    buttons[index],
                    onPressed: _buttonPressed,
                  );
                },
                itemCount: buttons.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final Map<String, dynamic> button;
  final void Function(String) onPressed;

  const CalculatorButton(this.button, {super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed(button['text']);
      },
      child: Center(
        child:
        button['icon'] != null
            ? Icon(button['icon'], size:36)
            : Text(button['text'], style: const TextStyle(fontSize: 24),),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
