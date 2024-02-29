import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DynamicProgressIndicator extends StatefulWidget {
  final void Function(bool) onCalCompletionChanged;
  const DynamicProgressIndicator({super.key, required this.onCalCompletionChanged});

  @override
  _DynamicProgressIndicatorState createState() => _DynamicProgressIndicatorState();
}

class _DynamicProgressIndicatorState extends State<DynamicProgressIndicator> with TickerProviderStateMixin {
  late AnimationController _controller;
  double _percent = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {
          _percent = _controller.value * 100;
        });
        if (_percent >= 100) {
          widget.onCalCompletionChanged(true);
        }
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularPercentIndicator(
        radius: 75.0,
        lineWidth: 7.0,
        percent: _percent / 100,
        header: Text(
          '${_percent.toStringAsFixed(0)}%',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        progressColor: Colors.blue,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
