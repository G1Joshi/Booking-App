import 'dart:io';

import 'package:booking_backend/service/auth_service.dart';
import 'package:booking_models/booking_models.dart';
import 'package:dart_frog/dart_frog.dart';

class AuthController {
  static Future<Response> signUp(RequestContext context) async {
    final request = context.request;
    final authService = context.read<AuthService>();
    final user = User.fromJson(
      await request.json() as Map<String, dynamic>,
    );
    final data = await authService.create(user);
    if (data) {
      return Response.json(
        statusCode: HttpStatus.created,
        body: const GeneralResponse(
          status: true,
        ),
      );
    } else {
      return Response.json(
        statusCode: HttpStatus.nonAuthoritativeInformation,
        body: const GeneralResponse(
          status: false,
          message: 'User already registered',
        ),
      );
    }
  }

  static Future<Response> signIn(RequestContext context) async {
    final request = context.request;
    final authService = context.read<AuthService>();
    final loginRequest = LoginRequest.fromJson(
      await request.json() as Map<String, dynamic>,
    );
    final data = await authService.read(loginRequest);
    if (data != null) {
      return Response.json(
        statusCode: HttpStatus.created,
        body: GeneralResponse(
          status: true,
          data: data,
        ),
      );
    } else {
      return Response.json(
        statusCode: HttpStatus.nonAuthoritativeInformation,
        body: const GeneralResponse(
          status: false,
          message: 'User not found, Please register',
        ),
      );
    }
  }

  static Future<bool> verify(RequestContext context) async {
    try {
      final path = context.request.uri.path;
      final isAuth = path.contains('/auth/');
      if (isAuth) return true;
      final authService = context.read<AuthService>();
      final headers = context.request.headers;
      final data = await authService.verify(headers);
      return data;
    } catch (e) {
      return false;
    }
  }
}
