const String apiBasePath = '/api/v1';

abstract final class HotelsApi {
  static const String base = '/hotels';

  static String byId(String id) => '/hotels/$id';
}

abstract final class SearchApi {
  static const String base = '/search';
}

abstract final class FilterApi {
  static const String base = '/filter';
}

abstract final class RoomsApi {
  static const String base = '/room';

  static String byId(String roomId) => '/room/$roomId';
}

abstract final class ReviewsApi {
  static const String base = '/review';
}

abstract final class BookingsApi {
  static const String base = '/booking';

  static String byRoom(String roomId) => '/room/$roomId/booking';
}

abstract final class AuthApi {
  static const String signup = '/auth/signup';

  static const String signin = '/auth/signin';
}
