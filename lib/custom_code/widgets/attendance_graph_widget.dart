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

import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:ui' as ui;
import 'dart:convert';

class AttendanceGraphWidget extends StatefulWidget {
  const AttendanceGraphWidget({
    super.key,
    this.width,
    this.height,
    required this.availableCourseIds,
    required this.userID,
    required this.period,
  });

  final double? width;
  final double? height;
  final List<String> availableCourseIds;
  final String userID;
  final String period;

  @override
  State<AttendanceGraphWidget> createState() => _AttendanceGraphWidgetState();
}

class _AttendanceGraphWidgetState extends State<AttendanceGraphWidget> {
  List<CourseAttendanceData> _courseData = [];
  bool _isLoading = false;
  String? _error;
  TooltipBehavior?
      _tooltipBehavior; // Made nullable to fix initialization error

  // Enhanced color palette with better contrast
  final List<Color> _courseColors = [
    const Color(0xFF4F46E5), // Indigo - darker
    const Color(0xFF7C3AED), // Violet - darker
    const Color(0xFFDB2777), // Pink - darker
    const Color(0xFF0891B2), // Cyan - darker
    const Color(0xFF059669), // Emerald - darker
    const Color(0xFFD97706), // Amber - darker
    const Color(0xFFDC2626), // Red - darker
    const Color(0xFF2563EB), // Blue - darker
    const Color(0xFF92400E), // Brown - darker
    const Color(0xFF374151), // Gray - darker
  ];

  @override
  void initState() {
    super.initState();
    // Don't initialize _tooltipBehavior here to avoid context access error

    // Only fetch data if course IDs are provided
    if (widget.availableCourseIds.isNotEmpty) {
      _fetchAttendanceData();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Initialize tooltip behavior here where context is safely available
    _tooltipBehavior ??= TooltipBehavior(
      enable: true,
      format: 'point.x : point.y%',
      header: '',
      canShowMarker: false,
      color: FlutterFlowTheme.of(context).primaryBackground,
      textStyle: TextStyle(
        color: FlutterFlowTheme.of(context).primaryText,
        fontSize: 12,
        fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
      ),
    );
  }

  @override
  void didUpdateWidget(AttendanceGraphWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.userID != widget.userID ||
        !_listEquals(oldWidget.availableCourseIds, widget.availableCourseIds) ||
        oldWidget.period != widget.period) {
      if (widget.availableCourseIds.isNotEmpty) {
        _fetchAttendanceData();
      } else {
        setState(() {
          _courseData = [];
          _isLoading = false;
          _error = null;
        });
      }
    }
  }

  bool _listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  Future<void> _fetchAttendanceData() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await SupaFlow.client.rpc(
        'get_attendance_summary',
        params: {
          'p_user_id': widget.userID,
          'p_course_ids': widget.availableCourseIds,
          'p_period': widget.period,
        },
      );

