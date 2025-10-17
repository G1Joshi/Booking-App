import 'dart:async';

import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context) {
  return Response(body: 'Welcome to Booking!');
}
