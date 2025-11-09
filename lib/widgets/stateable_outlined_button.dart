import 'package:flutter/material.dart';
import 'package:flutter_butailing/model/index.dart';

typedef StateableOutlinedButtonCallback = Function(VideoTypeList);

class StateableOutlinedButton extends StatefulWidget {
  final VideoTypeList item;
  final StateableOutlinedButtonCallback? callback;
  // ignore: prefer_typing_uninitialized_variables
  final isHightlight;
  const StateableOutlinedButton({
    super.key,
    required this.isHightlight,
    required this.item,
    this.callback,
  });

  @override
  State<StateableOutlinedButton> createState() =>
      _StateableOutlinedButtonState();
}

class _StateableOutlinedButtonState extends State<StateableOutlinedButton> {
  bool get checked => widget.isHightlight;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          widget.callback!(widget.item);
        });
      },
      child: Text(
        widget.item.title,
        style: TextStyle(
          fontSize: 22,
          color: checked ? Colors.red : Colors.black,
          fontWeight: checked ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
