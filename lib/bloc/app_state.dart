import 'package:equatable/equatable.dart';
import 'package:test_webspark/domain/models/response_model.dart';
import 'package:test_webspark/domain/models/result_model.dart';
import 'package:test_webspark/domain/models/task_model.dart';

enum GetRequestStatus { initial, loading, success, failure }

enum PostRequestStatus { initial, loading, success, failure }

final class AppState extends Equatable {
  const AppState({
    this.getRequestStatus = GetRequestStatus.initial,
    this.postRequestStatus = PostRequestStatus.initial,
    this.isValid = false,
    this.errorMessage = '',
    this.url = '',
    this.taskModel,
    this.resultModel,
    this.responseModel,
  });

  final GetRequestStatus getRequestStatus;
  final PostRequestStatus postRequestStatus;
  final bool isValid;
  final String errorMessage;
  final String url;
  final TaskModel? taskModel;
  final List<ResultModel>? resultModel;
  final ResponseModel? responseModel;

  AppState copyWith({
    GetRequestStatus? getRequestStatus,
    PostRequestStatus? postRequestStatus,
    bool? isValid,
    String? errorMessage,
    String? url,
    TaskModel? taskModel,
    List<ResultModel>? resultModel,
    ResponseModel? responseModel,
  }) {
    return AppState(
      getRequestStatus: getRequestStatus ?? this.getRequestStatus,
      postRequestStatus: postRequestStatus ?? this.postRequestStatus,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
      url: url ?? this.url,
      taskModel: taskModel ?? this.taskModel,
      resultModel: resultModel ?? this.resultModel,
      responseModel: responseModel ?? this.responseModel,
    );
  }

  @override
  List<Object?> get props =>
      [getRequestStatus, postRequestStatus, isValid, errorMessage, url, taskModel, resultModel, responseModel];
}
