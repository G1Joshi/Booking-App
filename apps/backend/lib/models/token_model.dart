class Token {
  Token({
    required this.accessToken,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json['access_token'] as String,
    );
  }

  String accessToken;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'access_token': accessToken,
    };
  }
}
