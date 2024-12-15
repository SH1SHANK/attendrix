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

String? calculateTimeRemaining(DateTime? targetTime) {
  // give the time remaning until the target time also make sure its efficient and will not run into infinite write loop and if the time is over 1 day it should show only days and if its under 1 day it should in hours and if under 1 hour it should show in minutes and if the class is in 10 Minutes then have a list of words like hurry up or about to begin and randomly show any one of them
  if (targetTime == null) {
    return null;
  }

  DateTime currentTime = DateTime.now();
  Duration difference = targetTime.difference(currentTime);

  if (difference.inDays > 0) {
    return '${difference.inDays} days';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} hours';
  } else if (difference.inMinutes > 10) {
    return '${difference.inMinutes} minutes';
  } else {
    List<String> messages = ['Hurry up!', 'About to begin!'];
    int randomIndex = math.Random().nextInt(messages.length);
    return messages[randomIndex];
  }
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
    for (int i = 1; i <= 4; i++) {
      DateTime newDay = selectedDay.add(Duration(days: i));
      surroundingDays.add(newDay);
    }
  }

  return surroundingDays;
}

bool? isLastestAnnounement(AnnouncementsRecord? announements) {
  // A Function which returns true if the announement is created in the last 24 hours or else if there are non then returns false
  if (announements == null || !announements.hasCreatedTime()) {
    return false;
  }

  DateTime currentTime = DateTime.now();
  DateTime createdTime = announements.createdTime!;

  Duration difference = currentTime.difference(createdTime);

  return difference.inHours < 24;
}
