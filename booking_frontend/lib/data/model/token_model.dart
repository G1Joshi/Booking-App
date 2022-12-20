class Token {
  Token({
    this.accessToken,
    this.idToken,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken:
          json['access_token'] != null ? json['access_token'] as String : null,
      idToken: json['id_token'] != null ? json['id_token'] as String : null,
    );
  }

  String? accessToken;
  String? idToken;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'access_token': accessToken,
      'id_token': idToken,
    };
  }
}
