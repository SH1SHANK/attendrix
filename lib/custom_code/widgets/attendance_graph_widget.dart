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

import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:ui' as ui;
import 'dart:convert';

class AttendanceGraphWidget extends StatefulWidget {
  const AttendanceGraphWidget({
    super.key,
    this.width,
    this.height,
    this.selectedCourseId, // Made nullable to handle null case
    required this.userID,
    required this.period,
  });

  final double? width;
  final double? height;
  final String? selectedCourseId; // Nullable course ID
  final String userID;
  final String period;

  @override
  State<AttendanceGraphWidget> createState() => _AttendanceGraphWidgetState();
}

class _AttendanceGraphWidgetState extends State<AttendanceGraphWidget> {
  CourseAttendanceData? _courseData;
  bool _isLoading = false;
  String? _error;
  TooltipBehavior? _tooltipBehavior;

  // Single course color
  final Color _courseColor = const Color(0xFF4F46E5);

  @override
  void initState() {
    super.initState();
    // Only fetch data if course ID is provided and not empty
    if (_isValidCourseId()) {
      _fetchAttendanceData();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Safe initialization of tooltip behavior
    if (_tooltipBehavior == null) {
      _tooltipBehavior = TooltipBehavior(
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
  }

  @override
  void didUpdateWidget(AttendanceGraphWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.userID != widget.userID ||
        oldWidget.selectedCourseId != widget.selectedCourseId ||
        oldWidget.period != widget.period) {
      if (_isValidCourseId()) {
        _fetchAttendanceData();
      } else {
        setState(() {
          _courseData = null;
          _isLoading = false;
          _error = null;
        });
      }
    }
  }

  // Helper method to check if course ID is valid
  bool _isValidCourseId() {
    return widget.selectedCourseId != null &&
        widget.selectedCourseId!.isNotEmpty &&
        widget.selectedCourseId!.trim().isNotEmpty;
  }

  Future<void> _fetchAttendanceData() async {
    if (!mounted || !_isValidCourseId()) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await SupaFlow.client.rpc(
        'get_single_course_attendance',
        params: {
          'p_user_id': widget.userID,
          'p_course_id': widget.selectedCourseId!,
          'p_period': widget.period,
        },
      );

      // Safe null checking
      if (response != null &&
          response is Map<String, dynamic> &&
          response['success'] == true) {
        final course = response['course'] as Map<String, dynamic>?;

        if (course != null && mounted) {
          final attendanceData =
              course['attendanceData'] as List<dynamic>? ?? [];

          final List<AttendancePoint> points = attendanceData.map((point) {
            final pointMap = point as Map<String, dynamic>? ?? {};

            DateTime parsedDate;
            try {
              final dateString = pointMap['classDateISO'] as String?;
              if (dateString != null && dateString.isNotEmpty) {
                parsedDate = DateTime.parse(dateString);
              } else {
                parsedDate = DateTime.now();
              }
            } catch (e) {
              parsedDate = DateTime.now();
            }

            // Validate date range
            final now = DateTime.now();
            final minDate = DateTime(now.year - 5);
            final maxDate = DateTime(now.year + 1);

            if (parsedDate.isBefore(minDate) || parsedDate.isAfter(maxDate)) {
              parsedDate = now;
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

          points.sort((a, b) => a.date.compareTo(b.date));

          setState(() {
            _courseData = CourseAttendanceData(
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
              color: _courseColor,
              points: points,
            );
            _isLoading = false;
          });
        } else {
          throw Exception('No course data found');
        }
      } else {
        throw Exception(response?['error']?.toString() ??
            'Failed to fetch attendance data');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
          _courseData = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 500,
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
            color: FlutterFlowTheme.of(context).alternate.withOpacity(0.2),
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
                  .withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: FlutterFlowTheme.of(context).alternate.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                Expanded(
                  flex: 3,
                  child: _buildChart(),
                ),
                const SizedBox(height: 20),
                if (_courseData != null) _buildCourseSummaryCard(),
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
              style: FlutterFlowTheme.of(context).headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: FlutterFlowTheme.of(context).primaryText,
                      ) ??
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            if (_courseData != null)
              Text(
                _courseData!.courseName,
                style: FlutterFlowTheme.of(context).bodyMedium?.copyWith(
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontWeight: FontWeight.w500,
                        ) ??
                    const TextStyle(fontSize: 14),
              ),
          ],
        ),
        if (_isLoading)
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
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
    // Show course selection prompt if no course is selected or course ID is null/empty
    if (!_isValidCourseId()) {
      return _buildCourseSelectionPrompt();
    }

    if (_isLoading) {
      return _buildLoadingState();
    }

    if (_error != null) {
      return _buildErrorState();
    }

    if (_courseData == null || _courseData!.points.isEmpty) {
      return _buildEmptyState();
    }

    // Safe tooltip behavior check
    final tooltipBehavior = _tooltipBehavior;
    if (tooltipBehavior == null) {
      return _buildLoadingState();
    }

    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate.withOpacity(0.3),
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
                fontWeight: FontWeight.w500,
              ),
            ),
            labelStyle: TextStyle(
              color: FlutterFlowTheme.of(context).secondaryText,
              fontSize: 10,
            ),
            majorGridLines: MajorGridLines(
              color: FlutterFlowTheme.of(context).alternate.withOpacity(0.3),
            ),
            axisLine: AxisLine(
              color: FlutterFlowTheme.of(context).alternate.withOpacity(0.5),
            ),
            minimum: _getMinDate(),
            maximum: _getMaxDate(),
          ),
          primaryYAxis: NumericAxis(
            title: AxisTitle(
              text: 'Attendance %',
              textStyle: TextStyle(
                color: FlutterFlowTheme.of(context).secondaryText,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            labelStyle: TextStyle(
              color: FlutterFlowTheme.of(context).secondaryText,
              fontSize: 10,
            ),
            minimum: 0,
            maximum: 100,
            interval: 20,
            majorGridLines: MajorGridLines(
              color: FlutterFlowTheme.of(context).alternate.withOpacity(0.3),
            ),
            axisLine: AxisLine(
              color: FlutterFlowTheme.of(context).alternate.withOpacity(0.5),
            ),
          ),
          tooltipBehavior: tooltipBehavior,
          plotAreaBorderColor:
              FlutterFlowTheme.of(context).alternate.withOpacity(0.2),
          backgroundColor: Colors.transparent,
          series: [
            SplineSeries<AttendancePoint, DateTime>(
              dataSource: _courseData!.points,
              xValueMapper: (AttendancePoint point, _) => point.date,
              yValueMapper: (AttendancePoint point, _) => point.percentage,
              name: _courseData!.courseName,
              color: _courseColor,
              width: 3,
              markerSettings: MarkerSettings(
                isVisible: true,
                color: _courseColor,
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
            ),
          ],
        ),
      ),
    );
  }

