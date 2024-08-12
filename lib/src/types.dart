// Equivalent Dart code for types.ts

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
