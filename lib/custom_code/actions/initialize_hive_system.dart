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

import 'dart:async';
import 'dart:io';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

/// Simplified Android-optimized Hive manager
class HiveManager {
  static bool _initialized = false;
  static final Map<String, Box> _boxes = {};
  static Timer? _cleanupTimer;

  // Box constants
  static const String ATTENDANCE_BOX = 'attendance_cache';
  static const String CLASSES_BOX = 'classes_cache';
  static const String MISSED_CLASSES_BOX = 'missed_classes_cache';
  static const String COURSE_ATTENDANCE_BOX = 'course_attendance_cache';
  static const String FILE_CACHE_BOX = 'file_cache_data';

  // Android-optimized limits
  static const int maxCacheFiles = 30;
  static const int maxCacheMB = 15;
}

/// Initialize Hive with Android optimization
Future<bool> initializeHiveSystem() async {
  if (HiveManager._initialized) return true;

  try {
    if (!kIsWeb) {
      // Get the best available directory for Android
      final dir = await _getBestDirectory();
      if (dir != null) {
        final hivePath = '${dir.path}/.hive';
        await Directory(hivePath).create(recursive: true);
        Hive.init(hivePath);
      }
    }

    HiveManager._initialized = true;

    // Start cleanup timer for Android memory management
    if (!kIsWeb && Platform.isAndroid) {
      _startCleanupTimer();
    }

    return true;
  } catch (e) {
    debugPrint('Hive init failed: $e');

    // Fallback to default initialization
    try {
      Hive.init(null);
      HiveManager._initialized = true;
      return true;
    } catch (_) {
      return false;
    }
  }
}

/// Get best directory for Android storage
Future<Directory?> _getBestDirectory() async {
  try {
    // Try application support directory first (most reliable)
    return await getApplicationSupportDirectory();
  } catch (_) {
    try {
      // Fallback to documents directory
      return await getApplicationDocumentsDirectory();
    } catch (_) {
      try {
        // Last resort: temporary directory
        return await getTemporaryDirectory();
      } catch (_) {
        return null;
      }
    }
  }
}

/// Get or open a Hive box with error handling
Future<Box<T>?> getBox<T>(String boxName) async {
  if (!HiveManager._initialized) {
    final success = await initializeHiveSystem();
    if (!success) return null;
  }

  // Return existing box if already open
  if (HiveManager._boxes.containsKey(boxName)) {
    final box = HiveManager._boxes[boxName];
    if (box?.isOpen == true) {
      return box as Box<T>;
    } else {
      HiveManager._boxes.remove(boxName);
    }
  }

  try {
    final box = await Hive.openBox<T>(boxName);
    HiveManager._boxes[boxName] = box;
    return box;
  } catch (e) {
    debugPrint('Failed to open box $boxName: $e');
    return null;
  }
}

/// Close a specific box
Future<void> closeBox(String boxName) async {
  final box = HiveManager._boxes[boxName];
  if (box?.isOpen == true) {
    try {
      await box!.close();
    } catch (e) {
      debugPrint('Error closing box $boxName: $e');
    }
  }
  HiveManager._boxes.remove(boxName);
}

/// Close all boxes and cleanup
Future<void> closeAllBoxes() async {
  HiveManager._cleanupTimer?.cancel();

  final boxNames = List<String>.from(HiveManager._boxes.keys);
  for (final name in boxNames) {
    await closeBox(name);
  }

  HiveManager._boxes.clear();
}

/// Start periodic cleanup timer for Android
void _startCleanupTimer() {
  HiveManager._cleanupTimer?.cancel();
  HiveManager._cleanupTimer = Timer.periodic(
    const Duration(hours: 4),
    (_) => _performCleanup(),
  );
}

/// Perform cache cleanup optimized for Android memory
Future<void> _performCleanup() async {
  try {
    final cacheBox = await getBox<Map>('file_cache');
    if (cacheBox == null || cacheBox.isEmpty) return;

    final entries = cacheBox.toMap().entries.toList();
    if (entries.length <= HiveManager.maxCacheFiles) return;

    // Sort by last access time (oldest first)
    entries.sort((a, b) {
      final aTime =
          DateTime.tryParse(a.value['lastAccessed'] ?? '') ?? DateTime(0);
      final bTime =
          DateTime.tryParse(b.value['lastAccessed'] ?? '') ?? DateTime(0);
      return aTime.compareTo(bTime);
    });

    // Remove oldest 40% of files
    final removeCount = (entries.length * 0.4).round();
    final toRemove = entries.take(removeCount);

    for (final entry in toRemove) {
      final filePath = entry.value['filePath'];
      if (filePath != null) {
        await _deleteFile(filePath);
      }
      await cacheBox.delete(entry.key);
    }

    // Compact box for better performance
    await cacheBox.compact();
  } catch (e) {
    debugPrint('Cleanup failed: $e');
  }
}

/// Safely delete a file
Future<void> _deleteFile(String path) async {
  try {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  } catch (e) {
    debugPrint('Failed to delete file: $e');
  }
}

/// Manual cleanup trigger
Future<void> cleanupCache() async {
  await _performCleanup();
}

/// Get system status for debugging
Map<String, dynamic> getSystemStatus() {
  return {
    'initialized': HiveManager._initialized,
    'openBoxes': HiveManager._boxes.keys.toList(),
    'platform': kIsWeb ? 'web' : Platform.operatingSystem,
  };
}

/// Check if Hive is initialized
bool get isInitialized => HiveManager._initialized;

/// Get number of open boxes
int get openBoxCount => HiveManager._boxes.length;
