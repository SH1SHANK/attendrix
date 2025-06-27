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
import 'dart:typed_data';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'dart:convert';
// Remove dart:html import - replaced with url_launcher
import 'package:url_launcher/url_launcher.dart';
import 'package:hive_ce/hive.dart';

const String FILE_CACHE_BOX = 'file_cache_data';
const int MAX_CACHE_SIZE_MB = 50;

Future<String> fileViewer(String? fileUrl) async {
  // Initialize Hive system using the existing function
  final hiveInitialized = await initializeHiveSystem();
  if (!hiveInitialized) return '';

  try {
    if (fileUrl?.isEmpty != false) return '';

    final url = fileUrl!;

    // Web platform handling
    if (kIsWeb) {
      return await _handleWebFile(url);
    }

    // Check cache first
    final cachedPath = await _getCachedFilePath(url);
    if (cachedPath != null && await File(cachedPath).exists()) {
      final result = await _openFile(cachedPath);
      if (result.isNotEmpty) return result;
    }

    // Process file based on type
    return _isRemoteUrl(url)
        ? await _processRemoteFile(url)
        : await _processLocalFile(url);
  } catch (e) {
    debugPrint('FileViewer error: $e');
    return '';
  }
}

Future<String> _handleWebFile(String url) async {
  final fileName = _extractFileName(url);

  if (_canViewInBrowser(url)) {
    // Use url_launcher instead of html.window.open
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        return url;
      }
    } catch (e) {
      debugPrint('Failed to launch URL: $e');
    }
  } else {
    // For downloads on web, we need to use a different approach
    // Since we can't directly use html.AnchorElement, we'll use url_launcher
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        return url;
      }
    } catch (e) {
      debugPrint('Failed to download file: $e');
    }
  }

  return url;
}

Future<String> _processRemoteFile(String url) async {
  try {
    String downloadUrl = url;
    String fileName = _extractFileName(url);

    // Handle Google Drive URLs with API key
    if (_isGoogleDriveUrl(url)) {
      final apiKey = FFAppState().GOOGLEDRIVEAPIKEY;
      if (apiKey.isNotEmpty) {
        final fileId = _extractGoogleDriveFileId(url);
        if (fileId != null) {
          final metadata = await _getGoogleDriveMetadata(fileId, apiKey);
          if (metadata != null) {
            fileName = metadata['name'] ?? fileName;
            downloadUrl =
                'https://www.googleapis.com/drive/v3/files/$fileId?alt=media&key=$apiKey';
          }
        }
      }
    }

    // Download file
    final response =
        await http.get(Uri.parse(downloadUrl)).timeout(Duration(seconds: 30));
    if (response.statusCode != 200) return '';

    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/$fileName');

    await tempFile.writeAsBytes(response.bodyBytes);

    // Cache file in background
    _cacheFileAsync(url, fileName, response.bodyBytes, tempFile.path);

    // Open file immediately
    return await _openFile(tempFile.path);
  } catch (e) {
    debugPrint('Remote file processing failed: $e');
    return '';
  }
}

Future<Map<String, dynamic>?> _getGoogleDriveMetadata(
    String fileId, String apiKey) async {
  try {
    final response = await http.get(
      Uri.parse(
          'https://www.googleapis.com/drive/v3/files/$fileId?fields=name,mimeType,size&key=$apiKey'),
      headers: {'Accept': 'application/json'},
    ).timeout(Duration(seconds: 10));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
  } catch (e) {
    debugPrint('Google Drive metadata fetch failed: $e');
  }
  return null;
}

String? _extractGoogleDriveFileId(String url) {
  final patterns = [
    RegExp(r'/file/d/([a-zA-Z0-9_-]+)'),
    RegExp(r'[?&]id=([a-zA-Z0-9_-]+)'),
  ];

  for (final pattern in patterns) {
    final match = pattern.firstMatch(url);
    final id = match?.group(1);
    if (id != null && id.length >= 25 && id.length <= 44) return id;
  }
  return null;
}

Future<String> _processLocalFile(String filePath) async {
  final file = File(filePath);

  if (!await file.exists()) {
    debugPrint('Local file not found: $filePath');
    return '';
  }

  return await _openFile(filePath);
}

Future<String> _openFile(String filePath) async {
  try {
    final result = await OpenFilex.open(filePath);
    return result.type == ResultType.done ? filePath : '';
  } catch (e) {
    debugPrint('File open failed: $e');
    return '';
  }
}

// Direct Hive access without using getHiveBox function
Future<String?> _getCachedFilePath(String url) async {
  try {
    if (!Hive.isBoxOpen(FILE_CACHE_BOX)) {
      await Hive.openBox<Map>(FILE_CACHE_BOX);
    }

    final cacheBox = Hive.box<Map>(FILE_CACHE_BOX);
    final cacheKey = url.hashCode.toString();
    final cached = cacheBox.get(cacheKey);

    if (cached != null) {
      final data = Map<String, dynamic>.from(cached);
      // Update access time
      data['lastAccessed'] = DateTime.now().toIso8601String();
      data['openCount'] = (data['openCount'] ?? 0) + 1;
      await cacheBox.put(cacheKey, data);

      return data['filePath'] as String?;
    }

    return null;
  } catch (e) {
    debugPrint('Cache retrieval failed: $e');
    return null;
  }
}

void _cacheFileAsync(
    String url, String fileName, Uint8List fileBytes, String filePath) async {
  try {
    if (!Hive.isBoxOpen(FILE_CACHE_BOX)) {
      await Hive.openBox<Map>(FILE_CACHE_BOX);
    }

    final cacheBox = Hive.box<Map>(FILE_CACHE_BOX);

    // Simple cache management
    if (cacheBox.length > 100) {
      final entries = cacheBox.toMap().entries.toList();
      entries.sort((a, b) {
        final aTime = a.value['lastAccessed'] ?? '';
        final bTime = b.value['lastAccessed'] ?? '';
        return aTime.compareTo(bTime);
      });

      // Remove oldest 20 entries
      for (int i = 0; i < 20 && i < entries.length; i++) {
        final filePath = entries[i].value['filePath'];
        if (filePath != null) {
          try {
            await File(filePath).delete();
          } catch (_) {}
        }
        await cacheBox.delete(entries[i].key);
      }
    }

    final cacheKey = url.hashCode.toString();
    final now = DateTime.now();

    final cacheData = {
      'fileName': fileName,
      'filePath': filePath,
      'cachedAt': now.toIso8601String(),
      'lastAccessed': now.toIso8601String(),
      'openCount': 1,
      'sizeBytes': fileBytes.length,
    };

    await cacheBox.put(cacheKey, cacheData);
  } catch (e) {
    debugPrint('Caching failed: $e');
  }
}

bool _isRemoteUrl(String url) {
  return url.startsWith('http://') || url.startsWith('https://');
}

bool _isGoogleDriveUrl(String url) {
  return url.contains('drive.google.com') ||
      url.contains('googleapis.com/drive');
}

String _extractFileName(String url) {
  if (_isGoogleDriveUrl(url)) return 'google_drive_file';

  final uri = Uri.tryParse(url);
  final segments = uri?.pathSegments ?? [];
  return segments.isNotEmpty
      ? segments.last.split('?').first
      : 'downloaded_file';
}

bool _canViewInBrowser(String url) {
  final ext = path.extension(url).toLowerCase();
  return ['.pdf', '.txt', '.jpg', '.jpeg', '.png', '.gif', '.mp4', '.mp3']
          .contains(ext) ||
      url.contains('drive.google.com') ||
      url.contains('docs.google.com');
}
