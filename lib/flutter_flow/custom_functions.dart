import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/auth/firebase_auth/auth_util.dart';

/// Time Formats Are:
/// HH: Hours
/// MM: Minutes
/// SS: Seconds
/// MS: Milliseconds
int elapsedTime(
  DateTime startPoint,
  DateTime endPoint,
  String timeFormat,
) {
  // A Function Which Can Calculate The Time Difference Between The Two Points And Give The value in The requested form That is; HH for Only Hours, MM for minutes, SS for Seconds, MS for milliseconds
  Duration difference = endPoint.difference(startPoint);

  switch (timeFormat) {
    case 'HH':
      return difference.inHours;
    case 'MM':
      return difference.inMinutes;
    case 'SS':
      return difference.inSeconds;
    case 'MS':
      return difference.inMilliseconds;
    default:
      throw ArgumentError('Invalid time format');
  }
}

List<DateTime> datesGenerator(
  DateTime targetDate,
  int days,
  bool? includeSundays,
  bool? includeSaturdays,
) {
  final List<DateTime> result = [];
  int offset = 0;

// Always include the targetDate as the first entry
  result.add(targetDate);
  offset++;

// Continue adding until we reach the desired number of days
  while (result.length < days) {
    final date = targetDate.add(Duration(days: offset));
    final weekday = date.weekday;

    final isSaturday = weekday == DateTime.saturday;
    final isSunday = weekday == DateTime.sunday;

    final shouldInclude = (!isSaturday && !isSunday) ||
        (isSaturday && (includeSaturdays ?? false)) ||
        (isSunday && (includeSundays ?? false));

    if (shouldInclude) {
      result.add(date);
    }

    offset++;
  }

  return result;
}

DateTime addTime(
  DateTime targetDate,
  int time,
  String? type,
) {
// add the time to the given targetTime and use the type to determine the value if the type is MM then add the time in minutes and if its MS then milliseconds and HH for hours and SS for seconds
  switch (type) {
    case 'MM':
      return targetDate.add(Duration(minutes: time));
    case 'MS':
      return targetDate.add(Duration(milliseconds: time));
    case 'HH':
      return targetDate.add(Duration(hours: time));
    case 'SS':
      return targetDate.add(Duration(seconds: time));
    default:
      return targetDate; // Return the original date if type is unrecognized
  }
}

DateTime subtractTime(
  DateTime targetDate,
  int time,
  String? type,
) {
// subtract the time to the given targetTime and use the type to determine the value if the type is MM then subtract the time in minutes and if its MS then milliseconds and HH for hours and SS for seconds
  switch (type) {
    case 'MM':
      return targetDate.subtract(Duration(minutes: time));
    case 'MS':
      return targetDate.subtract(Duration(milliseconds: time));
    case 'HH':
      return targetDate.subtract(Duration(hours: time));
    case 'SS':
      return targetDate.subtract(Duration(seconds: time));
    default:
      return targetDate; // Return the original date if type is unrecognized
  }
}

String generateAttendanceRemarks(
  bool isLab,
  int totalClasses,
  int attendedClasses,
) {
  // Handle lab classes with mandatory attendance
  if (isLab) {
    final labRemarks = [
      "Labs are mandatory and cannot be skipped. Attendance is crucial! 🔬",
      "Skip a lab? That's like skipping leg day, but for your brain. Attendance required! 🧪",
      "Labs aren't optional - they're where the magic happens! No abracadabra without attendance. 🧙‍♂️",
      "Labs and attendance go together like procrastination and regret. Don't miss them! 🔍",
      "Miss a lab, miss a miracle. These sessions are mandatory for a reason! 🧬",
      "Labs: where theory meets reality and attendance meets your grade. Be there! 🔭",
      "Lab attendance isn't just mandatory, it's where all the cool explosions happen. Don't miss out! 💥",
      "The lab is calling and you MUST answer. Attendance is non-negotiable! ☎️",
    ];
    // Return a random remark from the list for variety
    return _getRandomRemark(labRemarks);
  }

  // Handle edge case of zero total classes
  if (totalClasses == 0) {
    return "No classes found. Are you enrolled in a ghost course or just wishful thinking? 👻";
  }

  // Calculate attendance percentage
  final double attendancePercentage = (attendedClasses / totalClasses) * 100;

  // Calculate how many more classes can be skipped while staying above 80%
  final int skippableClasses =
      _calculateSkippableClasses(attendedClasses, totalClasses);

  // Calculate how many more classes need to be attended to reach 80%
  final int moreClassesNeeded =
      _calculateClassesNeeded(attendedClasses, totalClasses);

  // Select appropriate remark based on attendance status
  return _getAttendanceRemark(
      attendancePercentage, skippableClasses, moreClassesNeeded);
}

/// Calculates how many classes can be skipped while maintaining 80% attendance
int _calculateSkippableClasses(int attended, int total) {
  final int skippable = (attended - (0.8 * total)).floor();
  return skippable > 0 ? skippable : 0;
}

/// Calculates how many more classes need to be attended to reach 80% attendance
int _calculateClassesNeeded(int attended, int total) {
  final int needed = ((0.8 * total - attended) / 0.2).ceil();
  return needed > 0 ? needed : 0;
}

/// Returns a random remark from the provided list
String _getRandomRemark(List<String> remarks) {
  remarks.shuffle(); // Randomize order for variety
  return remarks.first;
}

