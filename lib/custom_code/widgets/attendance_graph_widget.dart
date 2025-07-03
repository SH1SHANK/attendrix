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

// Data models
class AttendancePoint {
  final DateTime date;
  final double percentage;
  final int attendedClasses;
  final int totalClasses;
  AttendancePoint({
    required this.date,
    required this.percentage,
    required this.attendedClasses,
    required this.totalClasses,
  });
}

class CourseAttendanceData {
  final double currentAttendance;
  final int attendedClasses;
  final int totalClasses;
  final List<AttendancePoint> points;
  CourseAttendanceData({
    required this.currentAttendance,
    required this.attendedClasses,
    required this.totalClasses,
    required this.points,
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

  final String userID;
  final String courseID;
  final String period;
  final double? width;
  final double? height;

  @override
  State<AttendanceGraphWidget> createState() => _AttendanceGraphWidgetState();
}

class _AttendanceGraphWidgetState extends State<AttendanceGraphWidget>
    with SingleTickerProviderStateMixin {
  CourseAttendanceData? _data;
  bool _isLoading = false;
  String? _error;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    )..repeat();
    _fetchAttendanceData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _fetchAttendanceData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final response = await SupaFlow.client.rpc(
        'get_single_course_attendance_with_padding',
        params: {
          'p_user_id': widget.userID,
          'p_course_id': widget.courseID,
          'p_period': widget.period,
        },
      );
      if (response == null || response is! List) {
        throw Exception('No data');
      }
      List<AttendancePoint> points = [];
      int attended = 0, total = 0;
      for (final row in response) {
        final date = DateTime.parse(row['class_date']);
        attended = row['attended_classes'] ?? attended;
        total = row['total_classes'] ?? total;
        final percent = row['cumulative_percent']?.toDouble() ?? 0;
        points.add(AttendancePoint(
          date: date,
          percentage: percent,
          attendedClasses: attended,
          totalClasses: total,
        ));
      }
      setState(() {
        _data = CourseAttendanceData(
          currentAttendance: points.isNotEmpty ? points.last.percentage : 0,
          attendedClasses: points.isNotEmpty ? points.last.attendedClasses : 0,
          totalClasses: points.isNotEmpty ? points.last.totalClasses : 0,
          points: points,
        );
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  List<AttendancePoint> _minAttendanceLine() {
    if (_data == null || _data!.points.isEmpty) return [];
    return [
      AttendancePoint(
        date: _data!.points.first.date,
        percentage: 80,
        attendedClasses: 0,
        totalClasses: 0,
      ),
      AttendancePoint(
        date: _data!.points.last.date,
        percentage: 80,
        attendedClasses: 0,
        totalClasses: 0,
      ),
    ];
  }

  List<AttendancePoint> _reducePoints(List<AttendancePoint> points) {
    if (widget.period == '30d' || widget.period == '90d') {
      return [
        for (int i = 0; i < points.length; i += 2) points[i],
        if (points.length % 2 == 0) points.last
      ];
    }
    return points;
  }

  Widget _buildShimmerText(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: [
                theme.primary,
                theme.secondary,
                theme.primary,
              ],
              stops: [
                (_controller.value - 0.3).clamp(0.0, 1.0),
                _controller.value,
                (_controller.value + 0.3).clamp(0.0, 1.0),
              ],
            ).createShader(bounds);
          },
          child: Text(
            'Getting your attendance data…',
            style: theme.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 1.1,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final isBelowMin =
        _data?.currentAttendance != null && _data!.currentAttendance < 80;

    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 420,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.alternate.withOpacity(0.07),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: theme.primaryBackground.withAlpha((0.85 * 255).toInt()),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isBelowMin
                    ? Colors.amber.withAlpha((0.5 * 255).toInt())
                    : theme.alternate.withAlpha((0.12 * 255).toInt()),
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Attendance Trend',
                        style: theme.titleLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (_isLoading) _buildShimmerText(context),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (_error != null)
                    Center(
                      child: Text(
                        _error!,
                        style: theme.bodyMedium.copyWith(
                          color: theme.error,
                        ),
                      ),
                    ),
                  if (!_isLoading && _data != null)
                    Expanded(
                      child: SfCartesianChart(
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        primaryXAxis: DateTimeAxis(
                          intervalType: DateTimeIntervalType.days,
                          interval:
                              widget.period == '30d' || widget.period == '90d'
                                  ? 2
                                  : 1,
                          dateFormat:
                              widget.period == '7d' || widget.period == '14d'
                                  ? DateFormat('EEE')
                                  : DateFormat('dd MMM'),
                          majorGridLines: const MajorGridLines(width: 0.2),
                          axisLine: const AxisLine(width: 0.5),
                        ),
                        primaryYAxis: NumericAxis(
                          minimum: 0,
                          maximum: 100,
                          interval: 10,
                          majorGridLines: const MajorGridLines(width: 0.1),
                          axisLine: const AxisLine(width: 0.5),
                          title: AxisTitle(text: 'Attendance (%)'),
                        ),
                        series: <CartesianSeries>[
                          AreaSeries<AttendancePoint, DateTime>(
                            dataSource: _reducePoints(_data!.points),
                            xValueMapper: (AttendancePoint p, _) => p.date,
                            yValueMapper: (AttendancePoint p, _) =>
                                p.percentage,
                            color: isBelowMin
                                ? Colors.amber.withAlpha((0.3 * 255).toInt())
                                : theme.primary.withAlpha((0.3 * 255).toInt()),
                            borderColor:
                                isBelowMin ? Colors.amber : theme.primary,
                            borderWidth: 2,
                            markerSettings:
                                const MarkerSettings(isVisible: true),
                            animationDuration: 1200,
                          ),
                          LineSeries<AttendancePoint, DateTime>(
                            dataSource: _minAttendanceLine(),
                            xValueMapper: (AttendancePoint p, _) => p.date,
                            yValueMapper: (AttendancePoint p, _) =>
                                p.percentage,
                            color: Colors.amber,
                            dashArray: const <double>[8, 5],
                            width: 2,
                            name: 'Minimum 80%',
                            markerSettings:
                                const MarkerSettings(isVisible: false),
                          ),
                        ],
                        legend: Legend(isVisible: false),
                        tooltipBehavior: TooltipBehavior(enable: true),
                      ),
                    ),
                  if (!_isLoading && _data != null)
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 16),
                      decoration: BoxDecoration(
                        color: isBelowMin
                            ? Colors.amber.withAlpha((0.18 * 255).toInt())
                            : theme.secondaryBackground
                                .withAlpha((0.7 * 255).toInt()),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isBelowMin
                              ? Colors.amber
                              : theme.alternate.withAlpha((0.15 * 255).toInt()),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isBelowMin
                                ? Icons.warning_amber_rounded
                                : Icons.check_circle_rounded,
                            color: isBelowMin ? Colors.amber : Colors.green,
                            size: 26,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Current Attendance',
                                  style: theme.bodyMedium,
                                ),
                                Text(
                                  '${_data!.currentAttendance.toStringAsFixed(1)}%',
                                  style: theme.titleLarge.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: isBelowMin
                                        ? Colors.amber[900]
                                        : Colors.green[800],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${_data!.attendedClasses}/${_data!.totalClasses} Classes',
                                style: theme.bodyMedium,
                              ),
                              Text(
                                isBelowMin
                                    ? 'Below minimum (80%)'
                                    : 'Above minimum (80%)',
                                style: theme.bodyMedium.copyWith(
                                  color: isBelowMin
                                      ? Colors.amber[900]
                                      : Colors.green[800],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
