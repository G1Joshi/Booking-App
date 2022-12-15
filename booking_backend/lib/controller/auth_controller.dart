import 'dart:io';

import 'package:booking_backend/models/general_response.dart';
import 'package:booking_backend/service/auth_service.dart';
import 'package:dart_frog/dart_frog.dart';

class AuthController {
  static Future<Response> signUp(RequestContext context) async {
    final request = context.request;
    try {
      final authService = context.read<AuthService>();
      final data = await authService.create(request);
      if (data) {
        return Response.json(
          statusCode: HttpStatus.created,
          body: GeneralResponse(
            status: true,
          ),
        );
      } else {
        return Response.json(
          statusCode: HttpStatus.nonAuthoritativeInformation,
          body: GeneralResponse(
            status: false,
            message: 'User already registered',
          ),
        );
      }
    } catch (e) {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: GeneralResponse(
          status: false,
          message: e.toString(),
        ),
      );
    }
  }

  static Future<Response> signIn(RequestContext context) async {
    final request = context.request;
    try {
      final authService = context.read<AuthService>();
      final data = await authService.read(request);
      if (data) {
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
          body: GeneralResponse(
            status: false,
            message: 'User not found, Please register',
          ),
        );
      }
    } catch (e) {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: GeneralResponse(
          status: false,
          message: e.toString(),
        ),
      );
    }
  }
}
