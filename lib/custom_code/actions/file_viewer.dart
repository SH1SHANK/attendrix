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

import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';

// Simple cache configuration
const int MAX_CACHE_FILES = 20;
const int MAX_FILE_SIZE_MB = 30;
const int CACHE_EXPIRY_DAYS = 7;

Future<String> fileViewer(String? fileUrl) async {
  try {
    if (fileUrl?.isEmpty != false) return '';

    final url = fileUrl!;

    // Web platform handling
    if (kIsWeb) {
      return await _handleWebFile(url);
    }

    // Check cache first for mobile/desktop
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
  try {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      return url;
    }
  } catch (e) {
    debugPrint('Failed to launch URL: $e');
  }
  return '';
}

Future<String> _processRemoteFile(String url) async {
  try {
    String downloadUrl = url;
    String fileName = _extractFileName(url);

    // Handle Google Drive URLs
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

    // Check file size before downloading
    final headResponse =
        await http.head(Uri.parse(downloadUrl)).timeout(Duration(seconds: 10));

    if (headResponse.statusCode != 200) return '';

    final contentLength = headResponse.headers['content-length'];
    if (contentLength != null) {
      final fileSizeMB = int.parse(contentLength) / (1024 * 1024);
      if (fileSizeMB > MAX_FILE_SIZE_MB) {
        debugPrint('File too large: ${fileSizeMB.toStringAsFixed(1)}MB');
        return '';
      }
    }

    // Download file
    final response =
        await http.get(Uri.parse(downloadUrl)).timeout(Duration(seconds: 30));

    if (response.statusCode != 200) return '';

    // Create cache directory
    final cacheDir = await _getCacheDirectory();
    final hashedFileName = _generateHashedFileName(url, fileName);
    final cachedFile = File('${cacheDir.path}/$hashedFileName');

    // Write file to cache
    await cachedFile.writeAsBytes(response.bodyBytes);

    // Update cache metadata
    await _updateCacheMetadata(url, cachedFile.path, fileName);

    // Clean old cache files
    await _cleanOldCacheFiles();

    // Open file
    return await _openFile(cachedFile.path);
  } catch (e) {
    debugPrint('Remote file processing failed: $e');
    return '';
  }
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

// Lightweight cache system using SharedPreferences
Future<String?> _getCachedFilePath(String url) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final cacheData = prefs.getString('file_cache_${url.hashCode}');

    if (cacheData != null) {
      final data = json.decode(cacheData) as Map<String, dynamic>;
      final cachedAt = DateTime.parse(data['cachedAt']);
      final filePath = data['filePath'] as String;

      // Check if cache is expired
      if (DateTime.now().difference(cachedAt).inDays > CACHE_EXPIRY_DAYS) {
        await _removeCacheEntry(url);
        return null;
      }

      // Update access time
      data['lastAccessed'] = DateTime.now().toIso8601String();
      data['accessCount'] = (data['accessCount'] ?? 0) + 1;
      await prefs.setString('file_cache_${url.hashCode}', json.encode(data));

      return filePath;
    }

    return null;
  } catch (e) {
    debugPrint('Cache retrieval failed: $e');
    return null;
  }
}

Future<void> _updateCacheMetadata(
    String url, String filePath, String fileName) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();

    final cacheData = {
      'fileName': fileName,
      'filePath': filePath,
      'cachedAt': now.toIso8601String(),
      'lastAccessed': now.toIso8601String(),
      'accessCount': 1,
      'url': url,
    };

    await prefs.setString('file_cache_${url.hashCode}', json.encode(cacheData));

    // Update cache list
    final cacheList = prefs.getStringList('cached_files') ?? [];
    final cacheKey = 'file_cache_${url.hashCode}';

    if (!cacheList.contains(cacheKey)) {
      cacheList.add(cacheKey);
      await prefs.setStringList('cached_files', cacheList);
    }
  } catch (e) {
    debugPrint('Cache metadata update failed: $e');
  }
}

Future<void> _cleanOldCacheFiles() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final cacheList = prefs.getStringList('cached_files') ?? [];

    if (cacheList.length <= MAX_CACHE_FILES) return;

    // Get all cache entries with timestamps
    final cacheEntries = <Map<String, dynamic>>[];

    for (final cacheKey in cacheList) {
      final cacheData = prefs.getString(cacheKey);
      if (cacheData != null) {
        final data = json.decode(cacheData) as Map<String, dynamic>;
        data['cacheKey'] = cacheKey;
        cacheEntries.add(data);
      }
    }

    // Sort by last accessed time (oldest first)
    cacheEntries.sort((a, b) {
      final aTime = DateTime.parse(a['lastAccessed'] ?? a['cachedAt']);
      final bTime = DateTime.parse(b['lastAccessed'] ?? b['cachedAt']);
      return aTime.compareTo(bTime);
    });

    // Remove oldest entries
    final entriesToRemove = cacheEntries.length - MAX_CACHE_FILES;
    for (int i = 0; i < entriesToRemove; i++) {
      final entry = cacheEntries[i];
      final filePath = entry['filePath'] as String?;
      final cacheKey = entry['cacheKey'] as String;

      // Delete physical file
      if (filePath != null) {
        try {
          await File(filePath).delete();
        } catch (_) {}
      }

      // Remove from preferences
      await prefs.remove(cacheKey);
      cacheList.remove(cacheKey);
    }

    // Update cache list
    await prefs.setStringList('cached_files', cacheList);
  } catch (e) {
    debugPrint('Cache cleanup failed: $e');
  }
}

Future<void> _removeCacheEntry(String url) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = 'file_cache_${url.hashCode}';

    // Get file path before removing
    final cacheData = prefs.getString(cacheKey);
    if (cacheData != null) {
      final data = json.decode(cacheData) as Map<String, dynamic>;
      final filePath = data['filePath'] as String?;

      if (filePath != null) {
        try {
          await File(filePath).delete();
        } catch (_) {}
      }
    }

    // Remove from preferences
    await prefs.remove(cacheKey);

    // Update cache list
    final cacheList = prefs.getStringList('cached_files') ?? [];
    cacheList.remove(cacheKey);
    await prefs.setStringList('cached_files', cacheList);
  } catch (e) {
    debugPrint('Cache entry removal failed: $e');
  }
}

Future<Directory> _getCacheDirectory() async {
  if (Platform.isAndroid || Platform.isIOS) {
    final tempDir = await getTemporaryDirectory();
    final cacheDir = Directory('${tempDir.path}/file_cache');
    if (!await cacheDir.exists()) {
      await cacheDir.create(recursive: true);
    }
    return cacheDir;
  } else {
    // Desktop platforms
    final appDir = await getApplicationDocumentsDirectory();
    final cacheDir = Directory('${appDir.path}/file_cache');
    if (!await cacheDir.exists()) {
      await cacheDir.create(recursive: true);
    }
    return cacheDir;
  }
}

String _generateHashedFileName(String url, String originalFileName) {
  final urlHash = md5.convert(utf8.encode(url)).toString();
  final extension = path.extension(originalFileName);
  return '${urlHash}${extension}';
}

// Google Drive API functions
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

// Utility functions
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
  String fileName =
      segments.isNotEmpty ? segments.last.split('?').first : 'downloaded_file';

  // Ensure file has an extension
  if (!fileName.contains('.')) {
    fileName += '.bin';
  }

  return fileName;
}
