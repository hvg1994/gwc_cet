class AuthModel {
  int? status;
  User? user;
  String? accessToken;
  String? tokenType;

  AuthModel({this.status, this.user, this.accessToken, this.tokenType});

  AuthModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    return data;
  }
}

class User {
  int? id;
  int? roleId;
  String? name;
  String? fname;
  String? lname;
  String? email;
  String? emailVerifiedAt;
  String? countryCode;
  String? phone;
  String? gender;
  String? profile;
  String? address;
  String? otp;
  String? deviceToken;
  String? webDeviceToken;
  String? deviceType;
  String? deviceId;
  String? age;
  String? kaleyraUserId;
  String? chatId;
  String? loginUsername;
  String? pincode;
  int? isDoctorAdmin;
  String? underAdminDoctor;
  String? successUserId;
  String? cetUserId;
  String? cetCompleted;
  int? isActive;
  String? addedBy;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;
  String? signupDate;

  User(
      {this.id,
        this.roleId,
        this.name,
        this.fname,
        this.lname,
        this.email,
        this.emailVerifiedAt,
        this.countryCode,
        this.phone,
        this.gender,
        this.profile,
        this.address,
        this.otp,
        this.deviceToken,
        this.webDeviceToken,
        this.deviceType,
        this.deviceId,
        this.age,
        this.kaleyraUserId,
        this.chatId,
        this.loginUsername,
        this.pincode,
        this.isDoctorAdmin,
        this.underAdminDoctor,
        this.successUserId,
        this.cetUserId,
        this.cetCompleted,
        this.isActive,
        this.addedBy,
        this.latitude,
        this.longitude,
        this.createdAt,
        this.updatedAt,
        this.signupDate});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    name = json['name'];
    fname = json['fname'];
    lname = json['lname'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'].toString();
    countryCode = json['country_code'].toString();
    phone = json['phone'].toString();
    gender = json['gender'].toString();
    profile = json['profile'].toString();
    address = json['address'].toString();
    otp = json['otp'].toString();
    deviceToken = json['device_token'].toString();
    webDeviceToken = json['web_device_token'].toString();
    deviceType = json['device_type'].toString();
    deviceId = json['device_id'].toString();
    age = json['age'].toString();
    kaleyraUserId = json['kaleyra_user_id'].toString();
    chatId = json['chat_id'].toString();
    loginUsername = json['login_username'].toString();
    pincode = json['pincode'].toString();
    isDoctorAdmin = json['is_doctor_admin'];
    underAdminDoctor = json['under_admin_doctor'].toString();
    successUserId = json['success_user_id'].toString();
    cetUserId = json['cet_user_id'].toString();
    cetCompleted = json['cet_completed'].toString();
    isActive = json['is_active'];
    addedBy = json['added_by'].toString();
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    signupDate = json['signup_date'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['name'] = this.name;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['country_code'] = this.countryCode;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['profile'] = this.profile;
    data['address'] = this.address;
    data['otp'] = this.otp;
    data['device_token'] = this.deviceToken;
    data['web_device_token'] = this.webDeviceToken;
    data['device_type'] = this.deviceType;
    data['device_id'] = this.deviceId;
    data['age'] = this.age;
    data['kaleyra_user_id'] = this.kaleyraUserId;
    data['chat_id'] = this.chatId;
    data['login_username'] = this.loginUsername;
    data['pincode'] = this.pincode;
    data['is_doctor_admin'] = this.isDoctorAdmin;
    data['under_admin_doctor'] = this.underAdminDoctor;
    data['success_user_id'] = this.successUserId;
    data['cet_user_id'] = this.cetUserId;
    data['cet_completed'] = this.cetCompleted;
    data['is_active'] = this.isActive;
    data['added_by'] = this.addedBy;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['signup_date'] = this.signupDate;
    return data;
  }
}