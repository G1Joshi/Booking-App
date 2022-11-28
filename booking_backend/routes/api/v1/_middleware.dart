import 'package:booking_backend/middleware/db_connection_middleware.dart';
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(dbConnection());
}