/// Selects appropriate attendance remark based on current status
String _getAttendanceRemark(double percentage, int skippable, int needed) {
  // Perfect attendance remarks (100%)
  final perfectAttendanceRemarks = [
    "Perfect attendance! You can miss $skippable classes and still stay above 80%. What will you do with all this freedom? 😎",
    "100% attendance? You must really love this class! You can skip $skippable classes without ruining your perfect reputation. 🎓",
    "Flawless attendance record! You can afford to miss $skippable classes and still be golden. Maybe take a day for your mental health? 🧠",
    "Perfect attendance! The professor probably knows your face better than your family. Feel free to disappear for $skippable classes. ✨",
    "100% attendance! Either you're incredibly dedicated or you have no social life. Either way, you can skip $skippable classes. 🏆",
    "Perfect attendance! Your chair has a permanent imprint of your behind. You can skip $skippable classes and still be a star. ⭐",
    "100% attendance! The professor thinks you live in the classroom. Take $skippable classes off, go see the sun! 🌞",
    "Perfect attendance! Your dedication is either impressive or concerning. You can skip $skippable classes and still be unstoppable. 🚀",
  ];

  // Perfect attendance but no skips allowed
  final zeroSkippableRemarks = [
    "Perfect attendance, but you're walking a tightrope! Can't skip any classes without dropping below 80%. No pressure! 😅",
    "100% attendance, but one sneeze and you're below 80%. Keep that immune system strong! 🛑",
    "Flawless record, but absolutely no wiggle room. Hope you don't catch the flu! 🎯",
    "Perfect attendance! But the universe is waiting for you to miss just one class. Don't tempt fate! ⚠️",
    "100% attendance! You're like a bomb diffuser - one wrong move and you're below 80%. No pressure! 💣",
    "Perfect attendance! You're on the edge—one skip and you're in the danger zone. Maybe bring vitamins? 🏁",
    "100% attendance but zero flexibility. Your immune system better not betray you now! 💪",
    "Perfect attendance! You're walking the attendance tightrope without a safety net. No classes can be skipped! 🎪",
  ];

  // Above 80% with skips allowed
  final above80Remarks = [
    "Attendance looking good! You can miss $skippable classes and still stay above 80%. Use them wisely, unlike your student loan! 😌",
    "Above 80%! You're allowed to skip $skippable classes without consequences. Perfect for those 'my alarm didn't work' days! 🎈",
    "Solid attendance! You can afford to miss $skippable classes and still be safe. Save them for when Netflix drops a new series! 🛡️",
    "Above 80%! You've got $skippable get-out-of-class-free cards. Use them for emergencies or really good parties! 🛤️",
    "Good attendance! You can skip $skippable classes and still be above 80%. That's $skippable chances to pretend you're sick! 🎭",
    "Above 80%! You're allowed to miss $skippable classes without guilt. That's $skippable opportunities for 'my internet went out'! 😊",
    "Strong attendance! You can skip $skippable classes and still pass. That's $skippable days to contemplate your life choices! 💪",
    "Above 80%! You've got $skippable classes worth of buffer. Use them for mental health or that video game release! 🎮",
  ];

  // Above 80% but no skips allowed
  final above80ZeroSkippableRemarks = [
    "Attendance at exactly 80%! You're walking on the edge of academic disaster. No more skips for you! 🎯",
    "Above 80% by the skin of your teeth! One more absence and you're in the danger zone. Choose wisely! 🛑",
    "Solid 80% attendance! You're like a tightrope walker without a safety net. No more skips allowed! ⚠️",
    "Above 80%! You're so close to the edge, you can see the abyss. No more classes can be missed! 🏁",
    "At exactly 80%! You're one sick day away from academic probation. Maybe invest in hand sanitizer? 🧼",
    "Above 80%, barely! Your attendance is hanging by a thread. No more skips unless you enjoy danger! 🚨",
    "Exactly 80%! You're living dangerously. No more classes can be skipped unless you enjoy paperwork! 📝",
    "Above 80% by a whisker! You're one absence away from trouble. Maybe start taking vitamins? 🍊",
  ];

  // Below 80% remarks
  final below80Remarks = [
    "Attendance slipping! You need to attend $needed more classes to hit 80%. Did you forget you enrolled in this course? 📚",
    "Below 80%! You must attend $needed more classes to get back on track. Your chair is getting lonely! 🪑",
    "Low attendance alert! You need $needed more classes to reach 80%. The professor is starting to forget what you look like! 🚨",
    "Below 80%! You've got to attend $needed more classes to avoid trouble. Did you mistake this for an online course? ⚠️",
    "Attendance critically low! You need $needed more classes to hit 80%. Your tuition is feeling pretty expensive per class right now! 💰",
    "Below 80%! You must attend $needed more classes to stay safe. Your attendance is like your phone battery - always critically low! 🛑",
    "Attendance in danger zone! You need $needed more classes to recover. At this point, the other students think you're a myth! 📈",
    "Below 80%! You need to attend $needed more classes to stay afloat. The only thing lower than your attendance is my expectations! 🌊",
  ];

  // Logic to select the appropriate remark
  if (percentage == 100) {
    return skippable == 0
        ? _getRandomRemark(zeroSkippableRemarks)
        : _getRandomRemark(perfectAttendanceRemarks);
  } else if (percentage >= 80) {
    return skippable == 0
        ? _getRandomRemark(above80ZeroSkippableRemarks)
        : _getRandomRemark(above80Remarks);
  } else {
    return _getRandomRemark(below80Remarks);
  }
}

DateTime generalizeDate(DateTime targetTime) {
  return DateTime(targetTime.year, targetTime.month, targetTime.day, 0, 0);
}

String? relativeTime(DateTime targetDate) {
  // A Code which will give output of what day it is, if its the target date is today then return today,if yesterday then yesterday,tomorrow, day after tomorrow,2 days from now,etc,day before yesterday,3 days ago etc..
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final input = DateTime(targetDate.year, targetDate.month, targetDate.day);
  final difference = input.difference(today).inDays;

  // Handle same day, next day, and previous day
  if (difference == 0) return 'Today';
  if (difference == 1) return 'Tomorrow';
  if (difference == -1) return 'Yesterday';

  // Get the weekday names
  final weekdays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  // Get the month names
  final months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  // For days within the current week
  if (difference > 1 && difference <= 7 - now.weekday) {
    return 'This ${weekdays[targetDate.weekday - 1]}';
  }

  // For days within the next week
  if (difference > 7 - now.weekday && difference <= 14 - now.weekday) {
    return 'Next ${weekdays[targetDate.weekday - 1]}';
  }

  // For days within the previous week
  if (difference < -1 && difference >= -now.weekday) {
    return 'Last ${weekdays[targetDate.weekday - 1]}';
  }

  // For dates within the current month
  if (input.month == today.month && input.year == today.year) {
    // Calculate week number relative to today
    final weekDifference = ((difference) / 7).floor();
    if (weekDifference == 1) {
      return 'In 1 week';
    } else if (weekDifference > 1) {
      return 'In $weekDifference weeks';
    } else if (weekDifference == -1) {
      return '1 week ago';
    } else if (weekDifference < -1) {
      return '${-weekDifference} weeks ago';
    }
    return difference > 0 ? 'Later this month' : 'Earlier this month';
  }

  // For dates in the next month
  if ((input.month == today.month + 1 && input.year == today.year) ||
      (input.month == 1 && today.month == 12 && input.year == today.year + 1)) {
    final monthName = months[input.month - 1];
    final day = input.day;

    // Calculate if it's early, mid, or late in the month
    String periodOfMonth;
    if (day <= 10) {
      periodOfMonth = 'early';
    } else if (day <= 20) {
      periodOfMonth = 'mid';
    } else {
      periodOfMonth = 'late';
    }

    return '$periodOfMonth $monthName';
  }

  // For dates in the month after next
  if ((input.month == today.month + 2 && input.year == today.year) ||
      (input.month == today.month - 10 && input.year == today.year + 1)) {
    final monthName = months[input.month - 1];
    return '$monthName ${input.day}';
  }

  // For dates in the previous month
  if ((input.month == today.month - 1 && input.year == today.year) ||
      (input.month == 12 && today.month == 1 && input.year == today.year - 1)) {
    return 'Last month';
  }

  // For specific ranges within 3 months
  if (difference > 0 && difference <= 90) {
    // For dates exactly around month boundaries
    if (difference >= 28 && difference <= 31) {
      return 'In about a month';
    }
    if (difference >= 59 && difference <= 62) {
      return 'In about 2 months';
    }
    if (difference >= 85 && difference <= 90) {
      return 'In about 3 months';
    }

    // For weeks
    final weeks = (difference / 7).floor();
    if (weeks > 0) {
      return 'In $weeks ${weeks == 1 ? 'week' : 'weeks'}';
    }
  }

  // For dates within 3 months in the past
  if (difference < 0 && difference >= -90) {
    // For dates exactly around month boundaries
    if (difference <= -28 && difference >= -31) {
      return 'About a month ago';
    }
    if (difference <= -59 && difference >= -62) {
      return 'About 2 months ago';
    }
    if (difference <= -85 && difference >= -90) {
      return 'About 3 months ago';
    }

    // For weeks
    final weeks = (-difference / 7).floor();
    if (weeks > 0) {
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    }
  }

  // Fallback to days for any other case
  return difference > 0 ? 'In $difference days' : '${-difference} days ago';
}

