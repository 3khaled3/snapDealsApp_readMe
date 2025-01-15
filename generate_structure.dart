import 'dart:io';

void main() {
  const featureName = 'product';
  final structure = {
    'lib': {
      'app': {
        "${featureName}_feature": {
          'data': {
            'models': ['${featureName}_model.dart'],
            'repositories': [
              'i_${featureName}_repository.dart',
              '${featureName}_repository.dart'
            ],
            'services': ['api_service.dart', 'local_storage_service.dart'],
          },
          'presentation': {
            'pages': [
              '${featureName}_view.dart',
            ],
            'widgets': [
              'custom_button.dart',
              'custom_text_field.dart',
              'error_widget.dart',
            ],
            'navigation': ['${featureName}_router.dart'],
          },
        }
      }
    },
  };

  // Generate the structure as a text-based tree representation
  final structureAsText = generateStructureAsText(structure);
  File('structure.txt').writeAsStringSync(structureAsText);

  print('Structure saved as structure.txt.');
}

String generateStructureAsText(Map<String, dynamic> structure,
    [String prefix = '']) {
  final buffer = StringBuffer();

  structure.forEach((key, value) {
    buffer.writeln('$prefix$key/');
    if (value is Map<String, dynamic>) {
      buffer.write(generateStructureAsText(value, '$prefix  '));
    } else if (value is List<String>) {
      for (var file in value) {
        buffer.writeln('$prefix  $file');
      }
    }
  });

  return buffer.toString();
}
