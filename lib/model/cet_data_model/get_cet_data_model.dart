class GetCetDataModel {
  int? status;
  int? errorCode;
  List<PendingDetails>? pendingDetails;
  List<CompletedDetails>? completedDetails;

  GetCetDataModel(
      {this.status,
        this.errorCode,
        this.pendingDetails,
        this.completedDetails});

  GetCetDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorCode = json['errorCode'];
    if (json['pending_details'] != null) {
      pendingDetails = <PendingDetails>[];
      json['pending_details'].forEach((v) {
        pendingDetails!.add(new PendingDetails.fromJson(v));
      });
    }
    if (json['completed_details'] != null) {
      completedDetails = <CompletedDetails>[];
      json['completed_details'].forEach((v) {
        completedDetails!.add(new CompletedDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errorCode'] = this.errorCode;
    if (this.pendingDetails != null) {
      data['pending_details'] =
          this.pendingDetails!.map((v) => v.toJson()).toList();
    }
    if (this.completedDetails != null) {
      data['completed_details'] =
          this.completedDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PendingDetails {
  String? name;
  String? email;
  String? countryCode;
  String? phone;
  String? gender;
  String? age;
  int? userId;
  Null? signupDate;

  PendingDetails(
      {this.name,
        this.email,
        this.countryCode,
        this.phone,
        this.gender,
        this.age,
        this.userId,
        this.signupDate});

  PendingDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    countryCode = json['country_code'];
    phone = json['phone'];
    gender = json['gender'];
    age = json['age'];
    userId = json['user_id'];
    signupDate = json['signup_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['user_id'] = this.userId;
    data['signup_date'] = this.signupDate;
    return data;
  }
}

class CompletedDetails {
  String? name;
  String? email;
  String? countryCode;
  String? phone;
  String? gender;
  String? age;
  int? userId;
  Null? signupDate;

  CompletedDetails(
      {this.name,
        this.email,
        this.countryCode,
        this.phone,
        this.gender,
        this.age,
        this.userId,
        this.signupDate});

  CompletedDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    countryCode = json['country_code'];
    phone = json['phone'];
    gender = json['gender'];
    age = json['age'];
    userId = json['user_id'];
    signupDate = json['signup_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['user_id'] = this.userId;
    data['signup_date'] = this.signupDate;
    return data;
  }
}