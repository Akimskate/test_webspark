import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_webspark/bloc/app_bloc.dart';
import 'package:test_webspark/bloc/app_event.dart';
import 'package:test_webspark/bloc/app_state.dart';
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
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        // Navigate to process page after request completed successfully
        if (state.postRequestStatus == PostRequestStatus.success && state.responseModel?.error == false) {
          Navigator.pushNamed(context, '/results-list');
        }
      },
      builder: (context, state) {
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
              // Show api exception from try catch postRequest
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    state.errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
              // Show error from server response message
              if (state.responseModel?.error == true)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      state.responseModel!.message.toString(),
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Visibility(
            visible: _isCalCompleted,
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(10),
              child: FilledButton(
                onPressed: (state.postRequestStatus != PostRequestStatus.loading)
                    ? () {
                        context.read<AppBloc>().add(OnCalculateEvent());
                        context.read<AppBloc>().add(OnPostRequestEvent());
                      }
                    : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Send results to server'),
                    // Show circular progress indicator while processing request
                    state.postRequestStatus == PostRequestStatus.loading
                        ? Transform.scale(
                            scale: 0.5,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          )
                        : const Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
