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

import '/custom_code/widgets/index.dart';
import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class StreakCalendarWidget extends StatefulWidget {
  const StreakCalendarWidget({
    super.key,
    this.width,
    this.height,
    required this.streakHistory,
    required this.holidays,
  });

  final double? width;
  final double? height;
  final List<int> streakHistory;
  final List<int> holidays;

  @override
  State<StreakCalendarWidget> createState() => _StreakCalendarWidgetState();
}

class _StreakCalendarWidgetState extends State<StreakCalendarWidget>
    with TickerProviderStateMixin {
  DateTime _currentDate = DateTime.now();
  DateTime _visibleMonth = DateTime.now();
  List<DateTime> _calendarDays = [];

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _isAnimating = false;
  int _slideDirection = 0; // -1 for left, 1 for right

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _generateCalendarDays();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    // Start initial fade animation
    _fadeController.forward();
  }

  void _generateCalendarDays() {
    _calendarDays.clear();
    final firstDay = DateTime(_visibleMonth.year, _visibleMonth.month, 1);
    final firstWeekday = firstDay.weekday - 1; // Monday = 0
    final startDate = firstDay.subtract(Duration(days: firstWeekday));

    for (int i = 0; i < 42; i++) {
      _calendarDays.add(startDate.add(Duration(days: i)));
    }
  }

  DateTime _unixDaysToDateTime(int days) {
    return DateTime(1970, 1, 1).add(Duration(days: days));
  }

  bool _isDateInList(DateTime date, List<int> unixDaysList) {
    final daysSinceEpoch = date.difference(DateTime(1970, 1, 1)).inDays;
    return unixDaysList.contains(daysSinceEpoch);
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool _isCurrentMonth(DateTime date) {
    return date.year == _visibleMonth.year && date.month == _visibleMonth.month;
  }

  int _calculateStreakCount() {
    if (widget.streakHistory.isEmpty) return 0;

    final monthStart = DateTime(_visibleMonth.year, _visibleMonth.month, 1);
    final monthEnd = DateTime(_visibleMonth.year, _visibleMonth.month + 1, 0);

    return widget.streakHistory
        .map(_unixDaysToDateTime)
        .where((date) =>
            date.isAfter(monthStart.subtract(const Duration(days: 1))) &&
            date.isBefore(monthEnd.add(const Duration(days: 1))))
        .length;
  }

  Future<void> _navigateMonth(int direction) async {
    if (_isAnimating) return;

    setState(() {
      _isAnimating = true;
      _slideDirection = direction;
    });

    try {
      HapticFeedback.lightImpact();
    } catch (e) {
      // Haptic feedback not available
    }

    // Update slide animation
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(direction * -0.3, 0.0),
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    // Slide out current month
    await _slideController.forward();

    // Update month and regenerate calendar
    setState(() {
      _visibleMonth =
          DateTime(_visibleMonth.year, _visibleMonth.month + direction, 1);
      _generateCalendarDays();
    });

    // Reset slide animation for slide in
    _slideAnimation = Tween<Offset>(
      begin: Offset(direction * 0.3, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    // Reset and slide in new month
    _slideController.reset();
    await _slideController.forward();

    setState(() {
      _isAnimating = false;
    });
  }

  Widget _buildHeader() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _isAnimating ? null : () => _navigateMonth(-1),
            icon: Icon(
              Icons.chevron_left,
              size: 28,
              color: isDark
                  ? FlutterFlowTheme.of(context).primaryText
                  : Colors.black87,
            ),
            padding: const EdgeInsets.all(8),
          ),
          Expanded(
            child: Text(
              '${_monthNames[_visibleMonth.month - 1]} ${_visibleMonth.year}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: isDark
                    ? FlutterFlowTheme.of(context).primaryText
                    : Colors.black87,
              ),
            ),
          ),
          IconButton(
            onPressed: _isAnimating ? null : () => _navigateMonth(1),
            icon: Icon(
              Icons.chevron_right,
              size: 28,
              color: isDark
                  ? FlutterFlowTheme.of(context).primaryText
                  : Colors.black87,
            ),
            padding: const EdgeInsets.all(8),
          ),
        ],
      ),
    );
  }

  Widget _buildDayLabels() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: _dayLabels.asMap().entries.map((entry) {
          final index = entry.key;
          final day = entry.value;
          final isWeekend = index >= 5;

          return Expanded(
            child: Center(
              child: Text(
                day,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: isWeekend
                      ? (isDark
                          ? FlutterFlowTheme.of(context).primary
                          : _streakColor)
                      : (isDark
                          ? FlutterFlowTheme.of(context).secondaryText
                          : Colors.grey.shade600),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCalendarTile(DateTime date, int index) {
    final isToday = _isSameDay(date, _currentDate);
    final isHoliday = _isDateInList(date, widget.holidays);
    final isStreak = _isDateInList(date, widget.streakHistory);
    final isWeekend = date.weekday >= 6;
    final isCurrentMonth = _isCurrentMonth(date);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color backgroundColor;
    Color textColor =
        isDark ? FlutterFlowTheme.of(context).primaryText : Colors.black87;

    if (!isCurrentMonth) {
      textColor = textColor.withOpacity(0.3);
    }

    if (isHoliday) {
      backgroundColor = _holidayColor;
      textColor = Colors.white;
    } else if (isStreak) {
      backgroundColor = _streakColor;
      textColor = Colors.white;
    } else if (isWeekend) {
      backgroundColor =
          isDark ? FlutterFlowTheme.of(context).alternate : _weekendColor;
    } else {
      backgroundColor = isDark
          ? FlutterFlowTheme.of(context).secondaryBackground
          : Colors.white;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: isToday
            ? Border.all(
                color: isDark
                    ? FlutterFlowTheme.of(context).primary
                    : _streakColor,
                width: 2.0,
              )
            : null,
        boxShadow: (isToday || isStreak || isHoliday)
            ? [
                BoxShadow(
                  color: backgroundColor.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            // Optional: Add tap functionality
            HapticFeedback.selectionClick();
          },
          child: Container(
            alignment: Alignment.center,
            child: Text(
              date.day.toString(),
              style: TextStyle(
                color: textColor,
                fontWeight: isToday ? FontWeight.bold : FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStreakStats() {
    final streakCount = _calculateStreakCount();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _streakColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _streakColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.local_fire_department,
            size: 20,
            color: _streakColor,
          ),
          const SizedBox(width: 8),
          Text(
            'Streak this month: $streakCount',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _streakColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final containerWidth = widget.width ?? math.min(screenWidth - 32, 400.0);
    final containerHeight =
        widget.height ?? math.min(screenHeight * 0.6, 500.0);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        width: containerWidth,
        height: containerHeight,
        decoration: BoxDecoration(
          color: isDark
              ? FlutterFlowTheme.of(context).primaryBackground
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildHeader(),
              _buildDayLabels(),
              const SizedBox(height: 8),
              Expanded(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemCount: _calendarDays.length,
                    itemBuilder: (context, index) {
                      return _buildCalendarTile(_calendarDays[index], index);
                    },
                  ),
                ),
              ),
              _buildStreakStats(),
            ],
          ),
        ),
      ),
    );
  }

  // Constants
  static const Color _streakColor = Color(0xFF6A4CFF);
  static const Color _holidayColor = Color(0xFF00D26A);
  static const Color _weekendColor = Color(0xFFF5F5F5);

  static const List<String> _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  static const List<String> _dayLabels = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];
}
