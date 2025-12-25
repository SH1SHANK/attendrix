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

// DO NOT REMOVE OR MODIFY THE CODE ABOVE

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

Future manageUserStreaks(
  String userID,
  bool fullDayAttendance,
  DateTime? classStartTime, // Made optional since it might be null
) async {
  try {
    final now = DateTime.now();
    final currentDateInt = _dateToInt(now);

    int targetDateInt = currentDateInt;
    bool isPastDate = false;

    if (classStartTime != null) {
      targetDateInt = _dateToInt(classStartTime);
      isPastDate = targetDateInt != currentDateInt;
    }

    // Modified logic: If it's current date and not full attendance, check and remove from history
    if (!fullDayAttendance && !isPastDate) {
      print(
          '[Streak Log] Current date with incomplete attendance - checking for removal');
      await _handleCurrentDateIncompleteAttendance(userID, currentDateInt);
      return;
    }

    final userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userID);
    final userDoc = await userDocRef.get();

    if (!userDoc.exists) {
      if (fullDayAttendance) {
        await _createNewUser(userDocRef, targetDateInt);
        print(
            '[Streak Log] New user initialized: ${_intToDateString(targetDateInt)}');
      }
      return;
    }

    final userData = userDoc.data()!;
    final streakData = _parseUserData(userData);

    if (streakData.dates.isEmpty) {
      if (fullDayAttendance) {
        await _initializeFirstStreak(
            userDocRef, targetDateInt, streakData.longestStreak);
        print(
            '[Streak Log] First streak recorded: ${_intToDateString(targetDateInt)}');
      }
      return;
    }

    final dateExists = _containsDate(streakData.dates, targetDateInt);

    if (!fullDayAttendance) {
      await _handleAttendanceRemoval(
          userDocRef, streakData, targetDateInt, currentDateInt, dateExists);
    } else {
      await _handleAttendanceAddition(userDocRef, streakData, targetDateInt,
          currentDateInt, dateExists, isPastDate);
    }
  } catch (e) {
    print('Error in manageUserStreaks: $e');
  }
}

// New function to handle current date incomplete attendance
Future<void> _handleCurrentDateIncompleteAttendance(
  String userID,
  int currentDateInt,
) async {
  final userDocRef = FirebaseFirestore.instance.collection('users').doc(userID);
  final userDoc = await userDocRef.get();

  if (!userDoc.exists) {
    print('[Streak Log] User does not exist - nothing to remove');
    return;
  }

  final userData = userDoc.data()!;
  final streakData = _parseUserData(userData);

  if (streakData.dates.isEmpty) {
    print('[Streak Log] No streak history - nothing to remove');
    return;
  }

  final dateExists = _containsDate(streakData.dates, currentDateInt);

  if (dateExists) {
    print(
        '[Streak Log] Current date found in history - removing due to incomplete attendance');
    streakData.dates.remove(currentDateInt);
    await _updateStreaks(
        userDocRef, streakData.dates, currentDateInt, streakData.longestStreak);
    print(
        '[Streak Log] Removed current date ${_intToDateString(currentDateInt)} and recalculated streaks');
  } else {
    print('[Streak Log] Current date not in history - nothing to remove');
  }
}

// Data structure to hold parsed user streak information
class _StreakData {
  final List<int> dates;
  final int currentStreak;
  final int longestStreak;

  _StreakData(this.dates, this.currentStreak, this.longestStreak);
}

// Convert DateTime to integer (days since Unix epoch) - IST TIMEZONE VERSION
int _dateToInt(DateTime date) {
  // Convert to IST timezone first, then normalize to midnight
  final istDate = _toIST(date);
  final istMidnight = DateTime(istDate.year, istDate.month, istDate.day);

  // Calculate days since Unix epoch (Jan 1, 1970) in IST
  final epoch = DateTime(1970, 1, 1);
  final difference = istMidnight.difference(epoch);
  return difference.inDays;
}

// Convert integer back to date string for logging
String _intToDateString(int dateInt) {
  final epoch = DateTime(1970, 1, 1);
  final date = epoch.add(Duration(days: dateInt));
  return '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} IST';
}

