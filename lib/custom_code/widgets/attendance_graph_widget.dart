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
import 'package:intl/intl.dart';

// Data model for attendance trend
class AttendanceTrendData {
  final DateTime date;
  final double attendancePercentage;

  AttendanceTrendData(this.date, this.attendancePercentage);
}

// Summary statistics model
class AttendanceSummary {
  final double averageAttendance;
  final double recentAttendance;
  final double trendChange;
  final bool isAboveMinimum;

  AttendanceSummary({
    required this.averageAttendance,
    required this.recentAttendance,
    required this.trendChange,
    required this.isAboveMinimum,
  });
}

class AttendanceGraphWidget extends StatefulWidget {
  const AttendanceGraphWidget({
    super.key,
    this.width,
    this.height,
    required this.userID,
    required this.courseID,
    required this.period,
  });

  final double? width;
  final double? height;
  final String userID;
  final String courseID;
  final String period;

  @override
  State<AttendanceGraphWidget> createState() => _AttendanceGraphWidgetState();
}

class _AttendanceGraphWidgetState extends State<AttendanceGraphWidget>
    with SingleTickerProviderStateMixin {
  List<AttendanceTrendData> attendanceData = [];
  AttendanceSummary? summary;
  bool isLoading = true;
  String? error;
  String courseName = '';
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Check if required parameters are provided
    if (_areRequiredParametersProvided()) {
      _loadAttendanceData();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void didUpdateWidget(AttendanceGraphWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.period != widget.period ||
        oldWidget.courseID != widget.courseID ||
        oldWidget.userID != widget.userID) {
      if (_areRequiredParametersProvided()) {
        _loadAttendanceData();
      } else {
        setState(() {
          attendanceData = [];
          summary = null;
          isLoading = false;
          error = null;
        });
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _areRequiredParametersProvided() {
    return widget.courseID.isNotEmpty &&
        widget.period.isNotEmpty &&
        widget.userID.isNotEmpty;
  }

  DateTime _getStartDate() {
    final now = DateTime.now();
    switch (widget.period) {
      case '7d':
        return now.subtract(const Duration(days: 7));
      case '14d':
        return now.subtract(const Duration(days: 14));
      case '30d':
        return now.subtract(const Duration(days: 30));
      case 'all':
        return now.subtract(const Duration(days: 365)); // Fallback for "all"
      default:
        return now.subtract(const Duration(days: 7));
    }
  }

  Future<void> _loadAttendanceData() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final supabase = SupaFlow.client;
      final startDate = _getStartDate();
      final endDate = DateTime.now();

      // Get course name
      final courseResponse = await supabase
          .from('courseRecords')
          .select('"courseName"')
          .eq('courseID', widget.courseID)
          .single();

      courseName = courseResponse['courseName'] ?? 'Unknown Course';

      // Get attendance data with daily aggregation
      final attendanceResponse =
          await supabase.rpc('get_daily_attendance_percentage', params: {
        'user_id': widget.userID,
        'course_id': widget.courseID,
        'start_date': startDate.toIso8601String(),
        'end_date': endDate.toIso8601String(),
      });

      // Parse the response and create trend data
      final List<AttendanceTrendData> trendData = [];

      if (attendanceResponse is List) {
        for (final record in attendanceResponse) {
          final date = DateTime.parse(record['date']);
          final percentage =
              (record['attendance_percentage'] as num).toDouble();
          trendData.add(AttendanceTrendData(date, percentage));
        }
      }

      // Sort by date
      trendData.sort((a, b) => a.date.compareTo(b.date));

      // Calculate summary statistics
      final summaryStats = _calculateSummary(trendData);

      setState(() {
        attendanceData = trendData;
        summary = summaryStats;
        isLoading = false;
      });

      _animationController.forward();
    } catch (e) {
      setState(() {
        error = 'Unable to load attendance data. Please try again later.';
        isLoading = false;
        attendanceData = [];
        summary = null;
      });
    }
  }

  AttendanceSummary _calculateSummary(List<AttendanceTrendData> data) {
    if (data.isEmpty) {
      return AttendanceSummary(
        averageAttendance: 0.0,
        recentAttendance: 0.0,
        trendChange: 0.0,
        isAboveMinimum: false,
      );
    }

    final average =
        data.map((e) => e.attendancePercentage).reduce((a, b) => a + b) /
            data.length;
    final recent = data.last.attendancePercentage;

    // Calculate trend change (comparing recent vs earlier average)
    double trendChange = 0.0;
    if (data.length > 1) {
      final earlierAverage = data.length > 3
          ? data
                  .take(data.length ~/ 2)
                  .map((e) => e.attendancePercentage)
                  .reduce((a, b) => a + b) /
              (data.length ~/ 2)
          : data.first.attendancePercentage;
      trendChange = recent - earlierAverage;
    }

    return AttendanceSummary(
      averageAttendance: average,
      recentAttendance: recent,
      trendChange: trendChange,
      isAboveMinimum: recent >= 80.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = FlutterFlowTheme.of(context).primary;

    return Container(
      width: widget.width,
      height: widget.height,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          _buildHeader(isDarkMode),

          const SizedBox(height: 20),

          // Chart Section
          Expanded(
            child: !_areRequiredParametersProvided()
                ? _buildEmptyWidget()
                : isLoading
                    ? _buildLoadingIndicator()
                    : error != null
                        ? _buildErrorWidget()
                        : _buildChart(isDarkMode, primaryColor),
          ),

          const SizedBox(height: 20),

          // Summary Card
          if (summary != null && !isLoading && _areRequiredParametersProvided())
            _buildSummaryCard(isDarkMode),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            courseName.isNotEmpty ? courseName : 'Course Attendance',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            _areRequiredParametersProvided()
                ? 'Attendance Trend - ${_getPeriodLabel()}'
                : 'Please provide course and period information',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
          ),
        ],
      ),
    );
  }

  String _getPeriodLabel() {
    switch (widget.period) {
      case '7d':
        return 'Last 7 Days';
      case '14d':
        return 'Last 14 Days';
      case '30d':
        return 'Last 30 Days';
      case 'all':
        return 'All Time';
      default:
        return 'Last 7 Days';
    }
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: FlutterFlowTheme.of(context).primary,
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: FlutterFlowTheme.of(context).secondaryBackground,
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              size: 48,
              color: FlutterFlowTheme.of(context).secondaryText,
            ),
            const SizedBox(height: 16),
            Text(
              'No Data Available',
              style: FlutterFlowTheme.of(context).bodyLarge.override(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please ensure course ID and period are provided',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: FlutterFlowTheme.of(context).secondaryText,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: FlutterFlowTheme.of(context).secondaryBackground,
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: FlutterFlowTheme.of(context).warning,
            ),
            const SizedBox(height: 16),
            Text(
              'Service Temporarily Unavailable',
              style: FlutterFlowTheme.of(context).bodyLarge.override(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please try again in a moment',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: FlutterFlowTheme.of(context).secondaryText,
                  ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                if (_areRequiredParametersProvided()) {
                  _loadAttendanceData();
                }
              },
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: FlutterFlowTheme.of(context).primary,
                foregroundColor: FlutterFlowTheme.of(context).info,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart(bool isDarkMode, Color primaryColor) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        padding: const EdgeInsets.all(16),
        child: SfCartesianChart(
          primaryXAxis: DateTimeAxis(
            dateFormat: DateFormat('MM/dd'),
            intervalType: DateTimeIntervalType.days,
            majorGridLines: const MajorGridLines(width: 0),
            axisLine: const AxisLine(width: 0),
            labelStyle: TextStyle(
              color: FlutterFlowTheme.of(context).secondaryText,
              fontSize: 12,
            ),
          ),
          primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: 100,
            interval: 20,
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(width: 0),
            labelFormat: '{value}%',
            labelStyle: TextStyle(
              color: FlutterFlowTheme.of(context).secondaryText,
              fontSize: 12,
            ),
            majorGridLines: MajorGridLines(
              width: 1,
              color: FlutterFlowTheme.of(context).alternate,
            ),
          ),
          tooltipBehavior: TooltipBehavior(
            enable: true,
            format: 'point.x: point.y%',
            borderWidth: 0,
            color: FlutterFlowTheme.of(context).secondaryBackground,
            textStyle: TextStyle(
              color: FlutterFlowTheme.of(context).primaryText,
            ),
          ),
          series: <CartesianSeries>[
            SplineAreaSeries<AttendanceTrendData, DateTime>(
              dataSource: attendanceData,
              xValueMapper: (data, _) => data.date,
              yValueMapper: (data, _) => data.attendancePercentage,
              splineType: SplineType.natural,
              color: primaryColor.withValues(alpha: 0.3),
              borderColor: primaryColor,
              borderWidth: 2,
              animationDuration: 1000,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  primaryColor.withValues(alpha: 0.4),
                  primaryColor.withValues(alpha: 0.1),
                ],
              ),
            ),
          ],
          annotations: <CartesianChartAnnotation>[
            CartesianChartAnnotation(
              widget: Container(
                width: double.infinity,
                height: 1,
                decoration: BoxDecoration(
                  color:
                      FlutterFlowTheme.of(context).error.withValues(alpha: 0.6),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).error,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              coordinateUnit: CoordinateUnit.point,
              x: attendanceData.isNotEmpty
                  ? attendanceData.first.date
                  : DateTime.now(),
              y: 80,
              horizontalAlignment: ChartAlignment.far,
              verticalAlignment: ChartAlignment.center,
            ),
            CartesianChartAnnotation(
              widget: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color:
                      FlutterFlowTheme.of(context).error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context)
                        .error
                        .withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  'Min: 80%',
                  style: TextStyle(
                    color: FlutterFlowTheme.of(context).error,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              coordinateUnit: CoordinateUnit.point,
              x: attendanceData.isNotEmpty
                  ? attendanceData.first.date
                  : DateTime.now(),
              y: 80,
              horizontalAlignment: ChartAlignment.near,
              verticalAlignment: ChartAlignment.near,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(bool isDarkMode) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              color:
                  FlutterFlowTheme.of(context).alternate.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Summary',
              style: FlutterFlowTheme.of(context).bodyLarge.override(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem(
                  'Average',
                  '${summary!.averageAttendance.toStringAsFixed(1)}%',
                  Icons.trending_up,
                  isDarkMode,
                ),
                _buildSummaryItem(
                  'Recent',
                  '${summary!.recentAttendance.toStringAsFixed(1)}%',
                  Icons.today,
                  isDarkMode,
                  statusColor: summary!.isAboveMinimum
                      ? FlutterFlowTheme.of(context).success
                      : FlutterFlowTheme.of(context).error,
                ),
                _buildSummaryItem(
                  'Trend',
                  '${summary!.trendChange >= 0 ? '+' : ''}${summary!.trendChange.toStringAsFixed(1)}%',
                  summary!.trendChange >= 0
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                  isDarkMode,
                  trendColor: summary!.trendChange >= 0
                      ? FlutterFlowTheme.of(context).success
                      : FlutterFlowTheme.of(context).error,
                ),
                _buildSummaryItem(
                  'Status',
                  summary!.isAboveMinimum ? 'Safe' : 'At Risk',
                  summary!.isAboveMinimum ? Icons.check_circle : Icons.warning,
                  isDarkMode,
                  statusColor: summary!.isAboveMinimum
                      ? FlutterFlowTheme.of(context).success
                      : FlutterFlowTheme.of(context).error,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
      String label, String value, IconData icon, bool isDarkMode,
      {Color? trendColor, Color? statusColor}) {
    final displayColor =
        trendColor ?? statusColor ?? FlutterFlowTheme.of(context).secondaryText;

    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            color: displayColor,
            size: 20,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Outfit',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: displayColor,
                ),
            textAlign: TextAlign.center,
          ),
          Text(
            label,
            style: FlutterFlowTheme.of(context).bodySmall.override(
                  fontFamily: 'Outfit',
                  fontSize: 11,
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
