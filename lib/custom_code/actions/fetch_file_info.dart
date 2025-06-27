// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Core service class for file processing
class FileAnalyzer {
  static final http.Client _client = http.Client();

  // Compressed file extensions (const for performance)
  static const Set<String> _compressedExts = {
    'zip',
    'rar',
    '7z',
    'tar',
    'gz',
    'bz2',
    'xz',
    'cab',
    'iso',
    'exe',
    'app'
  };

  // MIME type mappings for fallback
  static const Map<String, String> _mimeMap = {
    'pdf': 'application/pdf',
    'doc': 'application/msword',
    'docx':
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'jpg': 'image/jpeg',
    'jpeg': 'image/jpeg',
    'png': 'image/png',
    'mp4': 'video/mp4',
    'mp3': 'audio/mpeg',
    'txt': 'text/plain',
    'json': 'application/json',
    'csv': 'text/csv'
  };

  static void dispose() => _client.close();
}

/// Main FlutterFlow custom action entry point
Future<FileInfoStruct> fetchFileInfo(String? fileUrl) async {
  try {
    // URL analysis path
    if (fileUrl?.isNotEmpty == true) {
      return await _analyzeUrlFile(fileUrl!);
    }

    // Local file picking path
    return await _pickLocalFile();
  } catch (e) {
    debugPrint('FileAnalyzer error: $e');
    return _buildResult(
      status: 'error',
      message: _mapErrorMessage(e.toString()),
    );
  }
}

// Local file picking with FlutterFlow compatibility
Future<FileInfoStruct> _pickLocalFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.any,
    allowMultiple: false,
    withData: false,
  );

  // Handle cancellation
  if (result?.files.isEmpty != false) {
    return _buildResult(
      status: 'info',
      message: 'No file selected. Please choose a file to continue.',
    );
  }

  final file = result!.files.first;

  // Validate file name
  if (file.name.isEmpty) {
    return _buildResult(
      status: 'error',
      message: 'Invalid file selected. File appears corrupted.',
    );
  }

  // Check for compressed files
  if (_isCompressed(file.name)) {
    final ext = path.extension(file.name).toUpperCase();
    return _buildResult(
      status: 'error',
      message:
          'Compressed files not supported. Please select a regular file instead of $ext archives.',
    );
  }

  // Process file metadata
  final metadata = await _extractLocalMetadata(file);

  // Verify Google Drive access if needed
  if (!metadata.isLocal && FFAppState().GOOGLEDRIVEAPIKEY.isNotEmpty) {
    final accessible = await _verifyDriveAccess(metadata.path);
    if (!accessible) {
      return _buildResult(
        status: 'error',
        message: 'Google Drive file not accessible. Check permissions.',
      );
    }
  }

  // Success response
  final message = metadata.isLocal
      ? 'File loaded successfully! Ready to process ${metadata.name}.'
      : 'Cloud file accessed successfully! ${metadata.name} ready for processing.';

  return _buildResult(
    status: 'success',
    message: '$message (${_formatSize(metadata.size)})',
    metadata: metadata,
  );
}

// URL file analysis
Future<FileInfoStruct> _analyzeUrlFile(String url) async {
  // Validate URL format
  if (!_isValidUrl(url)) {
    return _buildResult(
      status: 'error',
      message: 'Invalid URL format provided.',
    );
  }

  final fileName = _extractFileName(url);

  // Check for compressed files
  if (_isCompressed(fileName)) {
    return _buildResult(
      status: 'error',
      message: 'Compressed files not supported from URL.',
    );
  }

  // Fetch metadata
  final metadata = await _fetchUrlMetadata(url, fileName);
  if (metadata == null) {
    return _buildResult(
      status: 'error',
      message: 'Cannot access file from URL. Check accessibility.',
    );
  }

  return _buildResult(
    status: 'success',
    message:
        'Remote file analyzed: ${metadata.name} (${_formatSize(metadata.size)})',
    metadata: metadata,
  );
}