List<DateTime>? generateAvailableTimeSlots(
  List<TimetableRecordsRow> supabaseTimetableRows,
  DateTime? selectedDate,
) {
  // Determine the base date based on selectedDate or current date
  final baseDate = selectedDate != null
      ? DateTime(selectedDate.year, selectedDate.month, selectedDate.day)
      : DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  if (supabaseTimetableRows.isEmpty) {
    // Return all time slots from 7:00 AM to 7:00 PM for the base date
    return List.generate(
      13,
      (index) => baseDate.add(Duration(hours: 7 + index)),
    );
  }

  // Generate all possible slots from 7:00 AM to 7:00 PM for the base date
  List<DateTime> availableSlots = [];
  for (int hour = 8; hour <= 18; hour++) {
    availableSlots.add(baseDate.add(Duration(hours: hour)));
  }

  // Remove slots occupied by classes on the base date
  for (var classRecord in supabaseTimetableRows) {
    final classStart = classRecord.classStartTime;
    final classEnd = classRecord.classEndTime;

    if (classStart == null || classEnd == null) continue;

    // Skip classes not on the base date
    if (classStart.year != baseDate.year ||
        classStart.month != baseDate.month ||
        classStart.day != baseDate.day) {
      continue;
    }

    final duration = classEnd.difference(classStart).inMinutes;
    if (duration < 60) continue;

    final slotsToSkip = (duration ~/ 60);
    for (int i = 0; i < slotsToSkip; i++) {
      final hourToRemove = classStart.hour + i;
      availableSlots.removeWhere((slot) => slot.hour == hourToRemove);
    }
  }

  return availableSlots.isEmpty ? null : availableSlots;
}

double overallAttendanceCalculator(
    List<CoursesEnrolledStruct>? coursesEnrolled) {
  // A Function which will fetch the given datatype for attendedClasses and totalClasses and Calculates the Overall Attendance Percentage
  if (coursesEnrolled == null || coursesEnrolled.isEmpty) {
    return 0.0;
  }

  int totalAttended = 0;
  int totalClasses = 0;

  for (var course in coursesEnrolled) {
    totalAttended += course.attendedClasses.toInt();
    totalClasses += course.totalClasses.toInt();
  }

  double percentage =
      totalClasses > 0 ? (totalAttended / totalClasses) * 100 : 0.0;
  return double.parse(percentage.toStringAsFixed(1));
}

List<DateTime> generatePastDates(
  bool includeSundays,
  bool includeSaturdays,
  int? numDays,
  DateTime targetDate,
) {
  // A Code which will generate the past Dates and arrange them as decrersing order as current day at top
  List<DateTime> pastDates = [];
  DateTime today = DateTime.now();

  // Always include current day first, regardless of weekend settings
  if (!today.isBefore(targetDate)) {
    pastDates.add(today);
  }

  // Generate remaining dates
  for (int i = 1; i < (numDays ?? 30); i++) {
    DateTime date = today.subtract(Duration(days: i));
    if (date.isBefore(targetDate)) break;

    if ((includeSundays || date.weekday != DateTime.sunday) &&
        (includeSaturdays || date.weekday != DateTime.saturday)) {
      pastDates.add(date);
    }
  }

  pastDates.sort((a, b) => b.compareTo(a)); // Sort in descending order
  return pastDates;
}

int overallAttendedClasses(List<CoursesEnrolledStruct> coursesEnrolled) {
  // // A Function which will fetch the given datatype for attendedClasses and gives the total as a output int
  int totalAttended = 0;
  for (var course in coursesEnrolled) {
    totalAttended += course.attendedClasses.toInt();
  }
  return totalAttended;
}

int overallTotalClasses(List<CoursesEnrolledStruct> coursesEnrolled) {
  // A Function which will fetch the given dataType for TotalClasses and gives the total as a int
  int totalClasses = 0;
  for (var course in coursesEnrolled) {
    totalClasses += course.totalClasses
        .toInt(); // Assuming totalClasses is a property of CoursesEnrolledStruct
  }
  return totalClasses;
}

String timeProximity(DateTime targetTime) {
  // A Function which will check if the targetTime is future time if yes then give return value as future or if its past then check if its between 1 hour proximity of curren time if yes then give present orelse past
  DateTime now = DateTime.now();
  if (targetTime.isAfter(now)) {
    return 'future';
  } else if (targetTime.isBefore(now) &&
      targetTime.isAfter(now.subtract(Duration(hours: 1)))) {
    return 'present';
  } else {
    return 'past';
  }
}

String? getCourseUpdateMessage(int? step) {
  if (step == null) return 'Sync couldn’t begin — missing step.';

  const List<String> messages = [
    'Fetching your courses...',
    'Loading timetable and slots...',
    'Sorting course info...',
    'Linking faculty and types...',
    'Calculating attendance...',
    'Verifying records...',
    'Syncing updates...',
    'Generating remarks...',
    'Securing your data...',
    'Saving to Firestore...',
    'Refreshing timestamps...',
    'All set — dashboard updated.',
  ];

  if (step >= 0 && step < messages.length) {
    return messages[step];
  }

  return 'Invalid step — sync halted.';
}

