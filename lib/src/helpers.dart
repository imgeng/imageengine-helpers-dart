import 'types.dart';

/* MAPPING from `IEDirectives` to actual ImageEngine URL directives: */
/* https://support.imageengine.io/hc/en-us/articles/360058880672-directives */

const Map<String, String> objectToDirectivesMap = {
  'width': 'w',
  'height': 'h',
  'autoWidthWithFallback': 'w_auto',
  'scaleToScreenWidth': 'pc',
  'crop': 'cr',
  'outputFormat': 'f',
  'format': 'f',
  'fitMethod': 'm',
  'fit': 'm',
  'compression': 'cmpr',
  'sharpness': 's',
  'rotate': 'r',
  'inline': 'in',
  'keepMeta': 'meta',
  'noOptimization': 'pass',
  'forceDownload': 'dl',
  'maxDevicePixelRatio': 'maxdpr',
};

String buildIEUrl(String src, IEDirectives directives, {bool debug = false}) {
  final String directivesString = buildIEDirectives(directives, debug: debug);
  final String queryString = buildIEQueryString(directivesString, debug: debug);
  final String queryPrefix =
      queryString.isEmpty ? '' : (src.contains('?') ? '&' : '?');

  return '$src$queryPrefix$queryString';
}

String buildIEDirectives(IEDirectives directives, {bool debug = false}) {
  final Map<String, dynamic> directivesMap = {
    'width': directives.width,
    'height': directives.height,
    'autoWidthWithFallback': directives.autoWidthFallback,
    'scaleToScreenWidth': directives.scaleToScreenWidth,
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
    'noOptimization': directives.noOptimization,
    'forceDownload': directives.forceDownload,
    'maxDevicePixelRatio': directives.maxDevicePixelRatio,
  };

  return directivesMap.entries.fold<String>('', (acc, entry) {
    final directive = entry.key;
    final value = entry.value;
    return acc + maybeCreateDirective(directive, value, debug: debug);
  });
}

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

String maybeCreateDirective(String directive, dynamic value,
    {bool debug = false}) {
  final String? translatedDirective = objectToDirectivesMap[directive];

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
