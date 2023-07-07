import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../api/app_exception.dart';
import '../api/base_api_service.dart';
import 'package:http/http.dart' as http;

import '../utils/app_config.dart';

class ApiService extends BaseApiService {

  final _prefs = AppConfig().preferences;

  String getHeaderToken() {
    if (_prefs != null) {
      final token = _prefs!.getString(AppConfig().BEARER_TOKEN);
      // AppConfig().tokenUser
      // .substring(2, AppConstant().tokenUser.length - 1);
      return "Bearer $token";
    } else {
      return "Bearer not got";
    }
  }

  @override
  Future getResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(baseUrl + url));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postResponse(String url, Map<String, String> JsonBody) async{
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(baseUrl + url),body: JsonBody);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getResponseWithHeader(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(baseUrl + url),
      headers: {
        "Authorization": getHeaderToken(),
      });
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postResponseWithHeader(String url, Map<String, String>? JsonBody) async{
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(baseUrl + url),
          headers: {
            "Authorization": getHeaderToken(),
          },
          body: JsonBody);
      responseJson = returnResponse(response);
    } catch(e) {
      throw FetchDataException(e.toString());
    }
    return responseJson;
  }


  @override
  Future postAttachmentResponse(String url, Map<String, String> jsonBody, List<MultipartFile> attachments) async{
    dynamic responseJson;
    try {

      var request = http.MultipartRequest('POST', Uri.parse(baseUrl + url));

      var headers = {
        // "Authorization": "Bearer ${AppConfig().bearerToken}",
        "Authorization": getHeaderToken(),
      };

      request.files.addAll(attachments);
      request.fields.addAll(jsonBody);

      var response = await http.Response.fromStream(await request.send())
          .timeout(Duration(seconds: 45));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}