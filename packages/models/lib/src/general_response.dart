class GeneralResponse {
  const GeneralResponse({required this.status, this.message, this.data});

  factory GeneralResponse.fromJson(Map<String, dynamic> json) {
    return GeneralResponse(
      status: json['status'] as bool,
      message: json['message'] as String?,
      data: json['data'],
    );
  }

  final bool status;

  final String? message;

  final Object? data;

  Map<String, dynamic> toJson() => {
    'status': status,
    if (message != null) 'message': message,
    if (data != null) 'data': data,
  };
}