// Helper function to convert any DateTime to IST
DateTime _toIST(DateTime dateTime) {
  // IST is UTC+5:30
  const istOffset = Duration(hours: 5, minutes: 30);

  if (dateTime.isUtc) {
    return dateTime.add(istOffset);
  } else {
    // Convert to UTC first, then to IST
    return dateTime.toUtc().add(istOffset);
  }
}

// Parse user data from Firestore document
_StreakData _parseUserData(Map<String, dynamic> userData) {
  final currentStreak = userData['currentStreak'] ?? 0;
  final longestStreak = userData['longestStreak'] ?? 0;

  List<int> dates = [];
  final streakHistoryData = userData['streakHistory'];

  if (streakHistoryData != null) {
    if (streakHistoryData is List) {
      // Handle List format (expected format)
      dates = streakHistoryData
          .where((item) => item != null)
          .map((item) => item is int ? item : int.parse(item.toString()))
          .toList();
    } else if (streakHistoryData is String && streakHistoryData.isNotEmpty) {
      // Fallback for string format (legacy support)
      dates = streakHistoryData
          .split(',')
          .where((s) => s.trim().isNotEmpty)
          .map((s) => int.parse(s.trim()))
          .toList();
    }
    dates.sort(); // Ensure sorted order for binary operations
  }

  return _StreakData(dates, currentStreak, longestStreak);
}

// Create new user with initial streak
Future<void> _createNewUser(
    DocumentReference userDocRef, int targetDateInt) async {
  await userDocRef.set({
    'currentStreak': 1,
    'longestStreak': 1,
    'streakHistory': [targetDateInt], // Store as List<int>
  });
}

// Initialize first streak for existing user
Future<void> _initializeFirstStreak(DocumentReference userDocRef,
    int targetDateInt, int existingLongestStreak) async {
  await userDocRef.update({
    'currentStreak': 1,
    'longestStreak': existingLongestStreak < 1 ? 1 : existingLongestStreak,
    'streakHistory': [targetDateInt], // Store as List<int>
  });
}

// Binary search for date existence - O(log n)
bool _containsDate(List<int> sortedDates, int targetDate) {
  if (sortedDates.isEmpty) return false;

  int left = 0;
  int right = sortedDates.length - 1;

  while (left <= right) {
    final mid = (left + right) >>> 1;
    final midVal = sortedDates[mid];

    if (midVal == targetDate) return true;
    if (midVal < targetDate) {
      left = mid + 1;
    } else {
      right = mid - 1;
    }
  }
  return false;
}

// Binary search to find insertion index - O(log n)
int _findInsertionIndex(List<int> sortedDates, int targetDate) {
  int left = 0;
  int right = sortedDates.length;

  while (left < right) {
    final mid = (left + right) >>> 1;
    if (sortedDates[mid] < targetDate) {
      left = mid + 1;
    } else {
      right = mid;
    }
  }
  return left;
}

// Handle attendance removal
Future<void> _handleAttendanceRemoval(
  DocumentReference userDocRef,
  _StreakData streakData,
  int targetDateInt,
  int currentDateInt,
  bool dateExists,
) async {
  if (!dateExists) {
    print(
        '[Streak Log] Date ${_intToDateString(targetDateInt)} not found for removal');
    return;
  }

  streakData.dates.remove(targetDateInt);
  await _updateStreaks(
      userDocRef, streakData.dates, currentDateInt, streakData.longestStreak);
  print(
      '[Streak Log] Removed ${_intToDateString(targetDateInt)} and recalculated');
}

