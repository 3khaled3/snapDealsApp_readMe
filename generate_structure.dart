import 'dart:io';
//toRun
// dart generate_structure.dart

void main() {
  const featureName = 'chat';
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
            'services': ['funcation.dart'],
          },
          'view': {
            'pages': [
              '${featureName}_view.dart',
            ],
            'widgets': [
              'custom_button.dart',
            ],
            'navigation': ['${featureName}_router.dart'],
          },
          'model_view': {
            'cubit': [
              '${featureName}_cubit.dart',
              '${featureName}_state.dart',
            ],
          },
        }
      }
    },
  };

  createStructure(structure);

  print('Project structure created successfully!');
}

void createStructure(Map<String, dynamic> structure, [String path = '']) {
  structure.forEach((key, value) {
    final currentPath = path.isEmpty ? key : '$path/$key';

    if (value is Map<String, dynamic>) {
      Directory(currentPath).createSync(recursive: true);
      createStructure(value, currentPath);
    } else if (value is List<String>) {
      Directory(currentPath).createSync(recursive: true);
      for (var file in value) {
        File('$currentPath/$file').createSync();
      }
    }
  });
}
