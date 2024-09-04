import 'package:imageengine_helpers_dart/imageengine_helpers_dart.dart';
import 'package:test/test.dart';

void main() {
  final IEDirectives base = IEDirectives(
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
    forceDownload: true,
    maxDevicePixelRatio: 2.1,
  );

  final String expectedDirectivesString =
      "/w_200/h_500/w_auto_200/pc_50/cr_150,300,0,0/f_jpg/m_box/cmpr_50/s_20/r_0/in_true/meta_true/pass_true/dl_true/maxdpr_2.1";

  group('URL helpers', () {
    test('mapping works for all keys', () {
      expect(maybeCreateDirective('width', base.width), isNot(equals("")));
      expect(maybeCreateDirective('height', base.height), isNot(equals("")));
      expect(
          maybeCreateDirective('autoWidthWithFallback', base.autoWidthFallback),
          isNot(equals("")));
      expect(
          maybeCreateDirective(
              'scaleToScreenWidth', base.scaleToScreenWidth),
          isNot(equals("")));
      expect(maybeCreateDirective('crop', base.crop), isNot(equals("")));
      expect(
          maybeCreateDirective(
              'outputFormat', base.outputFormat?.toString().split('.').last),
          isNot(equals("")));
      expect(maybeCreateDirective('fitMethod', base.fitMethod?.toString().split('.').last),
          isNot(equals("")));
      expect(maybeCreateDirective('compression', base.compression),
          isNot(equals("")));
      expect(
          maybeCreateDirective('sharpness', base.sharpness), isNot(equals("")));
      expect(maybeCreateDirective('rotate', base.rotate), isNot(equals("")));
      expect(maybeCreateDirective('inline', base.inline), isNot(equals("")));
      expect(
          maybeCreateDirective('keepMeta', base.keepMeta), isNot(equals("")));
      expect(maybeCreateDirective('noOptimization', base.noOptimization),
          isNot(equals("")));
      expect(maybeCreateDirective('forceDownload', base.forceDownload),
          isNot(equals("")));
      expect(
          maybeCreateDirective(
              'maxDevicePixelRatio', base.maxDevicePixelRatio),
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
        forceDownload: true,
        maxDevicePixelRatio: 2.1,
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
    forceDownload: true,
    maxDevicePixelRatio: 2.1,
  );

  group('URL base alternative key naming', () {
    test('ie directives query string', () {
      expect(
          buildIEQueryString(buildIEDirectives(baseAlternative, debug: false),
              debug: false),
          equals('imgeng=$expectedDirectivesString'));
    });
  });

  group('IEDirectives', () {
    test('toMap() converts all properties correctly', () {
      final directives = IEDirectives(
        width: 100,
        height: 200,
        outputFormat: IEFormat.jpg,
        fitMethod: IEFit.box,
        compression: 75,
        inline: true,
        maxDevicePixelRatio: 2.0,
      );

      final map = directives.toMap();

      expect(map['width'], equals(100));
      expect(map['height'], equals(200));
      expect(map['outputFormat'], equals('jpg'));
      expect(map['fitMethod'], equals('box'));
      expect(map['compression'], equals(75));
      expect(map['inline'], isTrue);
      expect(map['maxDevicePixelRatio'], equals(2.0));
    });

    test('fromMap() creates IEDirectives correctly', () {
      final map = {
        'width': 100,
        'height': 200,
        'outputFormat': 'jpg',
        'fitMethod': 'box',
        'compression': 75,
        'inline': true,
        'maxDevicePixelRatio': 2.0,
      };

      final directives = IEDirectives.fromMap(map);

      expect(directives.width, equals(100));
      expect(directives.height, equals(200));
      expect(directives.outputFormat, equals(IEFormat.jpg));
      expect(directives.fitMethod, equals(IEFit.box));
      expect(directives.compression, equals(75));
      expect(directives.inline, isTrue);
      expect(directives.maxDevicePixelRatio, equals(2.0));
    });

    test('toMap() and fromMap() are reversible', () {
      final original = IEDirectives(
        width: 100,
        height: 200,
        outputFormat: IEFormat.webp,
        fitMethod: IEFit.cropbox,
        compression: 80,
        inline: false,
        maxDevicePixelRatio: 1.5,
      );

      final recreated = IEDirectives.fromMap(original.toMap());

      expect(recreated.width, equals(original.width));
      expect(recreated.height, equals(original.height));
      expect(recreated.outputFormat, equals(original.outputFormat));
      expect(recreated.fitMethod, equals(original.fitMethod));
      expect(recreated.compression, equals(original.compression));
      expect(recreated.inline, equals(original.inline));
      expect(recreated.maxDevicePixelRatio, equals(original.maxDevicePixelRatio));
    });
  });
}
