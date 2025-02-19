class OTPResponse {
  final String otp;
  final String accessToken;
  final bool userExists;

  OTPResponse({
    required this.otp,
    required this.accessToken,
    required this.userExists,
  });

  factory OTPResponse.fromJson(Map<String, dynamic> json) {
    return OTPResponse(
      otp: json['otp'],
      accessToken: json['token']['access'],
      userExists: json['user'],
    );
  }
}
