import 'package:bikretaa/features/calculator/widgets/calculator_btn_widget.dart';
import 'package:flutter/material.dart';

class CalculatorButtonsGrid extends StatelessWidget {
  final List<String> buttons;
  final List<Color> buttonColors;
  final void Function(String) onButtonPress;

  const CalculatorButtonsGrid({
    super.key,
    required this.buttons,
    required this.buttonColors,
    required this.onButtonPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double horizontalPadding = 2;
          double verticalPadding = 2;
          double buttonWidth =
              (constraints.maxWidth - 3 * horizontalPadding * 4) / 4;
          double buttonHeight =
              (constraints.maxHeight - 4 * verticalPadding * 5) / 5;

          return Column(
            children: List.generate(5, (row) {
              return Row(
                children: List.generate(4, (col) {
                  int index = row * 4 + col;
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding,
                    ),
                    child: SizedBox(
                      width: buttonWidth,
                      height: buttonHeight,
                      child: CalculatorButton(
                        text: buttons[index],
                        color: buttonColors[index],
                        onTap: () => onButtonPress(buttons[index]),
                      ),
                    ),
                  );
                }),
              );
            }),
          );
        },
      ),
    );
  }
}
