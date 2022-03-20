import 'package:flutter/material.dart';
import 'package:freco_client/ui/widget/style/colors.dart';

class FReCoPushButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;

  FReCoPushButton({Key? key, required this.label, required this.onPressed}) : super(key: key);

  final ButtonStyle _buttonStyle = ElevatedButton.styleFrom( primary: ColorStyle.primaryColor );
  final TextStyle _textStyle = const TextStyle(color: ColorStyle.backgroundColor);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: _buttonStyle,
        onPressed: onPressed,
        child: Text(label, style: _textStyle,)
    );
  }
}