String relativeTimeLonger(DateTime targetDate) {
  final now = DateTime.now();
  final diff = targetDate.difference(now);
  final isPast = diff.isNegative;
  final duration = diff.abs();

  String pluralize(int value, String unit) =>
      '$value $unit${value == 1 ? '' : 's'}';

  if (isPast) {
    if (duration.inDays > 0) {
      return '${pluralize(duration.inDays, "day")} ${pluralize(duration.inHours % 24, "hour")} ago';
    } else if (duration.inHours > 0) {
      return '${pluralize(duration.inHours, "hour")} ${pluralize(duration.inMinutes % 60, "minute")} ago';
    } else if (duration.inMinutes > 0) {
      return '${pluralize(duration.inMinutes, "minute")} ${pluralize(duration.inSeconds % 60, "second")} ago';
    } else if (duration.inSeconds > 0) {
      return pluralize(duration.inSeconds, "second") + ' ago';
    } else {
      return 'Just now';
    }
  } else {
    if (duration.inDays > 0) {
      String result = pluralize(duration.inDays, "day");
      if (duration.inHours % 24 > 0) {
        result += ' ' + pluralize(duration.inHours % 24, "hour");
      }
      return result;
    } else if (duration.inHours > 0) {
      String result = pluralize(duration.inHours, "hour");
      if (duration.inMinutes % 60 > 0) {
        result += ' ' + pluralize(duration.inMinutes % 60, "minute");
      }
      return result;
    } else if (duration.inMinutes > 0) {
      String result = pluralize(duration.inMinutes, "minute");
      if (duration.inSeconds % 60 > 0) {
        result += ' ' + pluralize(duration.inSeconds % 60, "second");
      }
      return result;
    } else if (duration.inSeconds > 30) {
      return pluralize(duration.inSeconds, "second");
    } else if (duration.inSeconds > 10) {
      return 'Less than 30 seconds';
    } else if (duration.inSeconds > 0) {
      return 'A few seconds remaining';
    } else {
      return 'Time is up!';
    }
  }
}

int randomNumberGenerator(
  int minNum,
  int maxNum,
  String seed,
) {
  // Simple deterministic hash from string (FlutterFlow compatible)
  int hash = 0;
  for (int i = 0; i < seed.length; i++) {
    hash = 31 * hash + seed.codeUnitAt(i);
    hash &= 0x7FFFFFFF; // Keep it in 32-bit positive range
  }

  final random = math.Random(hash);
  return minNum + random.nextInt(maxNum - minNum + 1);
}

List<String>? breadcrumbGenerator(
  String inputCrumb,
  bool? includeHomeDirectory,
  bool useRoot,
) {
  List<String> parts =
      inputCrumb.split("/").where((part) => part.trim().isNotEmpty).toList();

  final specialDir = useRoot ? 'root' : 'home';

  // Remove specialDir if includeHomeDirectory is false and it is first element
  if (includeHomeDirectory == false &&
      parts.isNotEmpty &&
      (parts.first == 'home' || parts.first == 'root')) {
    parts.removeAt(0);
  }

  // Add specialDir at the start if includeHomeDirectory is true and it's missing
  if (includeHomeDirectory == true &&
      (parts.isEmpty || parts.first != specialDir)) {
    parts.insert(0, specialDir);
  }

  return parts;
}

String breadcrumbParser(
  List<String>? inputStrings,
  String? index,
) {
  // A Function which will convert the list of strings to a path using a / for example there are lsit of input strings such as folderA,folderB,FolderC and the index is 1 then it needs to geneate a string as home/folderA/folderB since the index given is 1 so it needs to stop at index 1
  if (index == null) return 'home';
  int idx = int.tryParse(index) ?? 0;
  return 'home/' + inputStrings!.take(idx + 1).join('/') + '/';
}

String getAssetPathFromMimeType(String mimeType) {
  final mimeMap = {
    'application/pdf': 'assets/icons/PDF_SVG_Vectors_and_Icons.svg',
    'application/msword': 'assets/icons/Doc_Monocolor_SVG.svg',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document':
        'assets/icons/Docx_File_Format_Icon.svg',
    'application/vnd.ms-excel': 'assets/icons/XLS_SVG_Vectors_and_Icons.svg',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet':
        'assets/icons/Xlsx_SVG_Icons.svg',
    'application/vnd.ms-powerpoint':
        'assets/icons/Ppt_SVG_Vectors_and_Icons.svg',
    'application/vnd.openxmlformats-officedocument.presentationml.presentation':
        'assets/icons/PPTX_SVG_Icon.svg',
    'text/plain': 'assets/icons/txt_file_symbol_svgrepo_com.svg',
    'text/csv': 'assets/icons/CSV_File_Format_Icon.svg',
    'image/jpeg': 'assets/icons/Jpeg_SVG_Vectors_and_Icons.svg',
    'image/jpg': 'assets/icons/Jpg_SVG_Vectors_and_Icons.svg',
    'image/png': 'assets/icons/Png_SVG_Vectors_and_Icons.svg',
    'image/gif': 'assets/icons/Gif_SVG_Icons.svg',
    'image/svg+xml': 'assets/icons/SVG_Vectors_and_Icons.svg',
    // fallback/default
    'default': 'assets/icons/File_Icon_from_SVG_Repo.svg',
    // Add more mappings as needed
  };

  return mimeMap[mimeType] ?? 'assets/icons/File Icon from SVG Repo.svg';
}

String byteFormatter(int bytes) {
  // Create a Dart function byteFormatter(int bytes) that returns a human-readable string: auto-convert bytes to kB, MB, GB, or TB based on size, rounded to 2 decimal places. Use "B", "kB", "MB", "GB", or "TB" with a space before the unit. Return "0 B" if 0, "Invalid size" if negative.
  if (bytes < 0) return "Invalid size";
  if (bytes == 0) return "0 B";

  const units = ["B", "kB", "MB", "GB", "TB"];
  int unitIndex = 0;
  double size = bytes.toDouble();

  while (size >= 1024 && unitIndex < units.length - 1) {
    size /= 1024;
    unitIndex++;
  }

  return "${size.toStringAsFixed(2)} ${units[unitIndex]}";
}

List<String> uniqueTagsGenerator(List<UserPersonalVaultRecord> userFiles) {
  final Set<String> uniqueTags = {};

  // Emoji remover
  final emojiRegex = RegExp(
    r'[\u{1F300}-\u{1F6FF}\u{1F900}-\u{1F9FF}\u{2600}-\u{26FF}]',
    unicode: true,
  );

  for (final file in userFiles) {
    final tags = file.tags;
    if (tags == null || tags.isEmpty) continue;

    for (final tag in tags) {
      final cleaned = tag.replaceAll(emojiRegex, '').trim().toLowerCase();
      if (cleaned.isNotEmpty) {
        uniqueTags.add(cleaned);
      }
    }
  }

  final result = uniqueTags.toList();
  result.sort();
  return result;
}