// Handle attendance addition
Future<void> _handleAttendanceAddition(
  DocumentReference userDocRef,
  _StreakData streakData,
  int targetDateInt,
  int currentDateInt,
  bool dateExists,
  bool isPastDate,
) async {
  if (dateExists) {
    if (isPastDate) {
      final recalculatedStreak =
          _calculateStreakEndingAt(streakData.dates, targetDateInt);
      if (recalculatedStreak > streakData.longestStreak) {
        await userDocRef.update({'longestStreak': recalculatedStreak});
        print('[Streak Log] Updated longest streak: $recalculatedStreak');
      }
    } else {
      print(
          '[Streak Log] Date ${_intToDateString(targetDateInt)} already exists');
    }
    return;
  }

  // Insert date maintaining sorted order
  final insertIndex = _findInsertionIndex(streakData.dates, targetDateInt);
  streakData.dates.insert(insertIndex, targetDateInt);

  await _updateStreaks(
      userDocRef, streakData.dates, currentDateInt, streakData.longestStreak);
  print(
      '[Streak Log] Added ${_intToDateString(targetDateInt)} and updated streaks');
}

// Calculate current streak from today backwards - FIXED VERSION
int _calculateCurrentStreak(List<int> sortedDates, int currentDateInt) {
  if (sortedDates.isEmpty) return 0;

  int streak = 0;
  int checkDate = currentDateInt;

  // Start from today and work backwards to find the longest consecutive sequence
  // that includes either today or yesterday (grace period)

  bool foundToday = _containsDate(sortedDates, currentDateInt);
  bool foundYesterday = _containsDate(sortedDates, currentDateInt - 1);

  // If neither today nor yesterday has attendance, streak is broken
  if (!foundToday && !foundYesterday) {
    return 0;
  }

  // Start checking from today if present, otherwise from yesterday
  if (foundToday) {
    checkDate = currentDateInt;
  } else if (foundYesterday) {
    checkDate = currentDateInt - 1;
  }

  // Count consecutive days backwards from the starting point
  while (_containsDate(sortedDates, checkDate)) {
    streak++;
    checkDate--;
  }

  return streak;
}

// Calculate streak ending at specific date - O(log n) + O(streak_length)
int _calculateStreakEndingAt(List<int> sortedDates, int endDate) {
  if (!_containsDate(sortedDates, endDate)) return 0;

  int streak = 1;
  int expectedDate = endDate - 1;

  // Work backwards from the end date to count consecutive days
  while (_containsDate(sortedDates, expectedDate)) {
    streak++;
    expectedDate--;
  }

  return streak;
}

// Calculate longest streak in history - O(n) single pass - FIXED VERSION
int _calculateLongestStreak(List<int> sortedDates) {
  if (sortedDates.isEmpty) return 0;
  if (sortedDates.length == 1) return 1;

  int maxStreak = 1;
  int currentStreak = 1;

  for (int i = 1; i < sortedDates.length; i++) {
    // Check if current date is consecutive to previous date
    if (sortedDates[i] == sortedDates[i - 1] + 1) {
      currentStreak++;
    } else {
      // Streak broken, update max if current is longer
      if (currentStreak > maxStreak) {
        maxStreak = currentStreak;
      }
      currentStreak = 1; // Reset to 1 for the new date
    }
  }

  // Don't forget to check the final streak
  if (currentStreak > maxStreak) {
    maxStreak = currentStreak;
  }

  return maxStreak;
}

// Update user streaks in Firestore
Future<void> _updateStreaks(
  DocumentReference userDocRef,
  List<int> streakDates,
  int currentDateInt,
  int existingLongestStreak,
) async {
  if (streakDates.isEmpty) {
    await userDocRef.update({
      'currentStreak': 0,
      'streakHistory': [], // Empty List<int>
    });
    print(
        '[Streak Log] Updated streaks - Current: 0, Longest: $existingLongestStreak (no dates)');
    return;
  }

  final newCurrentStreak = _calculateCurrentStreak(streakDates, currentDateInt);
  final newLongestStreak = _calculateLongestStreak(streakDates);

  final updates = <String, dynamic>{
    'currentStreak': newCurrentStreak,
    'streakHistory': streakDates, // Store as List<int>
  };

  // Only update longest streak if it actually increased
  if (newLongestStreak > existingLongestStreak) {
    updates['longestStreak'] = newLongestStreak;
  }

  await userDocRef.update(updates);

  final finalLongestStreak = newLongestStreak > existingLongestStreak
      ? newLongestStreak
      : existingLongestStreak;
  print(
      '[Streak Log] Updated streaks - Current: $newCurrentStreak, Longest: $finalLongestStreak');
}
