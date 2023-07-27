

import 'package:gwc_cet/controller/api_service.dart';

import '../../api/api_urls.dart';
import '../../api/base_api_service.dart';
import '../../model/auth_model/auth_model.dart';
import 'auth_repo.dart';

class AuthRepoImp implements AuthRepo{

  BaseApiService _apiService = ApiService();

  @override
  Future<AuthModel?> sendLoginDetails(String uname, String password, String deviceId) async {
    Map m = {
      "email": uname,
      "password": password,
      "device_token": deviceId
    };

    print("Map: $m");

    try {
      dynamic response = await _apiService.postResponse(
          loginUrl, Map.from(m));
      print("Api resonse: ${response}");
      print("$response");
      final jsonData = AuthModel.fromJson(response);
      return jsonData;
    } catch (e) {
      print("Error : $e}");
      throw e;
    }
  }

  Future logoutUser() async{
    try {
      dynamic response = await _apiService.postResponseWithHeader(
          logoutUrl, {});
      print("Api resonse: ${response}");
      print("$response");
      final jsonData = AuthModel.fromJson(response);
      return jsonData;
    } catch (e) {
      print("Error : $e}");
      throw e;
    }
  }

// @override
  // Future sendLoginDetails(String uname, String password) async {
  //   try {
  //     dynamic response = await _apiService.getResponse(
  //         loginUrl);
  //     print("STATUS $response");
  //     // final jsonData = MoviesMain.fromJson(response);
  //     // return jsonData;
  //   } catch (e) {
  //     throw e;
  //     print("STATUS-E $e}");
  //   }
  // }

}