import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_webspark/bloc/app_bloc.dart';
import 'package:test_webspark/domain/app_api.dart';
import 'package:test_webspark/presentation/home/home_page.dart';
import 'package:test_webspark/presentation/process/process_page.dart';
import 'package:test_webspark/presentation/results_list/results_list.dart';
import 'package:test_webspark/presentation/results_map/results_map.dart';
import 'package:test_webspark/repository/app_repository/app_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(appRepository: AppRepository(appApi: AppApi())),
      child: MaterialApp(
        title: 'Webspark test task',
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/process': (context) => const ProcessScreen(),
          '/results-list': (context) => const ResultsListScreen(),
          '/results-map': (context) => const ResultsMapScreen(),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        //home: const HomePage(),
      ),
    );
  }
}