bool isTagSimilar(
  List<UserPersonalVaultRecord> userFiles,
  String newTag,
) {
  final emojiRegex = RegExp(
    r'[\u{1F300}-\u{1F6FF}\u{1F900}-\u{1F9FF}\u{2600}-\u{26FF}]',
    unicode: true,
  );

  // Reuse the existing cleaned and deduplicated tag list
  final existingTags = uniqueTagsGenerator(userFiles);

  // Clean the new tag
  final cleanedNewTag = newTag.replaceAll(emojiRegex, '').trim().toLowerCase();

  for (final tag in existingTags) {
    if (tag == cleanedNewTag) {
      return true;
    }
  }

  return false;
}

List<String> listMerger(
  List<String> list1,
  List<String> list2,
) {
  // Emoji & symbol cleaner regex
  final emojiRegex = RegExp(
    r'[\u{1F300}-\u{1F6FF}\u{1F900}-\u{1F9FF}\u{2600}-\u{26FF}]',
    unicode: true,
  );

  final Map<String, String> cleanedToOriginal = {};

  for (final tag in [...list1, ...list2]) {
    final cleaned = tag.replaceAll(emojiRegex, '').trim().toLowerCase();
    if (cleaned.isNotEmpty && !cleanedToOriginal.containsKey(cleaned)) {
      cleanedToOriginal[cleaned] = tag.trim();
    }
  }

  return cleanedToOriginal.values.toList()..sort();
}

UserLevelMetadataStruct getUserLevel(int currentAmplix) {
  final List<Map<String, dynamic>> levelConfigs = [
    {
      'level': 1,
      'name': 'Novice Mage',
      'min': 0,
      'max': 200,
      'color': '#A0AEC0'
    },
    {
      'level': 2,
      'name': 'Apprentice Mage',
      'min': 201,
      'max': 500,
      'color': '#81E6D9'
    },
    {
      'level': 3,
      'name': 'One-Star Mage',
      'min': 501,
      'max': 1000,
      'color': '#63B3ED'
    },
    {
      'level': 4,
      'name': 'Two-Star Mage',
      'min': 1001,
      'max': 2000,
      'color': '#7F9CF5'
    },
    {
      'level': 5,
      'name': 'Three-Star Mage',
      'min': 2001,
      'max': 3500,
      'color': '#9F7AEA'
    },
    {
      'level': 6,
      'name': 'Four-Star Mage',
      'min': 3501,
      'max': 5500,
      'color': '#ED64A6'
    },
    {
      'level': 7,
      'name': 'Five-Star Mage',
      'min': 5501,
      'max': 8000,
      'color': '#F6AD55'
    },
    {
      'level': 8,
      'name': 'Arcane Mage',
      'min': 8001,
      'max': 10000,
      'color': '#FBD38D'
    },
    {
      'level': 9,
      'name': 'Lunar Mage',
      'min': 10001,
      'max': 13000,
      'color': '#B794F4'
    },
    {
      'level': 10,
      'name': 'Solar Mage',
      'min': 13001,
      'max': 16000,
      'color': '#F6E05E'
    },
    {
      'level': 11,
      'name': 'Starborn Mage',
      'min': 16001,
      'max': 20000,
      'color': '#FBB6CE'
    },
    {
      'level': 12,
      'name': 'Master Mage',
      'min': 20001,
      'max': 999999999,
      'color': '#ECC94B'
    },
  ];

  Map<String, dynamic> currentLevel = levelConfigs.last;

  for (final level in levelConfigs) {
    if (currentAmplix >= level['min'] && currentAmplix <= level['max']) {
      currentLevel = level;
      break;
    }
  }

  final int mageLevel = currentLevel['level'];
  final String mageName = currentLevel['name'];
  final String colorHex = currentLevel['color'];

  int nextMilestone;
  if (mageLevel == 12) {
    nextMilestone = currentAmplix;
  } else {
    nextMilestone = levelConfigs[mageLevel]['min'];
  }

  return UserLevelMetadataStruct(
    mageLevel: mageLevel,
    mageName: mageName,
    currentAmplix: currentAmplix,
    nextAmplixMilestone: nextMilestone,
    currentMageColor: colorHex,
  );
}

String diffCalculator(
  double var1,
  double var2,
) {
  return '${(var1 - var2 >= 0 ? '+' : '')}${((var1 - var2) / (var2 == 0 ? 1 : var2) * 100).toStringAsFixed(2)}%';
}

String generateChallengeKey(bool isWeekly) {
  // Get current time in IST (UTC+5:30)
  final now = DateTime.now().toUtc().add(Duration(hours: 5, minutes: 30));

  if (isWeekly) {
    // Find the most recent Monday at 12:00 AM IST
    final currentWeekday = now.weekday; // Monday = 1, Sunday = 7
    final daysSinceMonday = currentWeekday - 1; // 0 for Monday, 6 for Sunday

    // Calculate the Monday for this week
    final mondayDate = DateTime(now.year, now.month, now.day - daysSinceMonday);

    // Use the Monday's date for the key generation
    final mm = mondayDate.month.toString().padLeft(2, '0');
    final yy = (mondayDate.year % 100).toString().padLeft(2, '0');

    // Calculate which week of the month this Monday falls in
    final weekInMonth = ((mondayDate.day - 1) / 7).ceil() + 1;

    return '$mm$yy-W${weekInMonth}W';
  } else {
    // For monthly: use the first day of current month for key generation
    // If we're in the current month, the key represents this month
    final mm = now.month.toString().padLeft(2, '0');
    final yy = (now.year % 100).toString().padLeft(2, '0');

    return '$mm$yy-M';
  }
}

String? generateClassReminderText(
  bool isTitle,
  String className,
  int minutesBefore,
  String userDisplayName,
) {
  final titles = [
    "Hey $userDisplayName! 👋",
    "$userDisplayName, Time's Up! ⏰",
    "Psst $userDisplayName! 🔔",
    "Yo $userDisplayName! 🚀",
    "$userDisplayName, Let's Go! 💪",
  ];

  final descriptions = [
    "$className starts in $minutesBefore mins - you got this!",
    "Time for $className, $userDisplayName! $minutesBefore mins left",
    "$userDisplayName, $className in $minutesBefore minutes ⚡",
    "Ready $userDisplayName? $className begins in $minutesBefore mins",
    "$className time $userDisplayName! T-minus $minutesBefore minutes 🎯",
    "Heads up $userDisplayName - $className in $minutesBefore mins",
    "$userDisplayName, your $className starts in $minutesBefore minutes!",
    "Game time $userDisplayName! $className in $minutesBefore mins 🔥",
  ];

  final random = math.Random();

  if (isTitle) {
    return titles[random.nextInt(titles.length)];
  } else {
    return descriptions[random.nextInt(descriptions.length)];
  }
}

