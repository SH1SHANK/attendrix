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
import 'package:hive_ce/hive.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

// Enhanced global state with better error handling
class HiveManager {
  static bool _isInitialized = false;
  static String? _hivePath;
  static final Map<String, Box> _openBoxes = <String, Box>{};
  static final Set<String> _initializingBoxes = <String>{};

  // Box constants
  static const String ATTENDANCE_BOX = 'attendance_cache';
  static const String CLASSES_BOX = 'classes_cache';
  static const String MISSED_CLASSES_BOX = 'missed_classes_cache';
  static const String COURSE_ATTENDANCE_BOX = 'course_attendance_cache';
  static const String FILE_CACHE_BOX = 'file_cache_data';

  // Optimized cache limits for Android
  static const int MAX_CACHE_MB = 25; // Reduced for Android memory constraints
  static const int MAX_FILES = 50;
  static const Duration CACHE_CLEANUP_INTERVAL = Duration(hours: 6);
}

/// Initialize Hive with Android-optimized path selection
Future<bool> initializeHiveSystem() async {
  if (HiveManager._isInitialized) return true;

  try {
    if (!kIsWeb) {
      // Android-optimized path selection with fallbacks
      Directory? baseDir;

      try {
        // Primary: Use getApplicationSupportDirectory (most reliable on Android)
        baseDir = await getApplicationSupportDirectory();
      } catch (e) {
        try {
          // Fallback: Use getApplicationDocumentsDirectory
          baseDir = await getApplicationDocumentsDirectory();
        } catch (e2) {
          // Final fallback: Use temporary directory
          baseDir = await getTemporaryDirectory();
        }
      }

      if (baseDir == null) {
        // Let Hive use default system path
        Hive.init(null);
      } else {
        HiveManager._hivePath = '${baseDir.path}/hive_cache';

        // Ensure directory exists with proper error handling
        final hiveDir = Directory(HiveManager._hivePath!);
        if (!await hiveDir.exists()) {
          await hiveDir.create(recursive: true);
        }

        // Verify directory is writable (Android-specific check)
        await _verifyDirectoryWritable(hiveDir);

        Hive.init(HiveManager._hivePath);
      }
    } else {
      // Web initialization
      Hive.init(null);
    }

    HiveManager._isInitialized = true;

    // Schedule periodic cache cleanup for Android memory management
    if (!kIsWeb && Platform.isAndroid) {
      _schedulePeriodicCleanup();
    }

    return true;
  } catch (e) {
    debugPrint('Hive initialization failed: $e');

    // Emergency fallback: try default Hive initialization
    try {
      Hive.init(null);
      HiveManager._isInitialized = true;
      return true;
    } catch (fallbackError) {
      debugPrint('Fallback Hive initialization also failed: $fallbackError');
      return false;
    }
  }
}

/// Verify directory is writable (Android compatibility check)
Future<void> _verifyDirectoryWritable(Directory dir) async {
  final testFile = File('${dir.path}/.test_write');
  try {
    await testFile.writeAsString('test');
    await testFile.delete();
  } catch (e) {
    throw Exception('Directory not writable: ${dir.path}');
  }
}

/// Enhanced box getter with concurrent access protection
Future<Box<T>?> getHiveBox<T>(String boxName) async {
  if (!HiveManager._isInitialized) {
    final initialized = await initializeHiveSystem();
    if (!initialized) return null;
  }

  // Check if box is already open and valid
  if (HiveManager._openBoxes.containsKey(boxName)) {
    final box = HiveManager._openBoxes[boxName];
    if (box != null && box.isOpen) {
      return box as Box<T>;
    } else {
      // Remove invalid box reference
      HiveManager._openBoxes.remove(boxName);
    }
  }

  // Prevent concurrent box opening
  if (HiveManager._initializingBoxes.contains(boxName)) {
    // Wait for concurrent initialization to complete
    int attempts = 0;
    while (HiveManager._initializingBoxes.contains(boxName) && attempts < 50) {
      await Future.delayed(const Duration(milliseconds: 100));
      attempts++;
    }

    // Return the box if it was opened by concurrent operation
    if (HiveManager._openBoxes.containsKey(boxName)) {
      return HiveManager._openBoxes[boxName] as Box<T>?;
    }
  }

  HiveManager._initializingBoxes.add(boxName);

  try {
    final box = await Hive.openBox<T>(boxName);
    HiveManager._openBoxes[boxName] = box;
    return box;
  } catch (e) {
    debugPrint('Failed to open Hive box $boxName: $e');

    // Android-specific recovery: try with different box name
    if (!kIsWeb && Platform.isAndroid) {
      try {
        final recoveryBoxName = '${boxName}_recovery';
        final recoveryBox = await Hive.openBox<T>(recoveryBoxName);
        HiveManager._openBoxes[boxName] = recoveryBox;
        return recoveryBox;
      } catch (recoveryError) {
        debugPrint('Recovery box creation failed: $recoveryError');
      }
    }

    return null;
  } finally {
    HiveManager._initializingBoxes.remove(boxName);
  }
}

