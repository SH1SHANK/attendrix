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

Future<List<ClassRowStruct>> getMissedClasses(
  String userID,
  List<String> enrolledCourseIDs,
) async {
  try {
    debugPrint('Attendrix: Fetching missed classes for user: $userID');

    final now = DateTime.now();
    final startDate = now.subtract(Duration(days: 365));

    final response = await SupaFlow.client.rpc(
      'get_missed_classes_by_date_range',
      params: {
        'p_user_id': userID,
        'p_enrolled_courses': enrolledCourseIDs,
        'p_start_date': startDate.toIso8601String().split('T')[0],
        'p_end_date': now.toIso8601String().split('T')[0],
      },
    );

    if (response != null) {
      final responseData = Map<String, dynamic>.from(response);
      final missedClasses =
          responseData['missed_classes'] as List<dynamic>? ?? [];

      debugPrint('Attendrix: Found ${missedClasses.length} missed classes');

      return missedClasses.map((classData) {
        final data = Map<String, dynamic>.from(classData);

        String _dateTimeToUnixString(dynamic dateValue) {
          if (dateValue == null) {
            return DateTime.now().millisecondsSinceEpoch.toString();
          }

          if (dateValue is String) {
            try {
              // If already a UNIX timestamp
              if (RegExp(r'^\d+$').hasMatch(dateValue)) {
                return dateValue;
              }
              // Parse ISO date and convert to UNIX timestamp
              final dateTime = DateTime.parse(dateValue);
              return dateTime.millisecondsSinceEpoch.toString();
            } catch (e) {
              debugPrint('Attendrix: Error parsing date: $dateValue');
              return DateTime.now().millisecondsSinceEpoch.toString();
            }
          }

          if (dateValue is DateTime) {
            return dateValue.millisecondsSinceEpoch.toString();
          }

          if (dateValue is int) {
            return dateValue.toString();
          }

          return DateTime.now().millisecondsSinceEpoch.toString();
        }

        return ClassRowStruct(
          classID: data['classID'] as String? ?? '',
          courseID: data['courseID'] as String? ?? '',
          courseName: data['courseName'] as String? ?? '',
          classStartTime: _dateTimeToUnixString(data['classStartTime']),
          classEndTime: _dateTimeToUnixString(data['classEndTime']),
          isCustomClass: data['isCustomClass'] as bool? ?? false,
        );
      }).toList();
    }

    return [];
  } catch (e) {
    debugPrint('Attendrix: Error in getMissedClasses: $e');
    return [];
  }
}
