# 🚀 Booking Backend

A high-performance RESTful API built with [Dart Frog](https://dart-frog.dev), serving as the backend for the Hotel Booking Application.

[![Powered by Dart Frog](https://img.shields.io/endpoint?url=https://tinyurl.com/dartfrog-badge)](https://dart-frog.dev)
[![PostgreSQL](<https://img.shields.io/badge/PostgreSQL-15%20(v3)-336791?logo=postgresql>)](https://www.postgresql.org)
[![style: dart frog lint][dart_frog_lint_badge]][dart_frog_lint_link]

---

## 🛠️ Tech Stack

- **Framework**: [Dart Frog](https://dart-frog.dev)
- **Database**: [PostgreSQL 15](https://www.postgresql.org/) (using [postgres v3](https://pub.dev/packages/postgres))
- **Auth**: Custom Token-based Authentication
- **CORS**: Enabled for cross-platform support

---

## 🚀 Getting Started

### Prerequisites

- [Dart SDK](https://dart.dev/get-dart): ^3.0.0
- [Dart Frog CLI](https://dart-frog.dev/docs/basics/cli): `dart pub global activate dart_frog_cli`
- [PostgreSQL](https://www.postgresql.org/download/): >= 15

### Database Setup

1. **Create Database**:

   ```sql
   CREATE DATABASE booking;
   ```

2. **Configure Constants**:
   Update `lib/config/constants.dart` with your database credentials.

3. **Run SQL Scripts**:
   Initialize the schema using files in `lib/sql/`.

### Development

Start the development server with hot reload:

```sh
# Default port is 8080. Using 8090 as per project standard.
dart_frog dev --port 8090
```

---

## 📁 Project Structure

- `routes/`: API endpoint definitions and middleware.
- `lib/`:
  - `controller/`: Request handling logic.
  - `service/`: Business logic and DB interactions.
  - `middleware/`: Auth, CORS, and connection management.
  - `models/`: Data structures.
  - `database/`: Postgres connection setup.
  - `sql/`: Schema and migration scripts.

---

## 🧪 Testing

Run unit tests:

```sh
dart test
```

[dart_frog_lint_badge]: https://img.shields.io/badge/style-dart_frog_lint-1DF9D2.svg
[dart_frog_lint_link]: https://pub.dev/packages/dart_frog_lint
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