// Internal metadata class
class _FileMetadata {
  final String name, path, mimeType;
  final int size;
  final DateTime timestamp;
  final bool isLocal;

  const _FileMetadata({
    required this.name,
    required this.path,
    required this.mimeType,
    required this.size,
    required this.timestamp,
    required this.isLocal,
  });
}

// Extract local file metadata
Future<_FileMetadata> _extractLocalMetadata(PlatformFile file) async {
  final filePath = file.path ?? file.identifier ?? 'cloud_${file.name}';
  final isLocal = _isLocalFile(filePath, file);

  int size = file.size;
  DateTime timestamp = DateTime.now();

  // Get file stats for truly local files only
  if (isLocal && !filePath.startsWith('content://')) {
    try {
      final stat = await File(filePath).stat();
      size = stat.size;
      timestamp = stat.modified;
    } catch (e) {
      debugPrint('Local file stat failed: $e');
    }
  }

  return _FileMetadata(
    name: file.name,
    path: filePath,
    mimeType: _getMimeType(file.name),
    size: size,
    timestamp: timestamp,
    isLocal: isLocal,
  );
}

// Fetch URL metadata with single HTTP request
Future<_FileMetadata?> _fetchUrlMetadata(String url, String fileName) async {
  try {
    // Handle Google Drive URLs
    if (_isGoogleDriveUrl(url)) {
      return await _getDriveMetadata(url);
    }

    // Single HEAD request for regular URLs
    final response = await FileAnalyzer._client.head(
      Uri.parse(url),
      headers: {'User-Agent': 'FlutterFlow-FileAnalyzer/1.0'},
    ).timeout(const Duration(seconds: 8));

    if (response.statusCode != 200) return null;

    final headers = response.headers;
    final size = int.tryParse(headers['content-length'] ?? '0') ?? 0;

    // Extract MIME type
    String mimeType = headers['content-type']?.split(';').first.trim() ?? '';
    if (mimeType.isEmpty) mimeType = _getMimeType(fileName);

    // Extract filename from Content-Disposition
    String finalName = fileName;
    final disposition = headers['content-disposition'];
    if (disposition?.contains('filename=') == true) {
      final match = RegExp(r'filename[*]?=([^;]+)').firstMatch(disposition!);
      finalName = match?.group(1)?.replaceAll('"', '').trim() ?? fileName;
    }

    // Parse timestamp
    DateTime timestamp = DateTime.now();
    final lastModified = headers['last-modified'];
    if (lastModified != null) {
      try {
        timestamp = HttpDate.parse(lastModified);
      } catch (_) {}
    }

    return _FileMetadata(
      name: finalName,
      path: url,
      mimeType: mimeType,
      size: size,
      timestamp: timestamp,
      isLocal: false,
    );
  } catch (e) {
    debugPrint('URL metadata fetch failed: $e');
    return null;
  }
}

// Google Drive metadata with minimal API usage
Future<_FileMetadata?> _getDriveMetadata(String url) async {
  final apiKey = FFAppState().GOOGLEDRIVEAPIKEY;
  if (apiKey.isEmpty) return null;

  final fileId = _extractDriveFileId(url);
  if (fileId == null) return null;

  try {
    final response = await FileAnalyzer._client.get(
      Uri.parse('https://www.googleapis.com/drive/v3/files/$fileId'
          '?fields=name,mimeType,size,modifiedTime&key=$apiKey'),
      headers: {'Accept': 'application/json'},
    ).timeout(const Duration(seconds: 8));

    if (response.statusCode != 200) return null;

    final data = json.decode(response.body);
    return _FileMetadata(
      name: data['name'] ?? 'google_drive_file',
      path: url,
      mimeType: data['mimeType'] ?? 'application/octet-stream',
      size: int.tryParse(data['size']?.toString() ?? '0') ?? 0,
      timestamp:
          DateTime.tryParse(data['modifiedTime'] ?? '') ?? DateTime.now(),
      isLocal: false,
    );
  } catch (e) {
    debugPrint('Drive API failed: $e');
    return null;
  }
}

