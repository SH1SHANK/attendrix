// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';

class CountdownTimerWidget extends StatefulWidget {
  const CountdownTimerWidget({
    super.key,
    this.width,
    this.height,
    required this.isWeekly,
    required this.textColor,
    required this.includeDays,
    this.targetTime,
  });

  final double? width;
  final double? height;
  final bool isWeekly;
  final Color textColor;
  final bool includeDays;
  final DateTime? targetTime;

  @override
  State<CountdownTimerWidget> createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  Timer? _timer;
  Duration _timeRemaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateCountdown();
    _startTimer();
  }

  @override
  void didUpdateWidget(CountdownTimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.targetTime != widget.targetTime ||
        oldWidget.isWeekly != widget.isWeekly) {
      _updateCountdown();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) _updateCountdown();
    });
  }

  void _updateCountdown() {
    final target = widget.targetTime ?? _getNextResetDate();
    final difference = target.difference(DateTime.now());

    setState(() {
      _timeRemaining = difference.isNegative ? Duration.zero : difference;
    });

    if (_timeRemaining.inSeconds <= 0) {
      Future.delayed(const Duration(seconds: 1), _updateCountdown);
    }
  }

  DateTime _getNextResetDate() {
    final now = DateTime.now();

    if (widget.isWeekly) {
      final daysUntilMonday = now.weekday == DateTime.monday
          ? 7
          : (DateTime.monday - now.weekday + 7) % 7;
      final nextMonday = now.add(Duration(days: daysUntilMonday));
      return DateTime(nextMonday.year, nextMonday.month, nextMonday.day);
    } else {
      final nextMonth = now.month == 12 ? 1 : now.month + 1;
      final nextYear = now.month == 12 ? now.year + 1 : now.year;
      return DateTime(nextYear, nextMonth, 1);
    }
  }

  String _formatTime() {
    if (_timeRemaining.inSeconds <= 0) return "00:00";

    final days = _timeRemaining.inDays;
    final hours = _timeRemaining.inHours % 24;
    final minutes = _timeRemaining.inMinutes % 60;
    final seconds = _timeRemaining.inSeconds % 60;

    if (days > 0 && widget.includeDays) {
      return "${days}d ${hours}h";
    } else if (hours > 0) {
      return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    } else {
      return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final containerWidth = widget.width ?? 200;
    final containerHeight = widget.height ?? 40;
    final timeString = _formatTime();
    final isExpired = _timeRemaining.inSeconds <= 0;

    // Responsive sizing
    final baseFontSize = (containerWidth * 0.08).clamp(14.0, 20.0);
    final labelFontSize = (containerWidth * 0.06).clamp(12.0, 16.0);
    final iconSize = (containerWidth * 0.08).clamp(16.0, 22.0);

    return Container(
      width: containerWidth,
      height: containerHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Clock icon
          Icon(
            isExpired ? Icons.refresh_rounded : Icons.access_time_rounded,
            color: widget.textColor,
            size: iconSize,
          ),

          SizedBox(width: 8),

          // "Resets in" label
          Text(
            isExpired ? "Resetting" : "Resets in",
            style: TextStyle(
              fontSize: labelFontSize,
              fontWeight: FontWeight.w500,
              color: widget.textColor.withOpacity(0.8),
            ),
          ),

          SizedBox(width: 8),

          // Timer display
          Text(
            timeString,
            style: TextStyle(
              fontSize: baseFontSize,
              fontWeight: FontWeight.w700,
              color: widget.textColor,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),

          SizedBox(width: 8),

          // Reset type badge
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.isWeekly
                    ? Icons.calendar_view_week
                    : Icons.calendar_month,
                size: labelFontSize,
                color: widget.textColor.withOpacity(0.7),
              ),
              SizedBox(width: 4),
              Text(
                widget.isWeekly ? "Weekly" : "Monthly",
                style: TextStyle(
                  fontSize: labelFontSize,
                  fontWeight: FontWeight.w600,
                  color: widget.textColor.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
