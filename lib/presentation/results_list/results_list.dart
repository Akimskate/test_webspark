import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_webspark/bloc/app_bloc.dart';
import 'package:test_webspark/bloc/app_state.dart';

class ResultsListScreen extends StatelessWidget {
  const ResultsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text("Result list screen"),
          ),
          body: ListView.separated(
            itemCount: state.resultModel?.length ?? 0,
            separatorBuilder: (BuildContext context, int index) => const Divider(),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/results-map',
                    arguments: [state.resultModel![index].result?.steps, state.taskModel?.data?[index]],
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      state.resultModel![index].result!.path.toString(),
                      style: const TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
