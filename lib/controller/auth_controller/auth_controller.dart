
import 'package:flutter/cupertino.dart';
import '../../api/api_response.dart';
import '../../model/auth_model/auth_model.dart';
import '../../repository/auth_repo/auth_repo.dart';
import '../../repository/auth_repo/auth_repo_vm.dart';

class AuthController extends ChangeNotifier{
  AuthRepo _authRepo = AuthRepoImp();

  ApiResponse authResponse = ApiResponse.idle();

  void _setResponseMain(ApiResponse<AuthModel> response) {
    print("Auth Response :: $response");
    authResponse = response;
    Future.delayed(Duration.zero).then((value) {
      notifyListeners();
    });
  }

  Future<void> sendLoginDetailsVm(String uname, String password, String fcmToken) async {
    _setResponseMain(ApiResponse.loading());
    await _authRepo
        .sendLoginDetails(uname, password, fcmToken)
        .then((value) {
          print("value: $value");
      _setResponseMain(ApiResponse.completed(value));
    })
        .onError((error, stackTrace) {
      _setResponseMain(ApiResponse.error(error.toString()));
    });
  }

  Future<void> logout() async {
    _setResponseMain(ApiResponse.loading());
    await _authRepo
        .logoutUser()
        .then((value) {
      print("value: $value");
      _setResponseMain(ApiResponse.completed(value));
    })
        .onError((error, stackTrace) {
      _setResponseMain(ApiResponse.error(error.toString()));
    });
  }

}