      if (response != null && response['success'] == true) {
        final courses = response['courses'] as List<dynamic>? ?? [];
        final List<CourseAttendanceData> courseData = [];

        for (int i = 0; i < courses.length; i++) {
          final course = courses[i] as Map<String, dynamic>;
          final attendanceData =
              course['attendanceData'] as List<dynamic>? ?? [];

          final List<AttendancePoint> points = attendanceData.map((point) {
            final pointMap = point as Map<String, dynamic>;

            // Parse date and validate it's reasonable
            DateTime parsedDate;
            try {
              parsedDate = DateTime.parse(pointMap['classDateISO'] as String);
            } catch (e) {
              parsedDate = DateTime.now();
            }

            // Ensure date is within reasonable range (last 5 years to next year)
            final now = DateTime.now();
            final minDate = DateTime(now.year - 5);
            final maxDate = DateTime(now.year + 1);

            if (parsedDate.isBefore(minDate) || parsedDate.isAfter(maxDate)) {
              parsedDate = now; // Default to current date if unreasonable
            }

            return AttendancePoint(
              date: parsedDate,
              percentage: ((pointMap['percentage'] ?? 0) as num).toDouble(),
              attendedClasses: (pointMap['attendedClasses'] ?? 0) as int,
              totalClasses: (pointMap['totalClasses'] ?? 0) as int,
              checkinTime: (pointMap['checkinTime'] ?? '') as String,
              status: (pointMap['status'] ?? '') as String,
            );
          }).toList();

          // Sort points by date
          points.sort((a, b) => a.date.compareTo(b.date));

          courseData.add(CourseAttendanceData(
            courseId: (course['courseId'] ?? '') as String,
            courseName: (course['courseName'] ?? 'Unknown Course') as String,
            currentAttendance:
                ((course['currentAttendance'] ?? 0) as num).toDouble(),
            changeInAttendance:
                (course['changeInAttendance'] ?? 'N/A') as String,
            totalClasses: (course['totalClasses'] ?? 0) as int,
            attendedClasses: (course['attendedClasses'] ?? 0) as int,
            attendanceRate: (course['attendanceRate'] ?? 'Unknown') as String,
            meetsMinimumRequirement:
                (course['meetsMinimumRequirement'] ?? false) as bool,
            color: _courseColors[i % _courseColors.length],
            points: points,
          ));
        }

        if (mounted) {
          setState(() {
            _courseData = courseData;
            _isLoading = false;
          });
        }
      } else {
        throw Exception(
            response?['error'] ?? 'Failed to fetch attendance data');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 400,
      width: widget.width ?? double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            FlutterFlowTheme.of(context).secondaryBackground,
            FlutterFlowTheme.of(context).primaryBackground,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: FlutterFlowTheme.of(context).alternate.withValues(alpha: 51),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context)
                  .secondaryBackground
                  .withValues(alpha: 204),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: FlutterFlowTheme.of(context)
                    .alternate
                    .withValues(alpha: 51),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                // Header
                _buildHeader(),
                const SizedBox(height: 20),
                // Chart Section
                Expanded(
                  flex: 3,
                  child: _buildChart(),
                ),
                const SizedBox(height: 20),
                // Summary Cards Section
                if (_courseData.isNotEmpty)
                  SizedBox(
                    height: 140, // Fixed height for summary cards
                    child: _buildSummaryCards(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Attendance Trends',
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily:
                        FlutterFlowTheme.of(context).headlineSmallFamily,
                    fontWeight: FontWeight.w700,
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
            ),
            if (widget.availableCourseIds.isNotEmpty)
              Text(
                '${widget.availableCourseIds.length} course${widget.availableCourseIds.length == 1 ? '' : 's'} selected',
                style: FlutterFlowTheme.of(context).bodySmall.override(
                      fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
              ),
          ],
        ),
        if (_isLoading)
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primary.withValues(alpha: 26),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildChart() {
    // Show course selection prompt if no courses are selected
    if (widget.availableCourseIds.isEmpty) {
      return _buildCourseSelectionPrompt();
    }

    if (_isLoading) {
      return _buildLoadingState();
    }

    if (_error != null) {
      return _buildErrorState();
    }

    if (_courseData.isEmpty) {
      return _buildEmptyState();
    }

    // Ensure tooltip behavior is initialized
    if (_tooltipBehavior == null) {
      return _buildLoadingState();
    }

    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context)
            .primaryBackground
            .withValues(alpha: 128),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate.withValues(alpha: 77),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SfCartesianChart(
          primaryXAxis: DateTimeAxis(
            title: AxisTitle(
              text: 'Date',
              textStyle: TextStyle(
                color: FlutterFlowTheme.of(context).secondaryText,
                fontSize: 12,
                fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                fontWeight: FontWeight.w500,
              ),
            ),
            labelStyle: TextStyle(
              color: FlutterFlowTheme.of(context).secondaryText,
              fontSize: 10,
              fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
            ),
            majorGridLines: MajorGridLines(
              color:
                  FlutterFlowTheme.of(context).alternate.withValues(alpha: 77),
            ),
            axisLine: AxisLine(
              color:
                  FlutterFlowTheme.of(context).alternate.withValues(alpha: 128),
            ),
            // Ensure reasonable date range
            minimum: _getMinDate(),
            maximum: _getMaxDate(),
          ),
          primaryYAxis: NumericAxis(
            title: AxisTitle(
              text: 'Attendance %',
              textStyle: TextStyle(
                color: FlutterFlowTheme.of(context).secondaryText,
                fontSize: 12,
                fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                fontWeight: FontWeight.w500,
              ),
            ),
            labelStyle: TextStyle(
              color: FlutterFlowTheme.of(context).secondaryText,
              fontSize: 10,
              fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
            ),
            minimum: 0,
            maximum: 100,
            interval: 20,
            majorGridLines: MajorGridLines(
              color:
                  FlutterFlowTheme.of(context).alternate.withValues(alpha: 77),
            ),
            axisLine: AxisLine(
              color:
                  FlutterFlowTheme.of(context).alternate.withValues(alpha: 128),
            ),
          ),
          tooltipBehavior: _tooltipBehavior!,
          legend: Legend(
            isVisible: true,
            position: LegendPosition.bottom,
            textStyle: TextStyle(
              color: FlutterFlowTheme.of(context).primaryText,
              fontSize: 11,
              fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
              fontWeight: FontWeight.w500,
            ),
            overflowMode: LegendItemOverflowMode.wrap,
          ),
          plotAreaBorderColor:
              FlutterFlowTheme.of(context).alternate.withValues(alpha: 51),
          backgroundColor: Colors.transparent,
          series: _courseData
              .map<SplineSeries<AttendancePoint, DateTime>>((courseData) {
            return SplineSeries<AttendancePoint, DateTime>(
              dataSource: courseData.points,
              xValueMapper: (AttendancePoint point, _) => point.date,
              yValueMapper: (AttendancePoint point, _) => point.percentage,
              name: courseData.courseName,
              color: courseData.color,
              width: 3,
              markerSettings: MarkerSettings(
                isVisible: true,
                color: courseData.color,
                borderColor: FlutterFlowTheme.of(context).secondaryBackground,
                borderWidth: 2,
                height: 8,
                width: 8,
                shape: DataMarkerType.circle,
              ),
              dataLabelSettings: const DataLabelSettings(isVisible: false),
              splineType: SplineType.natural,
              cardinalSplineTension: 0.5,
              enableTooltip: true,
            );
          }).toList(),
        ),
      ),
    );
  }

  DateTime? _getMinDate() {
    if (_courseData.isEmpty) return null;
    DateTime? minDate;
    for (var course in _courseData) {
      for (var point in course.points) {
        if (minDate == null || point.date.isBefore(minDate)) {
          minDate = point.date;
        }
      }
    }
    return minDate?.subtract(const Duration(days: 7));
  }

  DateTime? _getMaxDate() {
    if (_courseData.isEmpty) return null;
    DateTime? maxDate;
    for (var course in _courseData) {
      for (var point in course.points) {
        if (maxDate == null || point.date.isAfter(maxDate)) {
          maxDate = point.date;
        }
      }
    }
    return maxDate?.add(const Duration(days: 7));
  }

  Widget _buildCourseSelectionPrompt() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context)
              .primaryBackground
              .withValues(alpha: 179),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: FlutterFlowTheme.of(context).alternate.withValues(alpha: 77),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    FlutterFlowTheme.of(context).primary.withValues(alpha: 51),
                    FlutterFlowTheme.of(context)
                        .secondary
                        .withValues(alpha: 51),
                  ],
                ),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(
                Icons.school_outlined,
                size: 40,
                color: FlutterFlowTheme.of(context).primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '🎯 Ready to Track Your Progress?',
              style: FlutterFlowTheme.of(context).titleLarge.override(
                    fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                    fontWeight: FontWeight.w600,
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Select your courses above to unlock beautiful attendance insights and discover patterns in your academic journey! 📈✨',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    color: FlutterFlowTheme.of(context).secondaryText,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context)
              .primaryBackground
              .withValues(alpha: 179),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '✨ Crafting your attendance story...',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context)
              .primaryBackground
              .withValues(alpha: 179),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).error.withValues(alpha: 26),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                Icons.refresh_outlined,
                size: 32,
                color: FlutterFlowTheme.of(context).error,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '🔄 Oops! Something went sideways',
              style: FlutterFlowTheme.of(context).titleMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).titleMediumFamily,
                    color: FlutterFlowTheme.of(context).error,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Don\'t worry, it happens to the best of us! Let\'s give it another shot.',
              style: FlutterFlowTheme.of(context).bodySmall.override(
                    fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                    color: FlutterFlowTheme.of(context).secondaryText,
                  ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 20),
            _buildGlassmorphicButton(
              onPressed: _fetchAttendanceData,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.refresh,
                    size: 16,
                    color: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Try Again',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelMediumFamily,
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context)
              .primaryBackground
              .withValues(alpha: 179),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context)
                    .secondaryText
                    .withValues(alpha: 26),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                Icons.timeline_outlined,
                size: 32,
                color: FlutterFlowTheme.of(context).secondaryText,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '📊 Your attendance journey awaits!',
              style: FlutterFlowTheme.of(context).titleMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).titleMediumFamily,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start attending classes to see your progress unfold here.',
              style: FlutterFlowTheme.of(context).bodySmall.override(
                    fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                    color: FlutterFlowTheme.of(context).secondaryText,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassmorphicButton({
    required VoidCallback onPressed,
    required Widget child,
    Color? backgroundColor,
  }) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            (backgroundColor ?? FlutterFlowTheme.of(context).primary)
                .withValues(alpha: 204),
            (backgroundColor ?? FlutterFlowTheme.of(context).primary)
                .withValues(alpha: 153),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: (backgroundColor ?? FlutterFlowTheme.of(context).primary)
                .withValues(alpha: 77),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Center(child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _courseData
            .map((courseData) => _buildSummaryCard(courseData))
            .toList(),
      ),
    );
  }

  Widget _buildSummaryCard(CourseAttendanceData courseData) {
    return Container(
      width: 200,
      height: 140, // Fixed height
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            FlutterFlowTheme.of(context)
                .primaryBackground
                .withValues(alpha: 230),
            FlutterFlowTheme.of(context)
                .secondaryBackground
                .withValues(alpha: 230),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: courseData.color.withValues(alpha: 51),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: courseData.color.withValues(alpha: 77),
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context)
                  .primaryBackground
                  .withValues(alpha: 179),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Course indicator and name
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: courseData.color,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: courseData.color.withValues(alpha: 102),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        courseData.courseName,
                        style: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).titleSmallFamily,
                              fontWeight: FontWeight.w700,
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Attendance percentage
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Attendance',
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodySmallFamily,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      '${courseData.currentAttendance.toStringAsFixed(1)}%',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleMediumFamily,
                            fontWeight: FontWeight.bold,
                            color: _getAttendanceColor(
                                courseData.currentAttendance),
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Classes attended
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Classes',
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodySmallFamily,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      '${courseData.attendedClasses}/${courseData.totalClasses}',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.w600,
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                    ),
                  ],
                ),
                const Spacer(),

                // Status indicator
                Container(
                  width: double.infinity,
                  height: 28, // Fixed height
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _getStatusColor(courseData.attendanceRate)
                            .withValues(alpha: 51),
                        _getStatusColor(courseData.attendanceRate)
                            .withValues(alpha: 26),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: _getStatusColor(courseData.attendanceRate)
                          .withValues(alpha: 102),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      _getStatusEmoji(courseData.attendanceRate) +
                          courseData.attendanceRate,
                      style: FlutterFlowTheme.of(context).labelSmall.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelSmallFamily,
                            color: _getStatusColor(courseData.attendanceRate),
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getStatusEmoji(String status) {
    switch (status.toLowerCase()) {
      case 'excellent':
        return '🌟 ';
      case 'good':
        return '👍 ';
      case 'warning':
        return '⚠️ ';
      case 'below minimum':
        return '🚨 ';
      default:
        return '📊 ';
    }
  }

  Color _getAttendanceColor(double percentage) {
    if (percentage >= 90) return const Color(0xFF059669); // Green
    if (percentage >= 80) return const Color(0xFF2563EB); // Blue
    if (percentage >= 70) return const Color(0xFFD97706); // Amber
    return const Color(0xFFDC2626); // Red
  }

  Color _getChangeColor(String change) {
    if (change.startsWith('+')) return const Color(0xFF059669); // Green
    if (change.startsWith('-')) return const Color(0xFFDC2626); // Red
    return FlutterFlowTheme.of(context).secondaryText;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'excellent':
        return const Color(0xFF059669); // Green
      case 'good':
        return const Color(0xFF2563EB); // Blue
      case 'warning':
        return const Color(0xFFD97706); // Amber
      case 'below minimum':
        return const Color(0xFFDC2626); // Red
      default:
        return FlutterFlowTheme.of(context).secondaryText;
    }
  }
}

// Data models
class CourseAttendanceData {
  final String courseId;
  final String courseName;
  final double currentAttendance;
  final String changeInAttendance;
  final int totalClasses;
  final int attendedClasses;
  final String attendanceRate;
  final bool meetsMinimumRequirement;
  final Color color;
  final List<AttendancePoint> points;

  CourseAttendanceData({
    required this.courseId,
    required this.courseName,
    required this.currentAttendance,
    required this.changeInAttendance,
    required this.totalClasses,
    required this.attendedClasses,
    required this.attendanceRate,
    required this.meetsMinimumRequirement,
    required this.color,
    required this.points,
  });
}

class AttendancePoint {
  final DateTime date;
  final double percentage;
  final int attendedClasses;
  final int totalClasses;
  final String checkinTime;
  final String status;

  AttendancePoint({
    required this.date,
    required this.percentage,
    required this.attendedClasses,
    required this.totalClasses,
    required this.checkinTime,
    required this.status,
  });
}
