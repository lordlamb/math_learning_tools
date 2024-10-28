import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_learning_tools/component/radio_button.dart';
import 'calculation.dart';
import 'screen_adaptation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenAdaptation(
      child: MaterialApp(
        builder: (context, child) => const Material(
          child: Calculation(),
        ),
      ),
    );
  }
}
