import 'package:equatable/equatable.dart';
import 'package:test_webspark/domain/model/result_model.dart';
import 'package:test_webspark/domain/model/task_model.dart';

enum AppStatus { initial, loading, success, failure }

final class AppState extends Equatable {
  const AppState({
    this.status = AppStatus.initial,
    this.isValid = false,
    this.errorMessage = '',
    this.url = '',
    this.taskModel,
    this.resultModel,
  });

  final AppStatus status;
  final bool isValid;
  final String errorMessage;
  final String url;
  final TaskModel? taskModel;
  final List<ResultModel>? resultModel;

  AppState copyWith({
    AppStatus? status,
    bool? isValid,
    String? errorMessage,
    String? url,
    TaskModel? taskModel,
    List<ResultModel>? resultModel,
  }) {
    return AppState(
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
      url: url ?? this.url,
      taskModel: taskModel ?? this.taskModel,
      resultModel: resultModel ?? this.resultModel,
    );
  }

  @override
  List<Object?> get props => [status, isValid, errorMessage, url, taskModel, resultModel];
}