String generateAmplixMessage(int amplixReward) {
  final random = math.Random();

  // Define message variations for each range
  List<String> messages;

  if (amplixReward <= 150) {
    // Small rewards - casual, encouraging
    messages = [
      '+$amplixReward Amplix added!',
      '+$amplixReward Amplix earned!',
      '+$amplixReward Amplix collected!',
      '+$amplixReward Amplix gathered!',
      '+$amplixReward Amplix acquired!',
      '+$amplixReward Amplix claimed!',
      'Nice! +$amplixReward Amplix!',
      'Sweet! +$amplixReward Amplix gained!',
      '+$amplixReward Amplix in the bag!',
      'You got +$amplixReward Amplix!',
      '+$amplixReward Amplix secured!',
      'Amplix +$amplixReward obtained!',
    ];
  } else if (amplixReward <= 300) {
    // Medium rewards - more excited
    messages = [
      '+$amplixReward Amplix collected!',
      '+$amplixReward Amplix secured!',
      '+$amplixReward Amplix banked!',
      '+$amplixReward Amplix harvested!',
      'Great! +$amplixReward Amplix earned!',
      'Excellent! +$amplixReward Amplix gained!',
      '+$amplixReward Amplix power-up!',
      'Solid +$amplixReward Amplix haul!',
      '+$amplixReward Amplix achievement!',
      'You scored +$amplixReward Amplix!',
      '+$amplixReward Amplix reward claimed!',
      'Impressive +$amplixReward Amplix boost!',
    ];
  } else if (amplixReward <= 500) {
    // Good rewards - enthusiastic
    messages = [
      '+$amplixReward Amplix boost!',
      '+$amplixReward Amplix surge!',
      '+$amplixReward Amplix windfall!',
      '+$amplixReward Amplix jackpot!',
      'Awesome! +$amplixReward Amplix!',
      'Fantastic +$amplixReward Amplix haul!',
      '+$amplixReward Amplix mega-gain!',
      'You crushed it! +$amplixReward Amplix!',
      '+$amplixReward Amplix power surge!',
      'Outstanding +$amplixReward Amplix!',
      '+$amplixReward Amplix bonanza!',
      'Epic +$amplixReward Amplix score!',
    ];
  } else if (amplixReward <= 750) {
    // High rewards - very excited
    messages = [
      '+$amplixReward Amplix secured!',
      '+$amplixReward Amplix dominated!',
      '+$amplixReward Amplix conquered!',
      '+$amplixReward Amplix triumph!',
      'Incredible! +$amplixReward Amplix!',
      'Amazing +$amplixReward Amplix victory!',
      '+$amplixReward Amplix supremacy!',
      'You\'re on fire! +$amplixReward Amplix!',
      '+$amplixReward Amplix excellence!',
      'Phenomenal +$amplixReward Amplix!',
      '+$amplixReward Amplix breakthrough!',
      'Legendary +$amplixReward Amplix gain!',
    ];
  } else if (amplixReward <= 1000) {
    // Very high rewards - maximum excitement
    messages = [
      '+$amplixReward Amplix mastered!',
      '+$amplixReward Amplix perfection!',
      '+$amplixReward Amplix domination!',
      '+$amplixReward Amplix supremacy!',
      'INCREDIBLE! +$amplixReward Amplix!',
      'LEGENDARY +$amplixReward Amplix!',
      '+$amplixReward Amplix CHAMPION!',
      'UNSTOPPABLE! +$amplixReward Amplix!',
      '+$amplixReward Amplix GODLIKE!',
      'PHENOMENAL +$amplixReward Amplix!',
      '+$amplixReward Amplix MASTERY!',
      'You\'re CRUSHING it! +$amplixReward Amplix!',
    ];
  } else {
    // Ultra high rewards - over the top
    messages = [
      '+$amplixReward Amplix LEGENDARY!',
      '+$amplixReward Amplix ULTIMATE!',
      '+$amplixReward Amplix TRANSCENDENT!',
      '+$amplixReward Amplix GODMODE!',
      'UNBELIEVABLE! +$amplixReward Amplix!',
      'WORLD-CLASS +$amplixReward Amplix!',
      '+$amplixReward Amplix INFINITY!',
      'MIND-BLOWING +$amplixReward Amplix!',
      '+$amplixReward Amplix UNIVERSE!',
      'ABSOLUTELY INSANE! +$amplixReward Amplix!',
      '+$amplixReward Amplix BEYOND LIMITS!',
      'REALITY-BREAKING +$amplixReward Amplix!',
    ];
  }

  // Return a random message from the appropriate range
  return messages[random.nextInt(messages.length)];
}

// Enhanced version with context-aware messaging
String generateContextualAmplixMessage(
  int amplixReward, {
  String? context,
  bool isStreak = false,
  bool isBonus = false,
  bool isCritical = false,
}) {
  final random = math.Random();
  String baseMessage = generateAmplixMessage(amplixReward);

  // Add context modifiers
  List<String> modifiers = [];

  if (isStreak) {
    modifiers.addAll([
      'Streak bonus!',
      'Chain reaction!',
      'Combo power!',
      'Streak multiplier!'
    ]);
  }

  if (isBonus) {
    modifiers.addAll([
      'Bonus round!',
      'Special reward!',
      'Extra credit!',
      'Surprise bonus!'
    ]);
  }

  if (isCritical) {
    modifiers.addAll(
        ['CRITICAL HIT!', 'PERFECT STRIKE!', 'BULLS-EYE!', 'FLAWLESS!']);
  }

  if (context != null) {
    switch (context.toLowerCase()) {
      case 'quest':
        modifiers.addAll(
            ['Quest complete!', 'Mission accomplished!', 'Objective cleared!']);
        break;
      case 'battle':
        modifiers
            .addAll(['Victory achieved!', 'Enemy defeated!', 'Battle won!']);
        break;
      case 'discovery':
        modifiers
            .addAll(['Discovery made!', 'Secret found!', 'Hidden treasure!']);
        break;
    }
  }

  // Combine base message with random modifier
  if (modifiers.isNotEmpty && random.nextBool()) {
    String modifier = modifiers[random.nextInt(modifiers.length)];
    return '$modifier $baseMessage';
  }

  return baseMessage;
}

