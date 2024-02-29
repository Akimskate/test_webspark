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
            itemCount: state.taskModel?.data?.length ?? 0,
            separatorBuilder: (BuildContext context, int index) => const Divider(),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                    "(${state.taskModel?.data?[index].start?.x.toString()}, ${state.taskModel?.data?[index].start?.y.toString()})->(${state.taskModel?.data?[index].end?.x.toString()}, ${state.taskModel?.data?[index].end?.y.toString()})"),
                onTap: () => Navigator.pushNamed(
                  context,
                  '/results-map',
                  arguments: state.taskModel?.data?[index],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
