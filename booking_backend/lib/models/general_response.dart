class GeneralResponse {
  GeneralResponse({
    required this.status,
    this.message,
    this.data,
  });

  bool status;
  String? message;
  Object? data;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status': status,
      if (message != null) 'message': message,
      if (data != null) 'data': data,
    };
  }
}