/// Safe box closure with error handling
Future<void> closeHiveBox(String boxName) async {
  if (!HiveManager._openBoxes.containsKey(boxName)) return;

  final box = HiveManager._openBoxes[boxName];
  if (box != null && box.isOpen) {
    try {
      await box.close();
    } catch (e) {
      debugPrint('Error closing box $boxName: $e');
    }
  }
  HiveManager._openBoxes.remove(boxName);
}

/// Enhanced cleanup for all boxes
Future<void> closeAllHiveBoxes() async {
  final boxNames = List<String>.from(HiveManager._openBoxes.keys);

  for (final boxName in boxNames) {
    await closeHiveBox(boxName);
  }

  HiveManager._openBoxes.clear();
  HiveManager._initializingBoxes.clear();
}

/// Android-optimized cache management with memory awareness
Future<void> optimizedCacheCleanup() async {
  try {
    final cacheBox = await getHiveBox<Map>(HiveManager.FILE_CACHE_BOX);
    if (cacheBox == null || cacheBox.isEmpty) return;

    final entries = cacheBox.toMap().entries.toList();
    if (entries.length <= HiveManager.MAX_FILES) return;

    // Sort by access frequency and recency (Android memory optimization)
    entries.sort((a, b) {
      final aData = a.value;
      final bData = b.value;

      final aLastAccessed =
          DateTime.tryParse(aData['lastAccessed'] ?? '') ?? DateTime(1970);
      final bLastAccessed =
          DateTime.tryParse(bData['lastAccessed'] ?? '') ?? DateTime(1970);
      final aAccessCount = aData['accessCount'] ?? 0;
      final bAccessCount = bData['accessCount'] ?? 0;

      // Prioritize by access frequency, then by recency
      final aScore = aAccessCount * 1000 + aLastAccessed.millisecondsSinceEpoch;
      final bScore = bAccessCount * 1000 + bLastAccessed.millisecondsSinceEpoch;

      return aScore.compareTo(bScore);
    });
    // Remove least used 30% for Android memory efficiency
    final removeCount = (entries.length * 0.3).ceil();
    final List<Future<void>> deletionTasks = [];

    for (int i = 0; i < removeCount && i < entries.length; i++) {
      final entryData = entries[i].value;
      final filePath = entryData['filePath'];

      if (filePath != null) {
        deletionTasks.add(_safeFileDelete(filePath));
      }
      deletionTasks.add(cacheBox.delete(entries[i].key));
    }

    // Execute deletions concurrently for better performance
    await Future.wait(deletionTasks, eagerError: false);

    // Compact the box after cleanup (Android optimization)
    await cacheBox.compact();
  } catch (e) {
    debugPrint('Cache cleanup failed: $e');
  }
}

/// Safe file deletion with error handling
Future<void> _safeFileDelete(String filePath) async {
  try {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  } catch (e) {
    debugPrint('Failed to delete file $filePath: $e');
  }
}

/// Schedule periodic cleanup for Android memory management
void _schedulePeriodicCleanup() {
  Timer.periodic(HiveManager.CACHE_CLEANUP_INTERVAL, (timer) {
    optimizedCacheCleanup();
  });
}

/// Enhanced getters with null safety
bool get isHiveInitialized => HiveManager._isInitialized;
String? get hivePath => HiveManager._hivePath;
int get openBoxCount => HiveManager._openBoxes.length;

/// Utility function to check Hive health (Android diagnostics)
Future<Map<String, dynamic>> getHiveSystemStatus() async {
  return {
    'initialized': HiveManager._isInitialized,
    'hivePath': HiveManager._hivePath,
    'openBoxes': HiveManager._openBoxes.keys.toList(),
    'initializingBoxes': HiveManager._initializingBoxes.toList(),
    'platform': kIsWeb ? 'web' : Platform.operatingSystem,
    'timestamp': DateTime.now().toIso8601String(),
  };
}