DateTime getNextResetDate(bool weekly) {
  final now = DateTime.now();

  if (weekly) {
    return _getNextMonday(now);
  } else {
    return _getFirstOfNextMonth(now);
  }
}

DateTime _getNextMonday(DateTime date) {
  // If today is Monday, return next Monday (7 days from now)
  // Otherwise, calculate days until next Monday
  final daysUntilMonday = date.weekday == DateTime.monday
      ? 7
      : (DateTime.monday - date.weekday + 7) % 7;

  final nextMonday = date.add(Duration(days: daysUntilMonday));

  // Return date at midnight (start of day)
  return DateTime(nextMonday.year, nextMonday.month, nextMonday.day);
}

DateTime _getFirstOfNextMonth(DateTime date) {
  // Handle year rollover more elegantly
  final nextMonth = date.month == 12 ? 1 : date.month + 1;
  final nextYear = date.month == 12 ? date.year + 1 : date.year;

  return DateTime(nextYear, nextMonth, 1);
}

// Alternative: More flexible version with customizable reset day
DateTime getNextResetDateAdvanced({
  required bool weekly,
  int weeklyResetDay = DateTime.monday,
  int monthlyResetDay = 1,
}) {
  final now = DateTime.now();

  if (weekly) {
    return _getNextWeekday(now, weeklyResetDay);
  } else {
    return _getNextMonthlyReset(now, monthlyResetDay);
  }
}

DateTime _getNextWeekday(DateTime date, int targetWeekday) {
  assert(targetWeekday >= 1 && targetWeekday <= 7, 'Weekday must be 1-7');

  final daysUntilTarget = date.weekday == targetWeekday
      ? 7
      : (targetWeekday - date.weekday + 7) % 7;

  final targetDate = date.add(Duration(days: daysUntilTarget));
  return DateTime(targetDate.year, targetDate.month, targetDate.day);
}

DateTime _getNextMonthlyReset(DateTime date, int resetDay) {
  assert(resetDay >= 1 && resetDay <= 31, 'Reset day must be 1-31');

  // Try current month first
  var nextReset = DateTime(date.year, date.month, resetDay);

  // If the reset day hasn't passed this month, use it
  if (nextReset.isAfter(date)) {
    return nextReset;
  }

  // Otherwise, go to next month
  final nextMonth = date.month == 12 ? 1 : date.month + 1;
  final nextYear = date.month == 12 ? date.year + 1 : date.year;

  // Handle months with fewer days (e.g., Feb 31 -> Feb 28/29)
  try {
    return DateTime(nextYear, nextMonth, resetDay);
  } catch (e) {
    // If invalid date (e.g., Feb 31), use last day of month
    final lastDayOfMonth = DateTime(nextYear, nextMonth + 1, 0).day;
    return DateTime(nextYear, nextMonth, lastDayOfMonth);
  }
}

List<String> filterAlreadyEnrolledSlots(
  List<SlotInfoStruct> instituteSlots,
  List<String> userEnrolledCourseIDs,
) {
  final enrolledSlots = userEnrolledCourseIDs
      .map((courseID) => courseID.substring(courseID.length - 2))
      .toSet();

  return instituteSlots
      .where((slot) => !enrolledSlots.contains(slot.slotName))
      .map((slot) => slot.slotName)
      .toList();
}

bool checkForSlotConflicts(
  List<String> userEnrolledCourseIDs,
  String weekday,
  DateTime classStartTime,
  List<SlotInfoStruct> instituteSlots,
  DateTime? classEndTime,
) {
  // Extract enrolled slot codes
  final enrolledSlots = userEnrolledCourseIDs
      .map((courseID) => courseID.substring(courseID.length - 2))
      .toSet();

  // Normalize input class times
  final normalizedStart =
      DateTime(2000, 1, 1, classStartTime.hour, classStartTime.minute);

  for (final slot in instituteSlots) {
    if (!enrolledSlots.contains(slot.slotName)) continue;

    for (final meta in slot.slotMetadata) {
      if (meta.weekday.toLowerCase() != weekday.toLowerCase()) continue;

      // Parse timestamp strings to DateTime objects
      DateTime? slotStartTime;
      DateTime? slotEndTime;

      try {
        if (meta.startTime != null) {
          slotStartTime = DateTime.parse(meta.startTime!);
        }
        if (meta.endTime != null) {
          slotEndTime = DateTime.parse(meta.endTime!);
        }
      } catch (e) {
        // Skip this slot if timestamp parsing fails
        continue;
      }

      if (slotStartTime == null || slotEndTime == null) continue;

      // Normalize slot times to same date for comparison
      final slotStart =
          DateTime(2000, 1, 1, slotStartTime.hour, slotStartTime.minute);
      final slotEnd =
          DateTime(2000, 1, 1, slotEndTime.hour, slotEndTime.minute);

      if (classEndTime == null) {
        // Check if classStartTime equals slot start time OR is between slot start and end
        if (normalizedStart.isAtSameMomentAs(slotStart) ||
            (normalizedStart.isAfter(slotStart) &&
                normalizedStart.isBefore(slotEnd))) {
          return true; // Conflict found
        }
      } else {
        // Check if time ranges overlap
        final normalizedEnd =
            DateTime(2000, 1, 1, classEndTime.hour, classEndTime.minute);
        if (normalizedStart.isBefore(slotEnd) &&
            normalizedEnd.isAfter(slotStart)) {
          return true; // Conflict found
        }
      }
    }
  }
  return false; // No conflict
}

String dateTimeParser(
  String inputString,
  String? requiredFormat,
) {
  try {
    // Handle null or empty input
    if (inputString.trim().isEmpty) {
      return 'Invalid input';
    }

    // Default format if none provided
    String outputFormat = requiredFormat ?? 'hh:mm a';

    DateTime parsedDateTime;
    String cleanInput = inputString.trim();

    // Try to parse as timestamp first
    int? timestamp = int.tryParse(cleanInput);
    if (timestamp != null) {
      // Handle both seconds and milliseconds timestamps
      if (timestamp > 1000000000000) {
        // Milliseconds timestamp
        parsedDateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      } else {
        // Seconds timestamp
        parsedDateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      }
    } else {
      // Parse as date/time string using common formats
      parsedDateTime = _parseStringDateTime(cleanInput);
    }

    // Format the output
    DateFormat formatter = DateFormat(outputFormat);
    return formatter.format(parsedDateTime);
  } catch (e) {
    return 'Parse error: ${e.toString()}';
  }
}

