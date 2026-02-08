# booking_utils

Shared utility functions and API endpoint constants for the Booking App.

## Features

- **API Endpoints**: Centralized API route definitions (HotelsApi, SearchApi, etc.).
- **Rating Utilities**: Helper functions for rating calculations and descriptive grades.

## Getting Started

Add this as a dependency to your Dart/Flutter project:

```yaml
dependencies:
  booking_utils:
    resolution: workspace
```

## Usage

### API Endpoints

```dart
import 'package:booking_utils/booking_utils.dart';

final path = HotelsApi.byId('123'); // returns '/hotels/123'
```

### Rating Utils

```dart
import 'package:booking_utils/booking_utils.dart';

final grade = Grade.getGrade(4.7); // returns 'Excellent'
```
