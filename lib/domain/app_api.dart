import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_webspark/domain/model/result_model.dart';
import 'package:test_webspark/domain/model/task_model.dart';

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

  Future<TaskModel> postResult(String url, ResultModel resultModel) async {
    final response = await _httpClient.post(
      Uri.parse(url),
      body: jsonEncode(resultModel.toJson()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return TaskModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception();
    }
  }

  // Future<void> postSubscribe(String email) async {
  //   print("Trying to send request for email$email");
  //   await Future.delayed(const Duration(seconds: 1)); // @TODO remove once implemented

  //   String apiKey = "6zWKe7xyUTDcVL7u6YC8";
  //   //String url = "http://newsletter.mockvault.com/demo/subscription";

  //   String listId = "tvkfCjhd2wyr6PsQwyD3763g";
  //   String hp = "";

  //   final response = await _httpClient.post(
  //     Uri.parse(url),
  //     body: jsonEncode(<String, String>{
  //       'api_key': apiKey,
  //       'email': email,
  //       'list': listId,
  //       'hp': hp,
  //       'name': 'Test1 Test1',
  //       'gdpr': 'true',
  //       'subform': 'yes',
  //       'boolean': 'true'
  //     }),
  //   );
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     print(response);
  //     //return GuestModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  //   } else {
  //     throw SubscribeRequestFailure(message: 'Request Error (status code: ${response.statusCode}) ${response.body}');
  //   }
  // }
}
