import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_webspark/domain/models/response_model.dart';
import 'package:test_webspark/domain/models/result_model.dart';
import 'package:test_webspark/domain/models/task_model.dart';

class AppApi {
  AppApi({http.Client? httpClient}) : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<TaskModel> getTask(String url) async {
    final response = await _httpClient.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      return TaskModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception();
    }
  }

  Future<ResponseModel> postResult(String url, List<ResultModel>? resultModel) async {
    final response = await _httpClient.post(
      Uri.parse(url),
      body: jsonEncode(resultModel),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      return ResponseModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception();
    }
  }
}
