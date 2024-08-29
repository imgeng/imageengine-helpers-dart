import 'package:imageengine_helpers_dart/imageengine_helpers_dart.dart';

void main() {
  // Create an instance of IEDirectives with some example values
  IEDirectives directives = IEDirectives(
    width: 800,
    height: 600,
    autoWidthFallback: 1000,
    scaleToScreenWidth: 100,
    crop: '200,300,0,0',
    outputFormat: IEFormat.jpg,
    fitMethod: IEFit.box,
    compression: 75,
    sharpness: 10,
    rotate: 90,
    inline: true,
    keepMeta: false,
    noOptimization: false,
    forceDownload: false,
    maxDevicePixelRatio: 2.0,
  );

  // Source image URL
  String src = 'https://example.com/image.jpg';

  // Build the ImageEngine URL with the given directives
  String imageUrl = buildIEUrl(src, directives, debug: true);

  // Print the resulting URL
  print('Generated ImageEngine URL: $imageUrl');
}