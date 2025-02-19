// models/calculation.dart

import 'dart:ffi';

class Calculation {
  final int? id;
  final String expression;
  final String result;
  final DateTime timestamp;

  Calculation({ // initialize attributes in field
    this.id,
    required this.expression,
    required this.result,
    required this.timestamp,
  });

  // Convert a HistoryModel into a map for inserting into the database
  Map<String, dynamic> toMap() {
    return {
      'expression': expression,
      'result': result,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  // Convert a map into a HistoryModel object
  factory Calculation.fromMap(Map<String, dynamic> map) {
    return Calculation(
      id: map['id'],
      expression: map['expression'],
      result: map['result'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