  DateTime? _getMinDate() {
    if (_courseData?.points.isEmpty ?? true) return null;
    final dates = _courseData!.points.map((p) => p.date).toList();
    dates.sort();
    return dates.first.subtract(const Duration(days: 7));
  }

  DateTime? _getMaxDate() {
    if (_courseData?.points.isEmpty ?? true) return null;
    final dates = _courseData!.points.map((p) => p.date).toList();
    dates.sort();
    return dates.last.add(const Duration(days: 7));
  }

  Widget _buildCourseSelectionPrompt() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color:
              FlutterFlowTheme.of(context).primaryBackground.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: FlutterFlowTheme.of(context).alternate.withOpacity(0.3),
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
                    FlutterFlowTheme.of(context).primary.withOpacity(0.2),
                    FlutterFlowTheme.of(context).secondary.withOpacity(0.2),
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
              style: FlutterFlowTheme.of(context).titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: FlutterFlowTheme.of(context).primaryText,
                      ) ??
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Please select a course from the dropdown above to view your attendance insights and track your academic progress! 📈✨',
              style: FlutterFlowTheme.of(context).bodyMedium?.copyWith(
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ) ??
                  const TextStyle(fontSize: 14),
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
          color:
              FlutterFlowTheme.of(context).primaryBackground.withOpacity(0.7),
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
              '✨ Loading your attendance data...',
              style: FlutterFlowTheme.of(context).bodyMedium?.copyWith(
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontWeight: FontWeight.w500,
                      ) ??
                  const TextStyle(fontSize: 14),
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
          color:
              FlutterFlowTheme.of(context).primaryBackground.withOpacity(0.7),
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
                color: FlutterFlowTheme.of(context).error.withOpacity(0.1),
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
              '🔄 Something went wrong',
              style: FlutterFlowTheme.of(context).titleMedium?.copyWith(
                        color: FlutterFlowTheme.of(context).error,
                        fontWeight: FontWeight.w600,
                      ) ??
                  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: FlutterFlowTheme.of(context).error,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Unable to load attendance data. Please try again.',
              style: FlutterFlowTheme.of(context).bodySmall?.copyWith(
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ) ??
                  const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _fetchAttendanceData,
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: FlutterFlowTheme.of(context).primary,
                foregroundColor: FlutterFlowTheme.of(context).primaryBackground,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
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
          color:
              FlutterFlowTheme.of(context).primaryBackground.withOpacity(0.7),
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
                color:
                    FlutterFlowTheme.of(context).secondaryText.withOpacity(0.1),
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
              '📊 No attendance data yet',
              style: FlutterFlowTheme.of(context).titleMedium?.copyWith(
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontWeight: FontWeight.w600,
                      ) ??
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'Start attending classes to see your progress here.',
              style: FlutterFlowTheme.of(context).bodySmall?.copyWith(
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ) ??
                  const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseSummaryCard() {
    final courseData = _courseData;
    if (courseData == null) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            FlutterFlowTheme.of(context).primaryBackground.withOpacity(0.9),
            FlutterFlowTheme.of(context).secondaryBackground.withOpacity(0.9),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: _courseColor.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: _courseColor.withOpacity(0.3),
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
                  .withOpacity(0.7),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: _courseColor,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: _courseColor.withOpacity(0.4),
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
                        style: FlutterFlowTheme.of(context)
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ) ??
                            const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(
                      'Attendance',
                      '${courseData.currentAttendance.toStringAsFixed(1)}%',
                      _getAttendanceColor(courseData.currentAttendance),
                    ),
                    _buildStatItem(
                      'Classes',
                      '${courseData.attendedClasses}/${courseData.totalClasses}',
                      FlutterFlowTheme.of(context).primaryText,
                    ),
                    _buildStatItem(
                      'Status',
                      courseData.attendanceRate,
                      _getStatusColor(courseData.attendanceRate),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color? valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: FlutterFlowTheme.of(context).bodySmall?.copyWith(
                    color: FlutterFlowTheme.of(context).secondaryText,
                    fontWeight: FontWeight.w500,
                  ) ??
              const TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: FlutterFlowTheme.of(context).titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color:
                        valueColor ?? FlutterFlowTheme.of(context).primaryText,
                  ) ??
              TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: valueColor ?? FlutterFlowTheme.of(context).primaryText,
              ),
        ),
      ],
    );
  }

  Color _getAttendanceColor(double percentage) {
    if (percentage >= 90) return const Color(0xFF059669);
    if (percentage >= 80) return const Color(0xFF2563EB);
    if (percentage >= 70) return const Color(0xFFD97706);
    return const Color(0xFFDC2626);
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'excellent':
        return const Color(0xFF059669);
      case 'good':
        return const Color(0xFF2563EB);
      case 'warning':
        return const Color(0xFFD97706);
      case 'below minimum':
        return const Color(0xFFDC2626);
      default:
        return FlutterFlowTheme.of(context).secondaryText ?? Colors.grey;
    }
  }
}

// Data models remain the same
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
