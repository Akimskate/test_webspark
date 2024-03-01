import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_webspark/bloc/app_bloc.dart';
import 'package:test_webspark/bloc/app_event.dart';
import 'package:test_webspark/bloc/app_state.dart';
import 'package:test_webspark/utils/url_validator/url_validator.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        // Navigate to process page after request completed successfully
        if (state.status == AppStatus.success) {
          Navigator.pushNamed(context, '/process');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Home Page'),
          ),
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  'Set valid API base URL in order to continue',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.sync_alt),
                  SizedBox(
                    width: 320,
                    child: TextFormField(
                        controller: TextEditingController(
                            text: "https://flutter.webspark.dev/flutter/api"), // TODO delete before sending up the task
                        validator: UrlValidator.validateUrl,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (value) {
                          context.read<AppBloc>().add(OnEmailInputChangedEvent(value));
                        },
                        onFieldSubmitted: (value) {
                          context.read<AppBloc>().add(OnGetRequestEvent());
                        }),
                  ),
                ],
              ),
              // Show error if it exists
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    state.errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Container(
            height: 50,
            margin: const EdgeInsets.all(10),
            child: FilledButton(
              onPressed: (state.isValid && state.status != AppStatus.loading)
                  ? () {
                      context.read<AppBloc>().add(OnGetRequestEvent());
                    }
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Start counting process'),
                  // Show circular progress indicator while processing request
                  state.status == AppStatus.loading
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
        );
      },
    );
  }
}
