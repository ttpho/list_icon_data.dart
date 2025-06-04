import 'dart:io';
import 'dart:convert';

// Download the class icons content from the provided URL
// stored in `lib/icons.dart`
// https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/material/icons.dart
main() async {
  final path = "lib/icons.dart";
  final iconDataDefines =
      (await File(path)
              .openRead()
              .map(utf8.decode)
              .transform(LineSplitter())
              .map((line) => readLine(line.trim()))
              .toList())
          .where((line) => line.isNotEmpty)
          .toSet()
          .toList();

  final icons = iconDataDefines.map((e) => '  Icons.$e,').join('\n');

  final File file = File('lib/list_icon_data.dart');
  await file.writeAsString("""
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';

final List<IconData> availableIcons = const [
$icons
];
""");
}

String readLine(String line) {
  if (line.contains('static const IconData') && line.contains('=')) {
    var parts = line.trim().split('=');
    if (parts.isNotEmpty) {
      return parts[0].replaceAll('static const IconData ', '').trim();
    }
  }

  return '';
}
