import 'package:test_webspark/domain/app_api.dart';
import 'package:test_webspark/domain/model/result_model.dart';
import 'package:test_webspark/domain/model/task_model.dart';

class AppRepository {
  AppRepository({required AppApi appApi}) : _appApi = appApi;

  final AppApi _appApi;

  Future<TaskModel> getTask(String url) => _appApi.getTask(url);

  Future<TaskModel> postTaskResult(String url, ResultModel? resultModel) => _appApi.postResult(url, resultModel!);
}
