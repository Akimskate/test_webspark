import 'package:test_webspark/domain/app_api.dart';
import 'package:test_webspark/domain/models/response_model.dart';
import 'package:test_webspark/domain/models/result_model.dart';
import 'package:test_webspark/domain/models/task_model.dart';

class AppRepository {
  AppRepository({required AppApi appApi}) : _appApi = appApi;

  final AppApi _appApi;

  Future<TaskModel> getTask(String url) => _appApi.getTask(url);

  Future<ResponseModel> postTaskResult(String url, List<ResultModel>? resultModel) =>
      _appApi.postResult(url, resultModel!);
}
