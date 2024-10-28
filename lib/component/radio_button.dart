import 'package:flutter/material.dart';
import '../screen_adaptation.dart';

class RadioButton extends StatelessWidget {
  final bool isChecked;
  final String title;
  final Function(bool)? onValueChanged;

  const RadioButton({
    super.key,
    required this.isChecked,
    required this.title,
    this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onValueChanged?.call(!isChecked);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(isChecked
              ? Icons.radio_button_checked
              : Icons.radio_button_unchecked),
          SizedBox(
            width: 2.px,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.px,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
