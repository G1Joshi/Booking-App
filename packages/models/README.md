# booking_models

Shared domain models and Data Transfer Objects (DTOs) for the Booking App.

## Features

- **Shared DTOs**: Consistent data structures between frontend and backend.
- **JSON Serialization**: Built-in support for `fromJson` and `toJson`.
- **Value Equality**: Implemented with `equatable` for efficient state management.
- **Immutable**: All models use `const` constructors where possible.

## Getting Started

Add this as a dependency to your Dart/Flutter project:

```yaml
dependencies:
  booking_models:
    resolution: workspace
```

## Usage

```dart
import 'package:booking_models/booking_models.dart';

final hotel = Hotel(
  name: 'Grand Plaza',
  rating: 4.5,
  // ... other fields
);
```
