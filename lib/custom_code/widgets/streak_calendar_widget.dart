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
  late AnimationController _slideController;
  late List<AnimationController> _tileControllers;
  late Animation<Offset> _slideAnimation;

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
    for (final controller in _tileControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initializeAnimations() {
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    _tileControllers = List.generate(
      42, // Maximum calendar cells
      (index) => AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      ),
    );
  }

  void _animateInitialLoad() {
    for (int i = 0;
        i < _calendarDays.length && i < _tileControllers.length;
        i++) {
      Future.delayed(Duration(milliseconds: i * 25), () {
        if (mounted) _tileControllers[i].forward();
      });
    }
  }

  void _generateCalendarDays() {
    _calendarDays.clear();
    final firstDay = DateTime(_visibleMonth.year, _visibleMonth.month, 1);
    final firstWeekday = firstDay.weekday - 1;
    final startDate = firstDay.subtract(Duration(days: firstWeekday));

    // Always generate 42 cells (6 weeks) for consistent layout
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

  List<List<DateTime>> _getConsecutiveStreakGroups() {
    if (widget.streakHistory.isEmpty) return [];

    final streakDates = widget.streakHistory.map(_unixDaysToDateTime).toList()
      ..sort();

    final groups = <List<DateTime>>[];
    List<DateTime> currentGroup = [streakDates[0]];

    for (int i = 1; i < streakDates.length; i++) {
      final daysDiff = streakDates[i].difference(streakDates[i - 1]).inDays;
      if (daysDiff == 1) {
        currentGroup.add(streakDates[i]);
      } else {
        if (currentGroup.length >= 2) groups.add(List.from(currentGroup));
        currentGroup = [streakDates[i]];
      }
    }

    if (currentGroup.length >= 2) groups.add(currentGroup);
    return groups;
  }

  bool _isInStreakGroup(DateTime date) {
    final streakGroups = _getConsecutiveStreakGroups();
    return streakGroups.any(
        (group) => group.any((streakDate) => _isSameDay(date, streakDate)));
  }

  int _calculateLongestStreakInMonth() {
    if (widget.streakHistory.isEmpty) return 0;

    final monthStart = DateTime(_visibleMonth.year, _visibleMonth.month, 1);
    final monthEnd = DateTime(_visibleMonth.year, _visibleMonth.month + 1, 0);

    final monthStreakDays = widget.streakHistory
        .map(_unixDaysToDateTime)
        .where((date) =>
            date.isAfter(monthStart.subtract(const Duration(days: 1))) &&
            date.isBefore(monthEnd.add(const Duration(days: 1))))
        .toList()
      ..sort();

    if (monthStreakDays.isEmpty) return 0;

    int longestStreak = 1;
    int currentStreak = 1;

    for (int i = 1; i < monthStreakDays.length; i++) {
      final daysDiff =
          monthStreakDays[i].difference(monthStreakDays[i - 1]).inDays;
      if (daysDiff == 1) {
        currentStreak++;
        longestStreak = math.max(longestStreak, currentStreak);
      } else {
        currentStreak = 1;
      }
    }

    return longestStreak;
  }

  Map<String, dynamic> _calculateStreakComparison() {
    final currentMonth = DateTime(_visibleMonth.year, _visibleMonth.month, 1);
    final previousMonth =
        DateTime(_visibleMonth.year, _visibleMonth.month - 1, 1);
    final currentMonthEnd =
        DateTime(_visibleMonth.year, _visibleMonth.month + 1, 0);
    final previousMonthEnd =
        DateTime(_visibleMonth.year, _visibleMonth.month, 0);

    final currentMonthStreaks = widget.streakHistory
        .map(_unixDaysToDateTime)
        .where((date) =>
            date.isAfter(currentMonth.subtract(const Duration(days: 1))) &&
            date.isBefore(currentMonthEnd.add(const Duration(days: 1))))
        .length;

    final previousMonthStreaks = widget.streakHistory
        .map(_unixDaysToDateTime)
        .where((date) =>
            date.isAfter(previousMonth.subtract(const Duration(days: 1))) &&
            date.isBefore(previousMonthEnd.add(const Duration(days: 1))))
        .length;

    final difference = currentMonthStreaks - previousMonthStreaks;

    return {
      'current': currentMonthStreaks,
      'previous': previousMonthStreaks,
      'difference': difference.abs(),
      'isIncrease': difference > 0,
      'isDecrease': difference < 0,
      'hasComparison': previousMonthStreaks > 0,
    };
  }

  Future<void> _navigateMonth(int direction) async {
    if (_isAnimating) return;

    try {
      HapticFeedback.lightImpact();
    } catch (e) {
      debugPrint('Haptic feedback not available: $e');
    }

    setState(() => _isAnimating = true);

    for (final controller in _tileControllers) {
      controller.reset();
    }

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(direction > 0 ? -1.0 : 1.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    await _slideController.forward();

    setState(() {
      _visibleMonth =
          DateTime(_visibleMonth.year, _visibleMonth.month + direction, 1);
      _generateCalendarDays();
    });

    _slideController.reset();
    _animateInitialLoad();
    setState(() => _isAnimating = false);
  }

  Widget _buildHeader() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _isAnimating ? null : () => _navigateMonth(-1),
            icon: Icon(
              Icons.chevron_left,
              size: 24,
              color: isDark
                  ? FlutterFlowTheme.of(context).primaryText
                  : Colors.black87,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          ),
          Expanded(
            child: Text(
              '${_monthNames[_visibleMonth.month - 1]} ${_visibleMonth.year}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
              size: 24,
              color: isDark
                  ? FlutterFlowTheme.of(context).primaryText
                  : Colors.black87,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          ),
        ],
      ),
    );
  }

  Widget _buildDayLabels() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 32,
      child: Row(
        children: _dayLabels.asMap().entries.map((entry) {
          final index = entry.key;
          final day = entry.value;
          final isWeekend = index >= 5;

          return Expanded(
            child: Center(
              child: Text(
                day,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: isWeekend ? FontWeight.w700 : FontWeight.w600,
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
    final isInStreakGroup = _isInStreakGroup(date);
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
    } else if (isStreak && !isInStreakGroup) {
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

    final controller = index < _tileControllers.length
        ? _tileControllers[index]
        : _tileControllers[0];

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.scale(
          scale: controller.value,
          child: Opacity(
            opacity: controller.value,
            child: Container(
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(4),
                border: border,
                boxShadow: (isToday ||
                        backgroundColor == _streakColor ||
                        backgroundColor == _holidayColor)
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
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: textColor,
                        fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
                        fontSize: 14,
                      ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStreakStatsDisplay() {
    final longestStreak = _calculateLongestStreakInMonth();
    final comparison = _calculateStreakComparison();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _streakColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.local_fire_department,
                size: 18,
                color: _streakColor,
              ),
              const SizedBox(width: 8),
              Text(
                'Streak this month: $longestStreak',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: _streakColor,
                    ),
              ),
            ],
          ),
          if (comparison['hasComparison'])
            Row(
              children: [
                Icon(
                  comparison['isIncrease']
                      ? Icons.trending_up
                      : comparison['isDecrease']
                          ? Icons.trending_down
                          : Icons.trending_flat,
                  size: 16,
                  color: comparison['isIncrease']
                      ? _increaseColor
                      : comparison['isDecrease']
                          ? _decreaseColor
                          : Colors.grey,
                ),
                const SizedBox(width: 4),
                Text(
                  comparison['isIncrease'] || comparison['isDecrease']
                      ? '${comparison['difference']}'
                      : 'Same',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: comparison['isIncrease']
                            ? _increaseColor
                            : comparison['isDecrease']
                                ? _decreaseColor
                                : Colors.grey,
                      ),
                ),
              ],
            )
          else
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  '${comparison['current']} days',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                ),
              ],
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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            _buildDayLabels(),
            const SizedBox(height: 8),
            Expanded(
              child: SlideTransition(
                position: _slideAnimation,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: ContinuousStreakPainter(
                          streakGroups: _getConsecutiveStreakGroups(),
                          calendarDays: _calendarDays,
                        ),
                      ),
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        childAspectRatio: 1.2,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemCount: _calendarDays.length,
                      itemBuilder: (context, index) =>
                          _buildCalendarTile(_calendarDays[index], index),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildStreakStatsDisplay(),
          ],
        ),
      ),
    );
  }

  // Constants
  static const Color _streakColor = Color(0xFF6A4CFF);
  static const Color _holidayColor = Color(0xFF00D26A);
  static const Color _weekendColor = Color(0xFFF5F5F5);
  static const Color _increaseColor = Color(0xFF00D26A);
  static const Color _decreaseColor = Color(0xFFFF4757);

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

