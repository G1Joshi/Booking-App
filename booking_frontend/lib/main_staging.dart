import 'package:booking_frontend/app/app.dart';
import 'package:booking_frontend/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
