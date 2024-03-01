import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_webspark/bloc/app_bloc.dart';
import 'package:test_webspark/bloc/app_event.dart';
import 'package:test_webspark/presentation/process/widgets/dynamic_circular_indicator.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({super.key});

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  bool _isCalCompleted = false;

  void onCalCompletionChanged(bool value) {
    setState(() {
      _isCalCompleted = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Process page"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isCalCompleted)
            const Text(
              "All calculation is finished, you can\nsend results to server.",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          if (_isCalCompleted == false)
            const Text(
              "Calculating...",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          DynamicProgressIndicator(
            onCalCompletionChanged: onCalCompletionChanged,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Visibility(
        visible: _isCalCompleted,
        child: Container(
          height: 50,
          width: 350,
          margin: const EdgeInsets.all(10),
          child: FilledButton(
            onPressed: () {
              Navigator.pushNamed(context, '/results-list');
              context.read<AppBloc>().add(OnCalculateEvent());
            },
            child: const Text('Send results to server'),
          ),
        ),
      ),
    );
  }
}
