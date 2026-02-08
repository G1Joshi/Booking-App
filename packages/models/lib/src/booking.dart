class Booking {
  const Booking({
    required this.bookingDate,
    required this.checkin,
    required this.checkout,
    required this.rooms,
    required this.guests,
    this.id,
    this.roomId,
    this.userId,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] != null ? json['id'] as int : null,
      bookingDate: json['booking_date'] as String,
      checkin: json['checkin'] as String,
      checkout: json['checkout'] as String,
      rooms: json['rooms'] as int,
      guests: json['adults'] as int,
      roomId: json['room_id'] != null ? json['room_id'] as int : null,
      userId: json['user_id'] != null ? json['user_id'] as String : null,
    );
  }

  final int? id;

  final String bookingDate;

  final String checkin;

  final String checkout;

  final int rooms;

  final int guests;

  final int? roomId;

  final String? userId;

  Map<String, dynamic> toJson() => {
    'id': id,
    'booking_date': bookingDate,
    'checkin': checkin,
    'checkout': checkout,
    'rooms': rooms,
    'adults': guests,
    'room_id': roomId,
    'user_id': userId,
  };

  Booking copyWith({
    int? id,
    String? bookingDate,
    String? checkin,
    String? checkout,
    int? rooms,
    int? guests,
    int? roomId,
    String? userId,
  }) {
    return Booking(
      id: id ?? this.id,
      bookingDate: bookingDate ?? this.bookingDate,
      checkin: checkin ?? this.checkin,
      checkout: checkout ?? this.checkout,
      rooms: rooms ?? this.rooms,
      guests: guests ?? this.guests,
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
    );
  }
}
