class Token {
  Token({
    required this.accessToken,
    required this.idToken,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json['access_token'] as String,
      idToken: json['id_token'] as String,
    );
  }

  String accessToken;
  String idToken;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'access_token': accessToken,
      'id_token': idToken,
    };
  }
}
