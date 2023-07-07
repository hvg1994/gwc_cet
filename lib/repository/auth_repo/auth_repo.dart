
import '../../model/auth_model/auth_model.dart';

abstract class AuthRepo{
  Future<AuthModel?> sendLoginDetails(String uname, String password, String fcmToken) async {}

  Future logoutUser() async {}

}