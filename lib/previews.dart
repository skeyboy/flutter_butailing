import 'package:flutter/widget_previews.dart';
import 'package:flutter/material.dart'; // For Material widgets

@Preview(name: 'My Sample Text')
Widget mySampleText() {
  return const Text('Hello, World!');
}

@Preview(name: 'My Sample LinearProgressIndicator')
Widget mySampleProgress() {
  return const LinearProgressIndicator(
    value: 8 / 9,
    semanticsLabel: "semanticsLabel",
    semanticsValue: "0.1",
  );
}

@Preview(name: "indicator")
Widget mySample() {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.greenAccent, width: 1),
    ),
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.greenAccent, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "123 Mb/s" ?? '',
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
    ),
  );
}
