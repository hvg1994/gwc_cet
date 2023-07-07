class NormalModel {
  int? status;
  int? errorCode;
  String? message;

  NormalModel({this.status, this.errorCode, this.message});

  NormalModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorCode = json['errorCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errorCode'] = this.errorCode;
    data['message'] = this.message;
    return data;
  }
}