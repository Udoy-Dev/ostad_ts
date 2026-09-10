import 'dart:convert';

import 'package:http/http.dart';
import 'package:ostad_ts/Models/ApiResponse.dart';

import '../AuthController/AuthController.dart';

class ApiCaller {

  static Future<ApiResponse> getRequest({required String url}) async {
    Response response = await get(Uri.parse(url), headers: {
      'token': AuthController.UserToken.toString(),
    });

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      return ApiResponse(
        responseCode: response.statusCode,
        responseData: jsonDecode(response.body),
        isSuccess: true,
      );
    } else {
      return ApiResponse(
        responseCode: response.statusCode,
        responseData: jsonDecode(response.body),
        isSuccess: false,
      );
    }
  }

  static Future<ApiResponse> postRequest({required String url, Map<String, dynamic>? body,}) async {
    Response response = await post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'token': AuthController.UserToken.toString(),
      },
      body: body != null ? jsonEncode(body) : null,
    );

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse(
        responseCode: response.statusCode,
        responseData: jsonDecode(response.body),
        isSuccess: true,
      );
    } else {
      return ApiResponse(
        responseCode: response.statusCode,
        responseData: jsonDecode(response.body),
        isSuccess: false,
      );
    }
  }




}
