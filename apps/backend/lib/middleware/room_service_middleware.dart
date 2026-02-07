import 'package:booking_backend/database/connection.dart';
import 'package:booking_backend/service/room_service.dart';
import 'package:dart_frog/dart_frog.dart';

Middleware roomService(DBConnection connection) {
  return provider<RoomService>((_) {
    return RoomService(connection.getConnection);
  });
}
