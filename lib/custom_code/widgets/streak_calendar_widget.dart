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
  bool _isAnimating = false;
  bool _isInitialLoad = true;

  // Animation controllers
  late AnimationController _slideController;
  late AnimationController _staggerController;
  late List<AnimationController> _tileControllers;

  // Animations
  late Animation<Offset> _slideAnimation;
  late List<Animation<double>> _tileAnimations;
  late List<Animation<Offset>> _tileSlideAnimations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _generateCalendarDays();
    _animateInitialLoad();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _staggerController.dispose();
    for (final controller in _tileControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initializeAnimations() {
    // Main slide controller for month transitions
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Stagger controller for tile animations
    _staggerController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOutCubic,
    ));

    // Individual tile controllers for fluid animations
    _tileControllers = List.generate(
      42,
      (index) => AnimationController(
        duration: Duration(milliseconds: 300 + (index * 15)),
        vsync: this,
      ),
    );

    _createTileAnimations();
  }

  void _createTileAnimations() {
    _tileAnimations = _tileControllers.map((controller) {
      return CurvedAnimation(
        parent: controller,
        curve: const Cubic(0.175, 0.885, 0.32, 1.275), // Fluid spring curve
      );
    }).toList();

    _tileSlideAnimations = _tileControllers.asMap().entries.map((entry) {
      final index = entry.key;
      final controller = entry.value;
      final row = index ~/ 7;

      return Tween<Offset>(
        begin: Offset(0.0, 0.3 + (row * 0.1)), // Staggered slide-in
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          0.8,
          curve: Curves.easeOutCubic,
        ),
      ));
    }).toList();
  }

  void _animateInitialLoad() {
    if (!_isInitialLoad) return;

    // Staggered animation: row by row, then tile by tile
    for (int row = 0; row < 6; row++) {
      for (int col = 0; col < 7; col++) {
        final index = row * 7 + col;
        if (index < _tileControllers.length) {
          final delay = (row * 80) + (col * 25); // Row delay + column delay

          Future.delayed(Duration(milliseconds: delay), () {
            if (mounted && _isInitialLoad) {
              _tileControllers[index].forward();
            }
          });
        }
      }
    }

    _isInitialLoad = false;
  }

  void _animateMonthTransition() {
    // Quick, efficient animation for month changes
    const quickDuration = Duration(milliseconds: 200);

    for (int i = 0; i < _tileControllers.length; i++) {
      _tileControllers[i].duration = quickDuration;
      _tileControllers[i].reset();

      // Immediate animation without staggering for month transitions
      Future.delayed(Duration(milliseconds: i * 8), () {
        if (mounted && _isAnimating) {
          _tileControllers[i].forward();
        }
      });
    }
  }

  void _generateCalendarDays() {
    _calendarDays.clear();
    final firstDay = DateTime(_visibleMonth.year, _visibleMonth.month, 1);
    final firstWeekday = firstDay.weekday - 1;
    final startDate = firstDay.subtract(Duration(days: firstWeekday));

    for (int i = 0; i < 42; i++) {
      _calendarDays.add(startDate.add(Duration(days: i)));
    }
  }

  DateTime _unixDaysToDateTime(int days) =>
      DateTime(1970, 1, 1).add(Duration(days: days));

  bool _isDateInList(DateTime date, List<int> unixDaysList) {
    if (unixDaysList.isEmpty) return false;
    final daysSinceEpoch = date.difference(DateTime(1970, 1, 1)).inDays;
    return unixDaysList.contains(daysSinceEpoch);
  }

  bool _isSameDay(DateTime date1, DateTime date2) =>
      date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;

  bool _isCurrentMonth(DateTime date) =>
      date.year == _visibleMonth.year && date.month == _visibleMonth.month;

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

    try {
      HapticFeedback.lightImpact();
    } catch (e) {
      // Haptic feedback not available
    }

    setState(() => _isAnimating = true);

    // Reset tile controllers for quick transition
    for (final controller in _tileControllers) {
      controller.reset();
    }

    // Slide animation for month transition
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(direction > 0 ? -1.0 : 1.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOutCubic,
    ));

    await _slideController.forward();

    setState(() {
      _visibleMonth =
          DateTime(_visibleMonth.year, _visibleMonth.month + direction, 1);
      _generateCalendarDays();
    });

    _slideController.reset();
    _animateMonthTransition();

    // Reset durations for future initial loads
    Future.delayed(const Duration(milliseconds: 500), () {
      for (int i = 0; i < _tileControllers.length; i++) {
        _tileControllers[i].duration = Duration(milliseconds: 300 + (i * 15));
      }
    });

    setState(() => _isAnimating = false);
  }

  Widget _buildHeader(double headerHeight) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fontSize = math.min(headerHeight * 0.4, 18.0);

    return SizedBox(
      height: headerHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _isAnimating ? null : () => _navigateMonth(-1),
            icon: Icon(
              Icons.chevron_left,
              size: math.min(headerHeight * 0.5, 24.0),
              color: isDark
                  ? FlutterFlowTheme.of(context).primaryText
                  : Colors.black87,
            ),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(
              minWidth: headerHeight * 0.8,
              minHeight: headerHeight * 0.8,
            ),
          ),
          Expanded(
            child: Text(
              '${_monthNames[_visibleMonth.month - 1]} ${_visibleMonth.year}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: fontSize,
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
              size: math.min(headerHeight * 0.5, 24.0),
              color: isDark
                  ? FlutterFlowTheme.of(context).primaryText
                  : Colors.black87,
            ),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(
              minWidth: headerHeight * 0.8,
              minHeight: headerHeight * 0.8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayLabels(double labelHeight) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fontSize = math.min(labelHeight * 0.4, 12.0);

    return SizedBox(
      height: labelHeight,
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
                  fontWeight: isWeekend ? FontWeight.w700 : FontWeight.w600,
                  fontSize: fontSize,
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

  Widget _buildCalendarTile(DateTime date, int index, double tileSize) {
    final isToday = _isSameDay(date, _currentDate);
    final isHoliday = _isDateInList(date, widget.holidays);
    final isStreak = _isDateInList(date, widget.streakHistory);
    final isWeekend = date.weekday >= 6;
    final isCurrentMonth = _isCurrentMonth(date);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color backgroundColor;
    Color textColor =
        isDark ? FlutterFlowTheme.of(context).primaryText : Colors.black87;
    Border? border;

    if (!isCurrentMonth) {
      textColor = textColor.withOpacity(0.3);
    }

    if (isHoliday) {
      backgroundColor = _holidayColor;
      textColor = Colors.white;
    } else if (isStreak) {
      backgroundColor = _streakColor;
      textColor = Colors.white;
    } else {
      backgroundColor = isWeekend
          ? (isDark ? FlutterFlowTheme.of(context).alternate : _weekendColor)
          : (isDark
              ? FlutterFlowTheme.of(context).secondaryBackground
              : Colors.white);
    }

    if (isToday) {
      border = Border.all(
        color: isDark ? FlutterFlowTheme.of(context).primary : Colors.black,
        width: 2.0,
      );
    }

    final fontSize = math.min(tileSize * 0.3, 14.0);
    final controller = index < _tileControllers.length
        ? _tileControllers[index]
        : _tileControllers[0];

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return SlideTransition(
            position: index < _tileSlideAnimations.length
                ? _tileSlideAnimations[index]
                : _tileSlideAnimations[0],
            child: Transform.scale(
              scale: index < _tileAnimations.length
                  ? _tileAnimations[index].value
                  : controller.value,
              child: Opacity(
                opacity: controller.value,
                child: Container(
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(4),
                    border: border,
                    boxShadow: (isToday || isStreak || isHoliday)
                        ? [
                            BoxShadow(
                              color: backgroundColor.withOpacity(0.3),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            )
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(
                        color: textColor,
                        fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
                        fontSize: fontSize,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStreakStats(double statsHeight) {
    final streakCount = _calculateStreakCount();
    final fontSize = math.min(statsHeight * 0.3, 13.0);
    final iconSize = math.min(statsHeight * 0.4, 18.0);

    return Container(
      width: double.infinity,
      height: statsHeight,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _streakColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.local_fire_department,
            size: iconSize,
            color: _streakColor,
          ),
          const SizedBox(width: 8),
          Text(
            'Streak this month: $streakCount',
            style: TextStyle(
              fontSize: fontSize,
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
    final containerWidth = widget.width ?? (screenWidth - 32);
    final containerHeight = widget.height ?? 400.0;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Responsive sizing
    final padding = math.max(containerHeight * 0.04, 12.0);
    final headerHeight = math.max(containerHeight * 0.12, 40.0);
    final labelHeight = math.max(containerHeight * 0.08, 28.0);
    final statsHeight = math.max(containerHeight * 0.1, 36.0);
    final spacing = math.max(containerHeight * 0.02, 8.0);

    final calendarHeight = containerHeight -
        (padding * 2) -
        headerHeight -
        labelHeight -
        statsHeight -
        (spacing * 3);

    final tileSize = calendarHeight / 6;

    return Container(
      width: containerWidth,
      height: containerHeight,
      decoration: BoxDecoration(
        color: isDark
            ? FlutterFlowTheme.of(context).primaryBackground
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          children: [
            _buildHeader(headerHeight),
            SizedBox(height: spacing),
            _buildDayLabels(labelHeight),
            SizedBox(height: spacing * 0.5),
            SizedBox(
              height: calendarHeight,
              child: SlideTransition(
                position: _slideAnimation,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemCount: _calendarDays.length,
                  itemBuilder: (context, index) =>
                      _buildCalendarTile(_calendarDays[index], index, tileSize),
                ),
              ),
            ),
            SizedBox(height: spacing),
            _buildStreakStats(statsHeight),
          ],
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
