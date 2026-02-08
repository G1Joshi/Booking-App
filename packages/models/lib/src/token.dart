class Token {
  const Token({required this.accessToken});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(accessToken: json['access_token'] as String);
  }

  final String accessToken;

  Map<String, dynamic> toJson() => {'access_token': accessToken};
}
