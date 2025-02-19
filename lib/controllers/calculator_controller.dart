import 'package:calculator/models/calculation.dart';

import '../database/db_helper.dart';
import '../utils/expression_parser.dart';

class CalculatorController {
  String displayText = '0';
  List<Calculation> history = [];
  final DBHelper dbHelper = DBHelper();

  Future<void> loadHistory() async {
    history = await dbHelper.getHistory();
    print(history);
  }

  void buttonPressed(String buttonText) {
    if (displayText == 'Error') {
      displayText = buttonText;
    } else if (buttonText == 'C') {
      displayText = '0';
    } else if (buttonText == '=') {
      try {
        String result = ExpressionParser.evaluateExpression(displayText) as String;
        String calculationEntryString = "$displayText = $result";

        // Create Calculation Model Object
        Calculation calculationEntry = Calculation(
          expression: displayText,
          result: result,
          timestamp: DateTime.now(),
        );

        // Insert into database and update the history
        dbHelper.insertCalculation(calculationEntry);
        history.insert(0, calculationEntry); // Store it in the controller's history list

        displayText = calculationEntryString;
      } catch (e) {
        displayText = "Error";
        print("Error: $e");
      }
    } else if (buttonText == '⌫') {
      displayText = displayText.length > 1
          ? displayText.substring(0, displayText.length - 1)
          : '0';
    } else {
      displayText = (displayText == "0") ? buttonText : displayText + buttonText;
    }
  }
}
