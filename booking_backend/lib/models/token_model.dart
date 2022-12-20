// ignore_for_file: non_constant_identifier_names, sort_constructors_first

class Token {
  String? access_token;
  String? id_token;

  Token({
    this.access_token,
    this.id_token,
  });

  Token copyWith({
    String? access_token,
    String? id_token,
  }) {
    return Token(
      access_token: access_token ?? this.access_token,
      id_token: id_token ?? this.id_token,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'access_token': access_token,
      'id_token': id_token,
    };
  }

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      access_token:
          json['access_token'] != null ? json['access_token'] as String : null,
      id_token: json['id_token'] != null ? json['id_token'] as String : null,
    );
  }
}