// Verify Google Drive access
Future<bool> _verifyDriveAccess(String filePath) async {
  final fileId = _extractDriveFileId(filePath);
  if (fileId == null) return true;

  try {
    final response = await FileAnalyzer._client
        .head(
          Uri.parse('https://www.googleapis.com/drive/v3/files/$fileId'
              '?key=${FFAppState().GOOGLEDRIVEAPIKEY}'),
        )
        .timeout(const Duration(seconds: 5));

    return response.statusCode == 200;
  } catch (_) {
    return true; // Assume accessible on errors
  }
}

// Utility functions
bool _isCompressed(String fileName) {
  final ext = path.extension(fileName).toLowerCase().replaceFirst('.', '');
  return FileAnalyzer._compressedExts.contains(ext);
}

String _getMimeType(String fileName) {
  final detected = lookupMimeType(fileName);
  if (detected != null) return detected;

  final ext = path.extension(fileName).toLowerCase().replaceFirst('.', '');
  return FileAnalyzer._mimeMap[ext] ?? 'application/octet-stream';
}

bool _isValidUrl(String url) {
  final uri = Uri.tryParse(url);
  return uri?.hasScheme == true && ['http', 'https'].contains(uri?.scheme);
}

bool _isGoogleDriveUrl(String url) =>
    url.contains('drive.google.com') || url.contains('googleapis.com/drive');

String _extractFileName(String url) {
  if (_isGoogleDriveUrl(url)) return 'google_drive_file';

  final uri = Uri.tryParse(url);
  final segments = uri?.pathSegments ?? [];
  return segments.isNotEmpty ? segments.last.split('?').first : 'remote_file';
}

String? _extractDriveFileId(String path) {
  final patterns = [
    RegExp(r'/file/d/([a-zA-Z0-9_-]+)'),
    RegExp(r'[?&]id=([a-zA-Z0-9_-]+)'),
  ];

  for (final pattern in patterns) {
    final match = pattern.firstMatch(path);
    final id = match?.group(1);
    if (id != null && id.length >= 25 && id.length <= 44) return id;
  }
  return null;
}

bool _isLocalFile(String filePath, PlatformFile platformFile) {
  if (filePath.startsWith('http')) return false;
  if (filePath.startsWith('content://com.google')) return false;
  if (filePath.contains('drive.google.com')) return false;

  return platformFile.path?.isNotEmpty == true &&
      !platformFile.path!.startsWith('content://');
}

String _mapErrorMessage(String error) {
  final lower = error.toLowerCase();
  if (lower.contains('permission'))
    return 'Permission denied. Check file access.';
  if (lower.contains('network')) return 'Network error. Check connection.';
  if (lower.contains('timeout')) return 'Request timeout. Try again.';
  if (lower.contains('google')) return 'Google Drive access failed.';
  return 'File processing error. Try different file.';
}

String _formatSize(int bytes) {
  if (bytes < 1024) return '${bytes}B';
  if (bytes < 1048576) return '${(bytes / 1024).toStringAsFixed(1)}KB';
  if (bytes < 1073741824) return '${(bytes / 1048576).toStringAsFixed(1)}MB';
  return '${(bytes / 1073741824).toStringAsFixed(1)}GB';
}

// FlutterFlow-compatible result builder
FileInfoStruct _buildResult({
  required String status,
  required String message,
  _FileMetadata? metadata,
}) {
  return FileInfoStruct(
    name: metadata?.name ?? '',
    filePath: metadata?.path ?? '',
    mimeType: metadata?.mimeType ?? '',
    sizeBytes: metadata?.size ?? 0,
    createdAt: metadata?.timestamp ?? DateTime.now(),
    lastOpened: metadata?.timestamp ?? DateTime.now(),
    isLocalOnly: metadata?.isLocal ?? true,
    status: status,
    message: message,
  );
}
