import 'package:dart_frog/dart_frog.dart';

const _corsHeaders = {
  'access-control-allow-origin': '*',
  'access-control-allow-methods': '*',
  'access-control-allow-headers': '*',
};

Middleware cors() {
  return (handler) {
    return (context) async {
      if (context.request.method == HttpMethod.options) {
        return Response(statusCode: 204, headers: _corsHeaders);
      }
      final response = await handler(context);
      return response.copyWith(headers: {..._corsHeaders, ...response.headers});
    };
  };
}
