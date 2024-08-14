import '../lib/imageengine_helpers_dart.dart';

void main() {
  // Create an instance of IEDirectives with some example values
  IEDirectives directives = IEDirectives(
    width: 800,
    height: 600,
    crop: 'fit',
    outputFormat: IEFormat.jpg,
  );

  // Source image URL
  String src = 'https://example.com/image.jpg';

  // Build the ImageEngine URL with the given directives
  String imageUrl = buildIEUrl(src, directives, debug: true);

  // Print the resulting URL
  print('Generated ImageEngine URL: $imageUrl');
}