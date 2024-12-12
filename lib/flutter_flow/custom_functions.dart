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
import '/backend/schema/enums/enums.dart';
import '/auth/firebase_auth/auth_util.dart';

String? calculateTimeRemaining(String? targetTime) {
  // A Function to calculate the time difference between the given time and the current time
  if (targetTime == null) {
    return null;
  }

  DateTime target = DateTime.parse(targetTime);
  DateTime now = DateTime.now();

  Duration difference = target.difference(now);

  if (difference.isNegative) {
    return 'Time has passed';
  }

  String formattedTime = '';

  if (difference.inDays > 0) {
    formattedTime += '${difference.inDays} days ';
  }

  if (difference.inHours.remainder(24) > 0) {
    formattedTime += '${difference.inHours.remainder(24)} hours ';
  }

  if (difference.inMinutes.remainder(60) > 0) {
    formattedTime += '${difference.inMinutes.remainder(60)} minutes ';
  }

  return formattedTime;
}

int? attendancePercentage(
  int? totalClasses,
  int? attendedClasses,
) {
  // calculate the attendance percentage and the valuse should be in between 0 and 1
  if (totalClasses == null || attendedClasses == null || totalClasses == 0) {
    return 0;
  }

  double percentage = attendedClasses / totalClasses * 100;
  return percentage.toInt();
}

double attendance(
  int? totalClasses,
  int? attendedClasses,
) {
  // Ratio of attended classes to totl classes
  if (totalClasses == null || attendedClasses == null || totalClasses == 0) {
    return 0.0;
  }

  return attendedClasses / totalClasses;
}

String numberofMaxMissableClasses(
  int? classesAttended,
  int? totalClasses,
) {
  // maxMissableClasses = totalClasses*0.2  classesMissed = totalClasses - classesAttended  freePasses = maxMissableClasses - classesMissed Return- If freePasses is less than 0 then return string of text clour as a red gradient as “No More Free Passes!” Otherwise, return a string as FreePasses: ‘value of freePasses’ in a green gradient as text colour
  if (classesAttended == null || totalClasses == null || totalClasses == 0) {
    return '';
  }

  int maxMissableClasses = (totalClasses * 0.2).toInt();
  int classesMissed = totalClasses - classesAttended;
  int freePasses = maxMissableClasses - classesMissed;

  if (freePasses < 0) {
    return 'No More Free Passes!';
  } else {
    return 'FreePasses: $freePasses';
  }
}

List<DateTime> generateSurroundingDays(DateTime? selectedDay) {
  // give a list of all the dates after the selected date
  List<DateTime> surroundingDays = [];

  if (selectedDay != null) {
    for (int i = 1; i <= 10; i++) {
      DateTime newDay = selectedDay.add(Duration(days: i));
      surroundingDays.add(newDay);
    }
  }

  return surroundingDays;
}
