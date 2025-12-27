import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;
import 'package:image_picker/image_picker.dart';

import '../base_request_model.dart';

mixin FormDataSerializable on BaseRequestModel {
  /// Convert request to Dio FormData
  ///
  /// Supported values:
  /// - String, num, bool
  /// - File
  /// - XFile
  /// - List<File>
  /// - List<XFile>
  FormData toFormData() {
    final map = toJson()..removeWhere((key, value) => value == null);

    final formData = FormData();

    for (final entry in map.entries) {
      final key = entry.key;
      final value = entry.value;

      if (value is File) {
        formData.files.add(
          MapEntry(key, _fileToMultipart(value)),
        );
      } else if (value is XFile) {
        formData.files.add(
          MapEntry(key, _xFileToMultipart(value)),
        );
      } else if (value is List<File>) {
        for (final file in value) {
          formData.files.add(
            MapEntry(key, _fileToMultipart(file)),
          );
        }
      } else if (value is List<XFile>) {
        for (final file in value) {
          formData.files.add(
            MapEntry(key, _xFileToMultipart(file)),
          );
        }
      } else {
        formData.fields.add(
          MapEntry(key, value.toString()),
        );
      }
    }

    return formData;
  }

  MultipartFile _fileToMultipart(File file) {
    return MultipartFile.fromFileSync(
      file.path,
      filename: p.basename(file.path),
    );
  }

  MultipartFile _xFileToMultipart(XFile file) {
    return MultipartFile.fromFileSync(
      file.path,
      filename: file.name,
    );
  }
}
