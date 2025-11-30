import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/unit_converter/widgets/converter_drop_down.dart';
import 'package:bikretaa/features/unit_converter/widgets/converter_input_feild.dart';
import 'package:bikretaa/features/unit_converter/widgets/white_card_converter.dart';
import 'package:converter/converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnitConverterScreen extends StatefulWidget {
  const UnitConverterScreen({super.key});

  @override
  State<UnitConverterScreen> createState() => _UnitConverterScreenState();
}

class _UnitConverterScreenState extends State<UnitConverterScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _fromUnit = 'kg';
  String _toUnit = 'g';
  String _result = '';
  String _selectedType = 'Mass';

  final Map<String, List<String>> _unitTypes = {
    'Length': ['m', 'km', 'cm', 'mm', 'in', 'ft', 'yd'],
    'Mass': ['kg', 'g', 'mg', 'lb', 'oz', 't'],
    'Volume': ['L', 'mL', 'gal', 'qt', 'pt', 'cup'],
    'Time': ['s', 'min', 'h', 'd'],
    'Temperature': ['C', 'F', 'K'],
    'Area': [
      'm2',
      'dm2',
      'cm2',
      'mm2',
      'µm2',
      'dam2',
      'hm2',
      'ha',
      'km2',
      'Mm2',
      'in2',
      'ft2',
      'mi2',
      'ac',
    ],
  };

  void convert() {
    if (_inputController.text.isEmpty) return;
    double value = double.tryParse(_inputController.text) ?? 0;
    String resultText = '';

    try {
      switch (_selectedType) {
        case 'Length':
          final c = Length(value, _fromUnit);
          resultText =
              "$value $_fromUnit = ${c.valueIn(_toUnit).toStringAsFixed(2)} $_toUnit";
          break;
        case 'Mass':
          final c = Mass(value, _fromUnit);
          resultText =
              "$value $_fromUnit = ${c.valueIn(_toUnit).toStringAsFixed(2)} $_toUnit";
          break;
        case 'Volume':
          final c = Volume(value, _fromUnit);
          resultText =
              "$value $_fromUnit = ${c.valueIn(_toUnit).toStringAsFixed(2)} $_toUnit";
          break;
        case 'Time':
          final c = Time(value, _fromUnit);
          resultText =
              "$value $_fromUnit = ${c.valueIn(_toUnit).toStringAsFixed(2)} $_toUnit";
          break;
        case 'Temperature':
          final c = Temperature(value, _fromUnit);
          resultText =
              "$value $_fromUnit = ${c.valueIn(_toUnit).toStringAsFixed(2)} $_toUnit";
          break;
        case 'Area':
          final c = Area(value, _fromUnit);
          resultText =
              "$value $_fromUnit = ${c.valueIn(_toUnit).toStringAsFixed(2)} $_toUnit";
          break;
      }
    } catch (e) {
      resultText = "conversion_error".tr;
    }

    setState(() {
      _result = resultText;
    });
  }

  void clearInput() {
    _inputController.clear();
    setState(() {
      _result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: theme.appBarTheme.elevation,
        title: Text(
          "unit_converter".tr,
          style: TextStyle(
            fontSize: r.fontXL(),
            fontWeight: FontWeight.bold,
            color: theme.appBarTheme.foregroundColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(r.paddingMedium()),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Dropdown
                WhiteCard(
                  child: Custom_Dropdown(
                    label: "category".tr, // Category / ধরন
                    value: _selectedType,
                    items: _unitTypes.keys.toList(),
                    onChanged: (v) {
                      setState(() {
                        _selectedType = v!;
                        _fromUnit = _unitTypes[v]!.first;
                        _toUnit = _unitTypes[v]!.last;
                        _result = '';
                      });
                    },
                  ),
                ),

                SizedBox(height: r.height(0.02)),

                // Input Field
                WhiteCard(
                  child: ConverterInputFeild(
                    controller: _inputController,
                    label: "enter_value".tr, // Enter Value / মান লিখুন
                    onClear: clearInput,
                  ),
                ),

                SizedBox(height: r.height(0.02)),

                // From / To Dropdowns
                Row(
                  children: [
                    Expanded(
                      child: WhiteCard(
                        child: Custom_Dropdown(
                          label: "from".tr, // From / থেকে
                          value: _fromUnit,
                          items: _unitTypes[_selectedType]!,
                          onChanged: (v) => setState(() => _fromUnit = v!),
                        ),
                      ),
                    ),
                    SizedBox(width: r.width(0.02)),
                    Text(
                      "→",
                      style: TextStyle(
                        fontSize: r.fontXXL(),
                        fontWeight: FontWeight.bold,
                        color: theme.brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    SizedBox(width: r.width(0.02)),
                    Expanded(
                      child: WhiteCard(
                        child: Custom_Dropdown(
                          label: "to".tr, // To / এ
                          value: _toUnit,
                          items: _unitTypes[_selectedType]!,
                          onChanged: (v) => setState(() => _toUnit = v!),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: r.height(0.03)),

                // Convert Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: convert,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          theme.elevatedButtonTheme.style?.backgroundColor
                              ?.resolve({}) ??
                          Colors.blue,
                      foregroundColor:
                          theme.elevatedButtonTheme.style?.foregroundColor
                              ?.resolve({}) ??
                          Colors.white,
                    ),
                    child: Text(
                      "convert".tr, // Convert / রূপান্তর
                      style: theme.textTheme.titleSmall?.copyWith(
                        color:
                            theme.elevatedButtonTheme.style?.foregroundColor
                                ?.resolve({}) ??
                            Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: r.height(0.04)),

                if (_result.isNotEmpty)
                  WhiteCard(
                    child: Center(
                      child: Text(
                        _result,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: r.fontLarge(),
                          color: theme.brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
