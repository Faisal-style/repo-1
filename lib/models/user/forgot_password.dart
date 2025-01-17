import 'dart:convert';

class ForgotPasswordResponse {
  ForgotPasswordResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  int data;

  factory ForgotPasswordResponse.fromRawJson(String str) =>
      ForgotPasswordResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResponse(
        status: json['status'],
        message: json['message'],
        data: json['data'],
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data,
      };
}

class ForgotPasswordRequest {
  ForgotPasswordRequest({
    required this.email,
  });
  late final String email;

  ForgotPasswordRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    return data;
  }
}

class VerifyTokenResponse {
  String? status;
  String? message;
  String? data;

  VerifyTokenResponse({this.status, this.message, this.data});

  VerifyTokenResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}