/// Helper function to parse various string date/time formats
DateTime _parseStringDateTime(String input) {
  // List of common formats to try in order of likelihood
  List<String> formats = [
    // Firestore/ISO formats
    'yyyy-MM-ddTHH:mm:ss.SSSZ',
    'yyyy-MM-ddTHH:mm:ssZ',
    'yyyy-MM-ddTHH:mm:ss.SSS',
    'yyyy-MM-ddTHH:mm:ss',

    // Standard formats
    'yyyy-MM-dd HH:mm:ss.SSS',
    'yyyy-MM-dd HH:mm:ss',
    'yyyy-MM-dd',

    // US formats
    'MM/dd/yyyy HH:mm:ss',
    'MM/dd/yyyy hh:mm:ss a',
    'MM/dd/yyyy',
    'M/d/yyyy HH:mm:ss',
    'M/d/yyyy hh:mm:ss a',
    'M/d/yyyy',

    // European formats
    'dd/MM/yyyy HH:mm:ss',
    'dd/MM/yyyy',
    'd/M/yyyy HH:mm:ss',
    'd/M/yyyy',
    'dd-MM-yyyy HH:mm:ss',
    'dd-MM-yyyy',
    'd-M-yyyy',

    // Time only formats
    'HH:mm:ss.SSS',
    'HH:mm:ss',
    'HH:mm',
    'hh:mm:ss a',
    'hh:mm a',
    'h:mm:ss a',
    'h:mm a',

    // Readable formats
    'MMM dd, yyyy HH:mm:ss',
    'MMM dd, yyyy hh:mm:ss a',
    'MMM dd, yyyy',
    'dd MMM yyyy HH:mm:ss',
    'dd MMM yyyy',
    'MMMM dd, yyyy',
    'EEEE, MMMM dd, yyyy',

    // Alternative formats
    'yyyy/MM/dd HH:mm:ss',
    'yyyy/MM/dd',
    'dd.MM.yyyy HH:mm:ss',
    'dd.MM.yyyy',
    'yyyy.MM.dd HH:mm:ss',
    'yyyy.MM.dd',
  ];

  // Try each format
  for (String format in formats) {
    try {
      DateFormat formatter = DateFormat(format);
      return formatter.parse(input);
    } catch (e) {
      // Continue to next format
      continue;
    }
  }

  // Last resort: try DateTime.parse() for ISO strings
  try {
    return DateTime.parse(input);
  } catch (e) {
    // If all else fails, try to extract timestamp from string
    RegExp timestampRegex = RegExp(r'\d{10,13}');
    Match? match = timestampRegex.firstMatch(input);
    if (match != null) {
      int timestamp = int.parse(match.group(0)!);
      if (timestamp > 1000000000000) {
        return DateTime.fromMillisecondsSinceEpoch(timestamp);
      } else {
        return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      }
    }

    throw FormatException('Unable to parse date/time string: $input');
  }
}

DateTime convertToDateTime(String inputString) {
  // A Function which will convert various string formats to DateTime variable including UNIX timestamp,TIMESTAMP,Etc

  if (inputString.isEmpty) {
    return DateTime.now();
  }

  try {
    // Remove any leading/trailing whitespace
    String cleanInput = inputString.trim();

    // Check if the input string is a UNIX timestamp (seconds)
    if (RegExp(r'^\d{10}$').hasMatch(cleanInput)) {
      int unixSeconds = int.parse(cleanInput);
      return DateTime.fromMillisecondsSinceEpoch(unixSeconds * 1000);
    }

    // Check if the input string is a UNIX timestamp in milliseconds
    if (RegExp(r'^\d{13}$').hasMatch(cleanInput)) {
      int unixMilliseconds = int.parse(cleanInput);
      return DateTime.fromMillisecondsSinceEpoch(unixMilliseconds);
    }

    // Check if the input string is a UNIX timestamp in microseconds
    if (RegExp(r'^\d{16}$').hasMatch(cleanInput)) {
      int unixMicroseconds = int.parse(cleanInput);
      return DateTime.fromMicrosecondsSinceEpoch(unixMicroseconds);
    }

    // Try to parse as ISO 8601 format first (most common)
    try {
      return DateTime.parse(cleanInput);
    } catch (e) {
      // Continue to other formats if ISO parsing fails
    }

    // Common date formats to try
    List<String> dateFormats = [
      'yyyy-MM-dd HH:mm:ss',
      'yyyy-MM-dd HH:mm:ss.SSS',
      'yyyy-MM-dd',
      'MM/dd/yyyy',
      'MM/dd/yyyy HH:mm:ss',
      'dd/MM/yyyy',
      'dd/MM/yyyy HH:mm:ss',
      'MM-dd-yyyy',
      'MM-dd-yyyy HH:mm:ss',
      'dd-MM-yyyy',
      'dd-MM-yyyy HH:mm:ss',
      'yyyy/MM/dd',
      'yyyy/MM/dd HH:mm:ss',
      'MMM dd, yyyy',
      'MMM dd, yyyy HH:mm:ss',
      'MMMM dd, yyyy',
      'MMMM dd, yyyy HH:mm:ss',
      'EEE, MMM dd, yyyy',
      'EEE, MMM dd, yyyy HH:mm:ss',
    ];

    // Try each format
    for (String format in dateFormats) {
      try {
        DateFormat dateFormat = DateFormat(format);
        return dateFormat.parse(cleanInput);
      } catch (e) {
        // Continue to next format
        continue;
      }
    }

    // Handle special cases with different separators
    // Replace common separators and try again
    String normalizedInput = cleanInput
        .replaceAll('.', '/')
        .replaceAll(' at ', ' ')
        .replaceAll('T', ' ')
        .replaceAll('Z', '');

    if (normalizedInput != cleanInput) {
      for (String format in dateFormats) {
        try {
          DateFormat dateFormat = DateFormat(format);
          return dateFormat.parse(normalizedInput);
        } catch (e) {
          continue;
        }
      }
    }

    // Try parsing relative time formats like "2 hours ago", "yesterday", etc.
    // This would require additional logic based on your specific requirements

    // If all parsing attempts fail, return current date
    return DateTime.now();
  } catch (e) {
    // Return current date if any unexpected error occurs
    return DateTime.now();
  }
}

DateTime parseDateTime(
  DateTime targetDate,
  DateTime targetTime,
) {
  // A Function which will make a new DateTime with the Date From targetDate and time from the TargetTime output it
  return DateTime(
    targetDate.year,
    targetDate.month,
    targetDate.day,
    targetTime.hour,
    targetTime.minute,
    targetTime.second,
    targetTime.millisecond,
    targetTime.microsecond,
  );
}
