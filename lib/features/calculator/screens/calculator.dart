import 'package:bikretaa/app/controller/calculate_controller/calculator_controller.dart';
import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/calculator/widgets/calculator_btn_grid.dart';
import 'package:bikretaa/features/calculator/widgets/history_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});
  static const name = '/Calculator';

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final CalculatorController controller = Get.put(CalculatorController());
  bool isResultShown = false;

  final List<String> buttons = [
    'C',
    '⌫',
    '%',
    '÷',
    '7',
    '8',
    '9',
    '×',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '.',
    '0',
    '00',
    '=',
  ];

  final List<Color> buttonColors = [
    Colors.blue,
    Colors.blue,
    Colors.blue,
    Colors.blue,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.blue,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.blue,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.blue,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.blue,
  ];

  String history = '';
  String result = '0';

  bool isOperator(String ch) => ['+', '-', '×', '÷', '%'].contains(ch);

  void onButtonPress(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        history = '';
        result = '0';
        isResultShown = false;
      } else if (buttonText == '⌫') {
        if (history.isNotEmpty)
          history = history.substring(0, history.length - 1);
        if (history.isEmpty) result = '0';
        isResultShown = false;
      } else if (buttonText == '=') {
        if (history.isEmpty) return;
        if (!isResultShown) {
          try {
            if (RegExp(r'[×÷+\-]$').hasMatch(history)) {
              result = 'error';
              return;
            }
            String finalExpression = history
                .replaceAll('×', '*')
                .replaceAll('÷', '/');
            Parser p = Parser();
            Expression exp = p.parse(finalExpression);
            ContextModel cm = ContextModel();
            double eval = exp.evaluate(EvaluationType.REAL, cm);
            result = eval.toString();
            controller.addHistory('$history = $result');
            isResultShown = true;
          } catch (e) {
            result = 'error';
          }
        } else {
          history = result;
          result = '0';
          isResultShown = false;
        }
      } else {
        if (history.isEmpty && isOperator(buttonText)) {
          result = 'error';
          return;
        }
        if (history.isNotEmpty &&
            isOperator(buttonText) &&
            isOperator(history[history.length - 1])) {
          result = 'error';
          return;
        }
        if (buttonText == '00' &&
            (history.isEmpty || isOperator(history[history.length - 1]))) {
          result = 'error';
          return;
        }
        if (isResultShown) {
          history = buttonText;
          isResultShown = false;
        } else {
          history += buttonText;
        }
        result = '0';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculator',
          style: TextStyle(
            fontSize: r.fontXL(),
            fontWeight: FontWeight.bold,
            color: theme.appBarTheme.foregroundColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
        actions: [
          IconButton(
            icon: Icon(
              Icons.history,
              size: r.iconMedium(),
              color: theme.iconTheme.color,
            ),
            onPressed: () => Get.to(() => HistoryScreen()),
          ),
        ],
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          // History
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: r.width(0.07)),
              alignment: Alignment.bottomRight,
              child: SingleChildScrollView(
                reverse: true,
                child: Text(
                  history,
                  style: TextStyle(
                    color: theme.textTheme.titleSmall?.color ?? Colors.grey,
                    fontSize: r.fontLarge(),
                  ),
                ),
              ),
            ),
          ),
          // Result
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: r.width(0.06)),
              alignment: Alignment.bottomRight,
              child: SingleChildScrollView(
                reverse: true,
                child: Text(
                  result,
                  style: TextStyle(
                    color: theme.textTheme.titleLarge?.color ?? Colors.white,
                    fontSize: r.fontXXL(),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          // Buttons
          Expanded(
            flex: 6,
            child: CalculatorButtonsGrid(
              buttons: buttons,
              buttonColors: buttonColors,
              onButtonPress: onButtonPress,
            ),
          ),
        ],
      ),
    );
  }
}
