import 'package:flutter/material.dart';
import 'package:flutter_butailing/widgets/auto_height_age_view.dart';

class HeightMeasureWidget extends StatefulWidget {
  final Widget child;
  final Function(double height) onHeightChanged;

  const HeightMeasureWidget({
    super.key,
    required this.child,
    required this.onHeightChanged,
  });

  @override
  HeightMeasureState createState() => HeightMeasureState();
}
