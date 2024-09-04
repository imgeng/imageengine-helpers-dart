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

  Map<String, dynamic> toMap() {
    return {
      'width': width,
      'height': height,
      'autoWidthFallback': autoWidthFallback,
      'scaleToScreenWidth': scaleToScreenWidth,
      'crop': crop,
      'outputFormat': outputFormat?.toString().split('.').last,
      'format': format?.toString().split('.').last,
      'fitMethod': fitMethod?.toString().split('.').last,
      'fit': fit?.toString().split('.').last,
      'compression': compression,
      'sharpness': sharpness,
      'rotate': rotate,
      'inline': inline,
      'keepMeta': keepMeta,
      'noOptimization': noOptimization,
      'forceDownload': forceDownload,
      'maxDevicePixelRatio': maxDevicePixelRatio,
    };
  }

  factory IEDirectives.fromMap(Map<String, dynamic> map) {
    return IEDirectives(
      width: map['width'] as int?,
      height: map['height'] as int?,
      autoWidthFallback: map['autoWidthFallback'] as int?,
      scaleToScreenWidth: map['scaleToScreenWidth'] as int?,
      crop: map['crop'] as String?,
      outputFormat: map['outputFormat'] != null 
          ? IEFormat.values.firstWhere(
              (e) => e.toString().split('.').last == map['outputFormat'],
              orElse: () => IEFormat.jpg)
          : null,
      format: map['format'] != null 
          ? IEFormat.values.firstWhere(
              (e) => e.toString().split('.').last == map['format'],
              orElse: () => IEFormat.jpg)
          : null,
      fitMethod: map['fitMethod'] != null 
          ? IEFit.values.firstWhere(
              (e) => e.toString().split('.').last == map['fitMethod'],
              orElse: () => IEFit.box)
          : null,
      fit: map['fit'] != null 
          ? IEFit.values.firstWhere(
              (e) => e.toString().split('.').last == map['fit'],
              orElse: () => IEFit.box)
          : null,
      compression: map['compression'] as int?,
      sharpness: map['sharpness'] as int?,
      rotate: map['rotate'] as int?,
      inline: map['inline'] as bool?,
      keepMeta: map['keepMeta'] as bool?,
      noOptimization: map['noOptimization'] as bool?,
      forceDownload: map['forceDownload'] as bool?,
      maxDevicePixelRatio: map['maxDevicePixelRatio'] as double?,
    );
  }
}
