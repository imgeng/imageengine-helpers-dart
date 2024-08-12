import 'package:imageengine_helpers_dart/imageengine_helpers_dart.dart';
import 'package:test/test.dart';

void main() {
  final IEDirectives base = IEDirectives(
    width: 200,
    height: 500,
    auto_width_fallback: 200,
    scale_to_screen_width: 50,
    crop: '150,300,0,0', // assuming this is a string in Dart
    format: IEFormat.jpg,
    fit: IEFit.box,
    compression: 50,
    sharpness: 20,
    rotate: 0,
    inline: true,
    keep_meta: true,
    no_optimization: true,
    force_download: true,
    max_device_pixel_ratio: 2.1,
  );

  final String expectedDirectivesString =
      "/w_200/h_500/w_auto_200/pc_50/cr_150,300,0,0/f_jpg/m_box/cmpr_50/s_20/r_0/in_true/meta_true/pass_true/dl_true/maxdpr_2.1";

  group('URL helpers', () {
    test('mapping works for all keys', () {
      expect(maybeCreateDirective('width', base.width), isNot(equals("")));
      expect(maybeCreateDirective('height', base.height), isNot(equals("")));
      expect(
          maybeCreateDirective('auto_width_fallback', base.auto_width_fallback),
          isNot(equals("")));
      expect(
          maybeCreateDirective(
              'scale_to_screen_width', base.scale_to_screen_width),
          isNot(equals("")));
      expect(maybeCreateDirective('crop', base.crop), isNot(equals("")));
      expect(
          maybeCreateDirective(
              'format', base.format?.toString().split('.').last),
          isNot(equals("")));
      expect(maybeCreateDirective('fit', base.fit?.toString().split('.').last),
          isNot(equals("")));
      expect(maybeCreateDirective('compression', base.compression),
          isNot(equals("")));
      expect(
          maybeCreateDirective('sharpness', base.sharpness), isNot(equals("")));
      expect(maybeCreateDirective('rotate', base.rotate), isNot(equals("")));
      expect(maybeCreateDirective('inline', base.inline), isNot(equals("")));
      expect(
          maybeCreateDirective('keep_meta', base.keep_meta), isNot(equals("")));
      expect(maybeCreateDirective('no_optimization', base.no_optimization),
          isNot(equals("")));
      expect(maybeCreateDirective('force_download', base.force_download),
          isNot(equals("")));
      expect(
          maybeCreateDirective(
              'max_device_pixel_ratio', base.max_device_pixel_ratio),
          isNot(equals("")));
    });

    test('ie directives as string', () {
      expect(buildIEDirectives(base, debug: false),
          equals(expectedDirectivesString));
    });

    test('ie directives query string', () {
      expect(
          buildIEQueryString(buildIEDirectives(base, debug: false),
              debug: false),
          equals('imgeng=$expectedDirectivesString'));
    });

    test('ie url', () {
      expect(buildIEUrl("test", base, debug: false),
          equals('test?imgeng=$expectedDirectivesString'));
      expect(buildIEUrl("test?param=1", base, debug: false),
          equals('test?param=1&imgeng=$expectedDirectivesString'));
    });

    test('ie url with empty directives', () {
      final IEDirectives newBase = IEDirectives(
        width: null,
        height: null,
        auto_width_fallback: 200,
        scale_to_screen_width: 50,
        crop: '150,300,0,0',
        format: IEFormat.jpg,
        fit: IEFit.box,
        compression: 50,
        sharpness: 20,
        rotate: 0,
        inline: true,
        keep_meta: true,
        no_optimization: true,
        force_download: true,
        max_device_pixel_ratio: 2.1,
      );

      final String newExpectedDirectives =
          "/w_auto_200/pc_50/cr_150,300,0,0/f_jpg/m_box/cmpr_50/s_20/r_0/in_true/meta_true/pass_true/dl_true/maxdpr_2.1";

      expect(buildIEUrl("test", newBase, debug: false),
          equals('test?imgeng=$newExpectedDirectives'));
    });

    test(
        'ie url without any valid directive should not include ? on the generated url',
        () {
      expect(buildIEUrl("test", IEDirectives(), debug: false), equals('test'));
      expect(buildIEUrl("test?param=A", IEDirectives(), debug: false),
          equals('test?param=A'));
    });
  });

  final IEDirectives baseAlternative = IEDirectives(
    width: 200,
    height: 500,
    autoWidthFallback: 200,
    scaleToScreenWidth: 50,
    crop: '150,300,0,0',
    outputFormat: IEFormat.jpg,
    fitMethod: IEFit.box,
    compression: 50,
    sharpness: 20,
    rotate: 0,
    inline: true,
    keepMeta: true,
    noOptimization: true,
    force_download: true,
    max_device_pixel_ratio: 2.1,
  );

  group('URL base alternative key naming', () {
    test('ie directives query string', () {
      expect(
          buildIEQueryString(buildIEDirectives(baseAlternative, debug: false),
              debug: false),
          equals('imgeng=$expectedDirectivesString'));
    });
  });
}
