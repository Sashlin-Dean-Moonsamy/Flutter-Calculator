import 'package:expressions/expressions.dart';

class ExpressionParser {
  static double evaluateExpression(String expression) {
    expression = expression
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('%', '/100');

    try {
      final expressionObj = Expression.parse(expression);
      final evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expressionObj, {});
      return result.toDouble();
    } catch (e) {
      print("Error: $e");
      return double.nan;
    }
  }
}