class ContinuousStreakPainter extends CustomPainter {
  final List<List<DateTime>> streakGroups;
  final List<DateTime> calendarDays;

  ContinuousStreakPainter({
    required this.streakGroups,
    required this.calendarDays,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (streakGroups.isEmpty) return;

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFF6A4CFF).withOpacity(0.3);

    final tileWidth = size.width / 7;
    final tileHeight = size.height / 6;

    for (final group in streakGroups) {
      if (group.length < 2) continue;

      final rects = <Rect>[];
      for (final date in group) {
        final index = calendarDays.indexWhere((d) =>
            d.year == date.year && d.month == date.month && d.day == date.day);
        if (index != -1) {
          final row = index ~/ 7;
          final col = index % 7;
          final x = col * tileWidth + 1;
          final y = row * tileHeight + 1;

          rects.add(Rect.fromLTWH(x, y, tileWidth - 2, tileHeight - 2));
        }
      }

      if (rects.length >= 2) {
        final combinedRect = rects.reduce((a, b) => Rect.fromLTRB(
              math.min(a.left, b.left),
              math.min(a.top, b.top),
              math.max(a.right, b.right),
              math.max(a.bottom, b.bottom),
            ));

        final rrect =
            RRect.fromRectAndRadius(combinedRect, const Radius.circular(4));
        canvas.drawRRect(rrect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
