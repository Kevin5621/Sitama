import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

class FileHelper {
  static bool isValidFileType(String fileName) {
    final validExtensions = ['.pdf', '.doc', '.docx'];
    final extension = fileName.toLowerCase().substring(fileName.lastIndexOf('.'));
    return validExtensions.contains(extension);
  }

  static String getReadableFileSize(int bytes) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(1)} ${suffixes[i]}';
  }

  static String getMimeType(String fileName) {
    final extension = fileName.toLowerCase().substring(fileName.lastIndexOf('.'));
    switch (extension) {
      case '.pdf':
        return 'application/pdf';
      case '.doc':
        return 'application/msword';
      case '.docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      default:
        return 'application/octet-stream';
    }
  }

  static String getFileName(String filePath) {
    return filePath.substring(filePath.lastIndexOf('/') + 1);
  }

  static String getFileExtension(String fileName) {
    return fileName.substring(fileName.lastIndexOf('.'));
  }

  static String uint8ListToBase64(Uint8List bytes) {
    return base64Encode(bytes);
  }

  static Uint8List base64ToUint8List(String base64String) {
    return base64Decode(base64String);
  }
}