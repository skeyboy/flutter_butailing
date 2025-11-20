import 'package:flutter/material.dart';
import 'package:flutter_butailing/widgets/height_measure_widget.dart';

class HeightMeasureState extends State<HeightMeasureWidget> {
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureHeight();
    });
  }

  void _measureHeight() {
    final RenderBox? renderBox =
        _key.currentContext!.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      widget.onHeightChanged(renderBox.size.height);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(key: _key, child: widget.child);
  }
}

class AutoHeightPageView extends StatefulWidget {
  final List<Widget> children;
  final PageController pageController;
  final Duration duration;
  const AutoHeightPageView({
    super.key,
    required this.children,
    required this.pageController,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  AutoHeightPageViewState createState() => AutoHeightPageViewState();
}

class AutoHeightPageViewState extends State<AutoHeightPageView> {
  final List<double> _heights = [];
  double _currentHeight = 0;

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(_updateHeight);
  }

  void _updateHeight() {
    if (widget.pageController.position.haveDimensions && _heights.isNotEmpty) {
      double page = widget.pageController.page ?? 0.0;
      int index = page.floor();
      int nextIndex = (index + 1) < _heights.length ? index + 1 : index;
      double percent = page - index;
      double height =
          _heights[index] + (_heights[nextIndex] - _heights[index]) * percent;
      setState(() {
        _currentHeight = height;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var isMeasureHeight = _heights.length == widget.children.length
        ? false
        : true;
    return Column(
      children: [
        Stack(
          children: [
            Visibility(
              visible: isMeasureHeight,
              child: Stack(
                children: widget.children
                    .map(
                      (e) => HeightMeasureWidget(
                        child: e,
                        onHeightChanged: (height) {
                          _heights.add(height);
                          if (_heights.length == widget.children.length) {
                            setState(() {
                              _currentHeight = _heights[0];
                            });
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
            if (!isMeasureHeight)
              AnimatedContainer(
                duration: widget.duration,
                height: _currentHeight,
                curve: Curves.easeOut,
                child: PageView(
                  controller: widget.pageController,
                  children: widget.children,
                ),
              ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    widget.pageController.dispose();
    super.dispose();
  }
}
