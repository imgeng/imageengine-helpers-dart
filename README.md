## Dart ImageEngine Helpers

A tiny set of helpers and Dart types for building [ImageEngine](https://imageengine.io) query URLs for your distribution.

These utilities are useful if you want to use an object to declare your [directives](https://support.imageengine.io/hc/en-us/articles/360058880672-directives) when retrieving assets from an ImageEngine distribution.

### Installation

Add this package to your `pubspec.yaml` dependencies:

```yaml
dependencies:
  imageengine_helpers: ^1.0.0
```

Then run:

```bash
flutter pub get
```

### Types:

```dart
enum IEFormat {
  png,
  gif,
  jpg,
  bmp,
  webp,
  jp2,
  svg,
  mp4,
  jxr,
  avif,
  jxl,
}

enum IEFit {
  stretch,
  box,
  letterbox,
  cropbox,
  outside,
}

class IEDirectives {
  final int? width; // the intrinsic width of the final image
  final int? height; // the intrinsic height of the final image
  final int? autoWidthFallback; // if WURFL device detection should be tried with a fallback value in case it fails

  final int? scaleToScreenWidth; // 0-100 float
  final String? crop; // a string representation like "width,height,left,top"

  final IEFormat? format; // the output format
  final IEFit? fit; // the image fit in relation to the provided width/height

  final int? compression; // 0-100
  final int? sharpness; // 0-100
  final int? rotate; // -360-360

  final bool? inline; // convert image to dataURL
  final bool? keepMeta; // keep EXIF image data
  final bool? noOptimization; // don't apply IE optimizations
  final bool? forceDownload; // force download
  final double? maxDevicePixelRatio; // 1-4 float

  IEDirectives({
    this.width,
    this.height,
    this.autoWidthFallback,
    this.scaleToScreenWidth,
    this.crop,
    this.format,
    this.fit,
    this.compression,
    this.sharpness,
    this.rotate,
    this.inline,
    this.keepMeta,
    this.noOptimization,
    this.forceDownload,
    this.maxDevicePixelRatio,
  });
}
```

### Example Usage

```dart
import 'package:imageengine_helpers/imageengine_helpers.dart';

void main() {
  IEDirectives directives = IEDirectives(
    width: 400,
    height: 200,
    fit: IEFit.cropbox,
    compression: 10,
    inline: true,
    format: IEFormat.png,
    forceDownload: true,
    maxDevicePixelRatio: 2.1,
  );

  String sourceUrl = "https://my_ie_distribution.imgeng.io/path/to_asset1.jpg";

  String finalUrl = buildIEUrl(sourceUrl, directives);

  print(finalUrl);
  // Outputs: "https://my_ie_distribution.imgeng.io/path/to_asset1.jpg?imgeng=/w_400/h_200/m_cropbox/cmpr_10/in_true/f_png/dl_true"

  String directivesString = buildIEDirectives(directives);

  print(directivesString);
  // Outputs: "/w_400/h_200/m_cropbox/cmpr_10/in_true/f_png/dl_true"

  String queryString = buildIEQueryString(directives);

  print(queryString);
  // Outputs: "?imgeng=/w_400/h_200/m_cropbox/cmpr_10/in_true/f_png/dl_true"
}
```