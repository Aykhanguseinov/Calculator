import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор',
      theme: ThemeData(
      ),
      home: const CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String _display = '0';
  String _operation = '';
  double? _operand1;
  bool _isPressed = false;

  void _onPressed(String buttonText) {
    setState(() {
      if (buttonText == '=') {
        _calculateResult();
      } else if (buttonText == 'C') {
        _clearDisplay();
      } else if (buttonText == '<') {
      } else if (buttonText == '+' || buttonText == '-' || buttonText == '*' ||
          buttonText == '/' || buttonText == '^' || buttonText == '√') {
        _setOperation(buttonText);
      } else if (buttonText == '.') {
        _appendDot();
      } else {
        _appendDigit(buttonText);
      }
    });
  }

  void _appendDigit(String digit) {
    if (_display == '0' || _display == 'Ошибка: деление на ноль') {
      _display = digit;
    } else {
      _display += digit;
    }
  }

  void _appendDot() {
    if (_display.isEmpty) {
      _display = '0.';
      return; 
    }

    if (_display.isNotEmpty &&
        (_display.endsWith('+') ||
            _display.endsWith('-') ||
            _display.endsWith('*') ||
            _display.endsWith('/') ||
            _display.endsWith('^') ||
            _display.endsWith('√') ||
            _display.endsWith('.'))) {
      return; 
    }

    for (int i = _display.length - 1; i >= 0; i--) {
      if (_display[i] == '+' ||
          _display[i] == '-' ||
          _display[i] == '*' ||
          _display[i] == '/' ||
          _display[i] == '^' ||
          _display[i] == '√') {
        break; 
      }
      if (_display[i] == '.') {
        return; 
      }
    }

    _display += '.'; 
  }

  void _setOperation(String operation) {
    if (_operation.isNotEmpty) {
      _calculateResult();
    }
    _operand1 = double.tryParse(_display);
    _operation = operation;
    _display += ' $operation ';
  }

  void _calculateResult() {
    if (_operation.isEmpty) return;
    double operand2 = double.tryParse(_display.substring(_display.lastIndexOf(' ') + 1)) ?? 0;
    if (_operation == '+') {                 
      _display = (_operand1! + operand2).toString();
    } else if (_operation == '-') {
      _display = (_operand1! - operand2).toString();
    } else if (_operation == '*') {
      _display = (_operand1! * operand2).toString();
    } else if (_operation == '/') {
      if (operand2 == 0) {
        _display = 'Нельзя делить на ноль';
      } else {
        _display = (_operand1! / operand2).toString();
      }
    } else if (_operation == '^') {
      _display = pow(_operand1!, operand2).toString();
    }  else if (_operation =='√') {
      _display = sqrt(_operand1!).toString();
    }
    _operation = '';
    _operand1 = null;
  }

  void _clearDisplay() {
    _display = '0';
    _operation = '';
    _operand1 = null;
  }

  void _deleteLastDigit() {
    if (_display.length > 1) {
      _display = _display.substring(0, _display.length - 1);
    } else {
      _display = '0';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text('Калькулятор'),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.black,
        child : Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                alignment: Alignment.bottomRight,
                child: Text(
                  _display,
                  style: const TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButton('C', Colors.grey),
                      _buildButton('√', Colors.grey),
                      _buildButton('^', Colors.grey),
                      _buildButton('/', Colors.orange),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButton('7', const Color.fromARGB(255, 55, 55, 55)),
                      _buildButton('8', const Color.fromARGB(255, 55, 55, 55)),
                      _buildButton('9', const Color.fromARGB(255, 55, 55, 55)),
                      _buildButton('*', Colors.orange),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButton('4', const Color.fromARGB(255, 55, 55, 55)),
                      _buildButton('5', const Color.fromARGB(255, 55, 55, 55)),
                      _buildButton('6', const Color.fromARGB(255, 55, 55, 55)),
                      _buildButton('-', Colors.orange),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButton('1', const Color.fromARGB(255, 55, 55, 55)),
                      _buildButton('2', const Color.fromARGB(255, 55, 55, 55)),
                      _buildButton('3', const Color.fromARGB(255, 55, 55, 55)),
                      _buildButton('+', Colors.orange),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButton('0', const Color.fromARGB(255, 55, 55, 55)),
                      _buildButton('.', const Color.fromARGB(255, 55, 55, 55)),
                      _buildButton('<', const Color.fromARGB(255, 55, 55, 55)),
                      _buildButton('=', Colors.orange),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String buttonText, Color color) {
    return ElevatedButton(
      onPressed: () => _onPressed(buttonText),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(80, 80),
        shape: const CircleBorder(),
        textStyle: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Text(
        buttonText,
        style: const TextStyle( 
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.white, 
        ),
      ),
    );
  }
}