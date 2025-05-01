import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  /// Adds a border radius to the widget.
  /// common used with images
  /// example: Image.network().withRoundedCorners(radius: 8.0)
  Widget withRoundedCorners({double radius = 8.0}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: this,
    );
  }
}
