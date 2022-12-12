class GeneralResponse {
  GeneralResponse({
    required this.status,
    this.message,
    this.data,
  });

  factory GeneralResponse.fromJson(Map<String, dynamic> json) {
    return GeneralResponse(
      status: json['status'] as bool,
      message: json['message'] as String?,
      data: json['data'] as Object?,
    );
  }

  bool status;
  String? message;
  Object? data;
}
