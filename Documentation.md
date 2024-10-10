# Developer Guide for ImageEngine Helpers Dart

This guide is for developers who will be maintaining or extending the `imageengine_helpers` package.

## Table of Contents

1. [Setting Up the Development Environment](#setting-up-the-development-environment)
2. [Understanding the Codebase](#understanding-the-codebase)
3. [Core Functions](#core-functions)
4. [Types](#types)
5. [Tests](#tests)


### Prerequisites

- Dart SDK: `>=2.12.0 <3.0.0`
- Git

### Steps

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/yourusername/imageengine_helpers_dart.git
   cd imageengine_helpers_dart
   ```

2. **Install Dependencies**:

   ```bash
   dart pub get
   ```

3. **Open the Project in Your IDE**:
   Open the project in your preferred Dart-compatible IDE (e.g., Visual Studio Code, IntelliJ IDEA).

4. **Run Tests**:
   To run the package tests, use the following command in the terminal:

   ```bash
   dart test
   ```

## Understanding the Codebase

### Directory Structure
```bash
├── lib/
│ ├── src/
│ │ ├── helpers.dart
│ │ └── types.dart
│ └── imageengine_helpers_dart.dart
├── test/
│ └── imageengine_helpers_dart_test.dart
├── pubspec.yaml
├── README.md
└── LICENSE
```
### Key Files

- **`lib/src/helpers.dart`**:
  Contains the core functions for building ImageEngine URLs and directives.

- **`lib/src/types.dart`**:
  Defines the types and enums used throughout the package, including `IEFormat`, `IEFit`, and `IEDirectives`.

- **`lib/imageengine_helpers_dart.dart`**:
  The main entry point for the package, exporting the necessary functions and types.

- **`test/imageengine_helpers_dart_test.dart`**:
  Contains unit tests for the package.

### Core Functions

#### `buildIEUrl`
   ```bash
   String buildIEUrl(String src, IEDirectives directives, {bool debug = false}) {
  final String directivesString = buildIEDirectives(directives, debug: debug);
  final String queryString = buildIEQueryString(directivesString, debug: debug);
  final String queryPrefix =
      queryString.isEmpty ? '' : (src.contains('?') ? '&' : '?');

  return '$src$queryPrefix$queryString';
  }

   ```

Generates a complete ImageEngine URL by combining the source URL with the processed directives.

Inputs: source URL and IEDirectives object

Process: Calls buildIEDirectives and buildIEQueryString

Output: A fully formed ImageEngine URL with all applicable directives

Handles cases where the source URL already contains query parametersGenerates an ImageEngine URL with the given source and directives.

#### `buildIEDirectives`
   ```dart
   String buildIEDirectives(IEDirectives directives, {bool debug = false}) {
  final Map<String, dynamic> directivesMap = {
    'width': directives.width,
    'height': directives.height,
    'autoWidthWithFallback': directives.autoWidthFallback,
    'auto_width_fallback': directives.auto_width_fallback,
    'scaleToScreenWidth': directives.scaleToScreenWidth,
    'scale_to_screen_width': directives.scale_to_screen_width,
    'crop': directives.crop,
    'outputFormat': directives.outputFormat?.toString().split('.').last,
    'format': directives.format?.toString().split('.').last,
    'fitMethod': directives.fitMethod?.toString().split('.').last,
    'fit': directives.fit?.toString().split('.').last,
    'compression': directives.compression,
    'sharpness': directives.sharpness,
    'rotate': directives.rotate,
    'inline': directives.inline,
    'keepMeta': directives.keepMeta,
    'keep_meta': directives.keep_meta,
    'noOptimization': directives.noOptimization,
    'no_optimization': directives.no_optimization,
    'force_download': directives.force_download,
    'max_device_pixel_ratio': directives.max_device_pixel_ratio,
    'maxDevicePixelRatio': directives.maxDevicePixelRatio,
  };

  return directivesMap.entries.fold<String>('', (acc, entry) {
    final directive = entry.key;
    final value = entry.value;
    return acc + maybeCreateDirective(directive, value, debug: debug);
  });
}
```

Transforms an IEDirectives object into a string of URL directives.

Creates a map of all possible directives

Filters out null values

Converts enum values to strings

Uses maybeCreateDirective to format each directive
Concatenates all valid directives into a single string

#### `buildIEQueryString`
```dart
String buildIEQueryString(String directivesString, {bool debug = false}) {
  if (directivesString.isNotEmpty) {
    return 'imgeng=$directivesString';
  } else {
    if (debug) {
      print('build_IE_query_string called with an empty directives_string.');
    }
    return '';
  }
}
```

Wraps the directives string in the imgeng query parameter.

Checks if the directives string is empty.

If not empty, prepends 'imgeng=' to the string.

Handles debug logging for empty directive strings.

#### `maybeCreateDirective`
```dart
String maybeCreateDirective(String directive, dynamic value,
    {bool debug = false}) {
  final String? translatedDirective = OBJECT_TO_DIRECTIVES_MAP[directive];

  if (translatedDirective != null && (value != null || value == 0)) {
    return '/${translatedDirective}_$value';
  } else if (translatedDirective != null) {
    if (debug) {
      print('Directive \'$directive\' has an invalid value $value.');
    }
    return '';
  } else {
    if (debug) {
      print(
          'Directive \'$directive\' isn\'t recognized and won\'t be applied to the image.');
    }
    return '';
  }
}
```

Translates each directive into its corresponding URL parameter.

Uses OBJECT_TO_DIRECTIVES_MAP for translation.

Handles null and zero values.

Provides debug logging for invalid or unrecognized directives.

Formats the directive as '/{directive}{value}'.


### Types

The `types.dart` file defines the following types:

#### `IEFormat` (enum)

Represents the various output formats supported by ImageEngine.
```dart
enum IEFormat {
  png,
  gif,
  jpg,
  jpeg,
  bmp,
  webp,
  jp2,
  svg,
  mp4,
  jxr,
  avif,
  jxl,
}
```

- Used to specify the desired output format of the image.
- Includes common image formats like PNG, JPEG, WebP, as well as more specialized formats like AVIF and JXL.

#### `IEFit` (enum)
Defines the fitting methods for resizing images.

```dart
enum IEFit {
  stretch,
  box,
  letterbox,
  cropbox,
  outside,
}
```

- Determines how the image should be resized or cropped to fit the specified dimensions.
- Options range from stretching the image to maintaining aspect ratio with letterboxing or cropping.

#### `IEDirectives` (class)
A comprehensive class that encapsulates all possible directives for image manipulation.

```dart
class IEDirectives {
  final int? width; // the intrinsic width of the final image
  final int? height; // the intrinsic height of the final image

  final int? autoWidthFallback; // backward compatible key
  final int?
      auto_width_fallback; // fallback value if WURFL device detection fails

  final int? scaleToScreenWidth; // backward compatible key
  final int? scale_to_screen_width; // 0-100 float

  final String? crop; // specifies the cropping of the image
  final IEFormat? outputFormat; // the format of the output image
  final IEFormat? format; // backward compatible key

  final IEFit? fitMethod; // the method of fitting the image
  final IEFit? fit; // backward compatible key

  final int? compression; // the compression level of the image
  final int? sharpness; // the sharpness level of the image
  final int? rotate; // rotation of the image
  final bool? inline; // whether to inline the image
  final bool? keepMeta; // whether to keep metadata
  final bool? keep_meta; // backward compatible key
  final bool? noOptimization; // whether to skip optimization
  final bool? no_optimization; // backward compatible key
  final bool? force_download; // whether to force download
  final double? max_device_pixel_ratio; // the maximum device pixel ratio
  final double? maxDevicePixelRatio; // backward compatible key

  IEDirectives({
    this.width,
    this.height,
    this.autoWidthFallback,
    this.auto_width_fallback,
    this.scaleToScreenWidth,
    this.scale_to_screen_width,
    this.crop,
    this.outputFormat,
    this.format,
    this.fitMethod,
    this.fit,
    this.compression,
    this.sharpness,
    this.rotate,
    this.inline,
    this.keepMeta,
    this.keep_meta,
    this.noOptimization,
    this.no_optimization,
    this.force_download,
    this.max_device_pixel_ratio,
    this.maxDevicePixelRatio,
  });
}
```


- Represents all possible image manipulation directives supported by ImageEngine.
- Includes properties for resizing, cropping, formatting, compression, and various other image transformations.
- Some properties have alternative names for backward compatibility (e.g., `autoWidthFallback` and `auto_width_fallback`).
- All properties are nullable, allowing for flexible configuration of image transformations.

These types form the foundation of the ImageEngine helpers package, providing a type-safe way to define image transformation directives and ensuring consistency across the package.

### Tests

#### Mapping Works for All Keys
Ensures that each directive in the `IEDirectives` object is correctly mapped to its corresponding URL parameter.

#### IE Directives as String
Verifies that the `buildIEDirectives` function correctly converts an `IEDirectives` object into the expected string format.

#### IE Directives Query String
Checks that the `buildIEQueryString` function properly wraps the directives string in the `imgeng` query parameter.

#### IE URL
Tests the `buildIEUrl` function to ensure it correctly constructs the full URL with the directives, handling both URLs with and without existing query parameters.

#### IE URL with Empty Directives
Verifies that the `buildIEUrl` function handles cases where some directives are set to null, ensuring that only valid directives are included in the final URL.

#### IE URL Without Any Valid Directive
Ensures that the `buildIEUrl` function does not append unnecessary query string characters when no valid directives are provided.

#### URL Base Alternative Key Naming
Tests the handling of alternative key names for directives, ensuring compatibility with different naming conventions.
