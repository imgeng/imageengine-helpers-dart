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
  final int? scaleToScreenWidth; // backward compatible key
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
  final bool? noOptimization; // whether to skip optimization
  final bool? forceDownload; // whether to force download
  final double? maxDevicePixelRatio; // the maximum device pixel ratio

  IEDirectives({
    this.width,
    this.height,
    this.autoWidthFallback,
    this.scaleToScreenWidth,
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
    this.noOptimization,
    this.forceDownload,
    this.maxDevicePixelRatio,
  });
}
