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
  List<AnimationController> _tileControllers = [];

  // Animations
  late Animation<Offset> _slideAnimation;
  List<Animation<double>> _tileAnimations = [];
  List<Animation<Offset>> _tileSlideAnimations = [];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _generateCalendarDays();

    // Delay initial animation to ensure widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _animateInitialLoad();
      }
    });
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
    try {
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
    } catch (e) {
      debugPrint('Animation initialization error: $e');
      // Fallback: create minimal animations
      _slideController = AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      );
      _staggerController = AnimationController(
        duration: const Duration(milliseconds: 1200),
        vsync: this,
      );
      _slideAnimation = Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(-1.0, 0.0),
      ).animate(_slideController);
    }
  }

  void _createTileAnimations() {
    try {
      _tileAnimations = _tileControllers.map((controller) {
        return CurvedAnimation(
          parent: controller,
          curve: const Cubic(0.175, 0.885, 0.32, 1.275),
        );
      }).toList();

      _tileSlideAnimations = _tileControllers.asMap().entries.map((entry) {
        final index = entry.key;
        final controller = entry.value;
        final row = index ~/ 7;

        return Tween<Offset>(
          begin: Offset(0.0, 0.3 + (row * 0.1)),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: const Interval(
            0.0,
            0.8,
            curve: Curves.easeOutCubic,
          ),
        ));
      }).toList();
    } catch (e) {
      debugPrint('Tile animation creation error: $e');
    }
  }

  void _animateInitialLoad() {
    if (!_isInitialLoad || !mounted) return;

    try {
      // Staggered animation: row by row, then tile by tile
      for (int row = 0; row < 6; row++) {
        for (int col = 0; col < 7; col++) {
          final index = row * 7 + col;
          if (index < _tileControllers.length) {
            final delay = (row * 80) + (col * 25);

            Future.delayed(Duration(milliseconds: delay), () {
              if (mounted &&
                  _isInitialLoad &&
                  index < _tileControllers.length) {
                _tileControllers[index].forward();
              }
            });
          }
        }
      }
      _isInitialLoad = false;
    } catch (e) {
      debugPrint('Initial load animation error: $e');
      _isInitialLoad = false;
    }
  }

  void _animateMonthTransition() {
    if (!mounted) return;

    try {
      const quickDuration = Duration(milliseconds: 200);

      for (int i = 0; i < _tileControllers.length; i++) {
        if (i < _tileControllers.length) {
          _tileControllers[i].duration = quickDuration;
          _tileControllers[i].reset();

          Future.delayed(Duration(milliseconds: i * 8), () {
            if (mounted && _isAnimating && i < _tileControllers.length) {
              _tileControllers[i].forward();
            }
          });
        }
      }
    } catch (e) {
      debugPrint('Month transition animation error: $e');
    }
  }

  void _generateCalendarDays() {
    try {
      _calendarDays.clear();
      final firstDay = DateTime(_visibleMonth.year, _visibleMonth.month, 1);
      final firstWeekday = (firstDay.weekday - 1) % 7; // Ensure 0-6 range
      final startDate = firstDay.subtract(Duration(days: firstWeekday));

      for (int i = 0; i < 42; i++) {
        _calendarDays.add(startDate.add(Duration(days: i)));
      }
    } catch (e) {
      debugPrint('Calendar generation error: $e');
      // Fallback: generate current month only
      _calendarDays = List.generate(
          42, (index) => DateTime.now().add(Duration(days: index)));
    }
  }

  DateTime _unixDaysToDateTime(int days) {
    try {
      return DateTime(1970, 1, 1).add(Duration(days: days));
    } catch (e) {
      debugPrint('Unix conversion error: $e');
      return DateTime.now();
    }
  }

  bool _isDateInList(DateTime date, List<int> unixDaysList) {
    try {
      if (unixDaysList.isEmpty) return false;
      final daysSinceEpoch = date.difference(DateTime(1970, 1, 1)).inDays;
      return unixDaysList.contains(daysSinceEpoch);
    } catch (e) {
      debugPrint('Date comparison error: $e');
      return false;
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    try {
      return date1.year == date2.year &&
          date1.month == date2.month &&
          date1.day == date2.day;
    } catch (e) {
      debugPrint('Same day comparison error: $e');
      return false;
    }
  }

  bool _isCurrentMonth(DateTime date) {
    try {
      return date.year == _visibleMonth.year &&
          date.month == _visibleMonth.month;
    } catch (e) {
      debugPrint('Current month check error: $e');
      return true;
    }
  }

  int _calculateStreakCount() {
    try {
      if (widget.streakHistory.isEmpty) return 0;

      final monthStart = DateTime(_visibleMonth.year, _visibleMonth.month, 1);
      final monthEnd = DateTime(_visibleMonth.year, _visibleMonth.month + 1, 0);

      return widget.streakHistory
          .map(_unixDaysToDateTime)
          .where((date) =>
              date.isAfter(monthStart.subtract(const Duration(days: 1))) &&
              date.isBefore(monthEnd.add(const Duration(days: 1))))
          .length;
    } catch (e) {
      debugPrint('Streak calculation error: $e');
      return 0;
    }
  }

  Future<void> _navigateMonth(int direction) async {
    if (_isAnimating || !mounted) return;

    try {
      HapticFeedback.lightImpact();
    } catch (e) {
      // Haptic feedback not available
    }

    setState(() => _isAnimating = true);

    try {
      // Reset tile controllers for quick transition
      for (int i = 0; i < _tileControllers.length; i++) {
        _tileControllers[i].reset();
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

      if (mounted) {
        setState(() {
          _visibleMonth =
              DateTime(_visibleMonth.year, _visibleMonth.month + direction, 1);
          _generateCalendarDays();
        });

        _slideController.reset();
        _animateMonthTransition();

        // Reset durations for future initial loads
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            for (int i = 0; i < _tileControllers.length; i++) {
              _tileControllers[i].duration =
                  Duration(milliseconds: 300 + (i * 15));
            }
          }
        });
      }
    } catch (e) {
      debugPrint('Month navigation error: $e');
    } finally {
      if (mounted) {
        setState(() => _isAnimating = false);
      }
    }
  }

  Widget _buildHeader(double headerHeight) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fontSize = math.min(math.max(headerHeight * 0.4, 14.0), 22.0);

    return SizedBox(
      height: headerHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _isAnimating ? null : () => _navigateMonth(-1),
            icon: Icon(
              Icons.chevron_left,
              size: math.min(math.max(headerHeight * 0.5, 20.0), 28.0),
              color: isDark
                  ? FlutterFlowTheme.of(context).primaryText
                  : Colors.black87,
            ),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(
              minWidth: math.max(headerHeight * 0.8, 32.0),
              minHeight: math.max(headerHeight * 0.8, 32.0),
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
              size: math.min(math.max(headerHeight * 0.5, 20.0), 28.0),
              color: isDark
                  ? FlutterFlowTheme.of(context).primaryText
                  : Colors.black87,
            ),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(
              minWidth: math.max(headerHeight * 0.8, 32.0),
              minHeight: math.max(headerHeight * 0.8, 32.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayLabels(double labelHeight) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fontSize = math.min(math.max(labelHeight * 0.4, 10.0), 14.0);

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

    final fontSize = math.min(math.max(tileSize * 0.3, 10.0), 16.0);

    // Safe animation access
    final hasAnimation = index < _tileControllers.length &&
        index < _tileAnimations.length &&
        index < _tileSlideAnimations.length;

    if (!hasAnimation) {
      // Fallback without animation
      return Container(
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
      );
    }

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _tileControllers[index],
        builder: (context, child) {
          return SlideTransition(
            position: _tileSlideAnimations[index],
            child: Transform.scale(
              scale: _tileAnimations[index].value,
              child: Opacity(
                opacity: _tileControllers[index].value,
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
    final fontSize = math.min(math.max(statsHeight * 0.3, 11.0), 15.0);
    final iconSize = math.min(math.max(statsHeight * 0.4, 16.0), 20.0);

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
    // Ensure we have valid dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final containerWidth = widget.width ?? math.min(screenWidth - 32, 400.0);
    final containerHeight =
        widget.height ?? math.min(screenHeight * 0.6, 450.0);

    // Ensure minimum sizes
    final safeWidth = math.max(containerWidth, 300.0);
    final safeHeight = math.max(containerHeight, 350.0);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Responsive sizing with bounds checking
    final padding = math.max(math.min(safeHeight * 0.04, 16.0), 8.0);
    final headerHeight = math.max(math.min(safeHeight * 0.12, 50.0), 35.0);
    final labelHeight = math.max(math.min(safeHeight * 0.08, 35.0), 25.0);
    final statsHeight = math.max(math.min(safeHeight * 0.1, 45.0), 30.0);
    final spacing = math.max(math.min(safeHeight * 0.02, 12.0), 6.0);

    final calendarHeight = safeHeight -
        (padding * 2) -
        headerHeight -
        labelHeight -
        statsHeight -
        (spacing * 3);

    final tileSize = math.max(calendarHeight / 6, 30.0);

    return Container(
      width: safeWidth,
      height: safeHeight,
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
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(headerHeight),
            SizedBox(height: spacing),
            _buildDayLabels(labelHeight),
            SizedBox(height: spacing * 0.5),
            Expanded(
              child: SlideTransition(
                position: _slideAnimation,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemCount: _calendarDays.length,
                  itemBuilder: (context, index) {
                    if (index < _calendarDays.length) {
                      return _buildCalendarTile(
                          _calendarDays[index], index, tileSize);
                    }
                    return const SizedBox.shrink();
                  },
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
