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

import 'dart:math';
import 'package:animated_flip_counter/animated_flip_counter.dart';

class AmplixChangeWidget extends StatefulWidget {
  const AmplixChangeWidget({
    super.key,
    this.width,
    this.height,
    required this.amplix,
    this.fontSize = 32.0,
    this.animationDuration = 800,
  });

  final double? width;
  final double? height;
  final int amplix;
  final double fontSize;
  final int animationDuration;

  @override
  State<AmplixChangeWidget> createState() => _AmplixChangeWidgetState();
}

class _AmplixChangeWidgetState extends State<AmplixChangeWidget>
    with TickerProviderStateMixin {
  // Animation controllers
  late AnimationController _pulseController;
  late AnimationController _particleController;
  late AnimationController _differenceController;
  late AnimationController _glowController;

  // Animations
  late Animation<double> _pulseAnimation;
  late Animation<double> _particleAnimation;
  late Animation<double> _differenceOpacity;
  late Animation<double> _differenceOffset;
  late Animation<double> _glowIntensity;
  late Animation<double> _glowRadius;

  // State variables
  int? _previousScore;
  bool _isInitialized = false;
  Color _changeColor = Colors.transparent;
  int _scoreDifference = 0;
  bool _showEffects = false;
  bool _isLevelUp = false;

  // Level thresholds for enhanced effects
  static const List<int> _levelThresholds = [
    200,
    500,
    1000,
    2000,
    3500,
    5500,
    8000,
    10000,
    13000,
    16000,
    20000
  ];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _initializeAnimations();
    _previousScore = widget.amplix;
    _isInitialized = true;
  }

  void _initializeControllers() {
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _particleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _differenceController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
  }

  void _initializeAnimations() {
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.08,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _particleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _particleController,
      curve: Curves.easeOutCubic,
    ));

    _differenceOpacity = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _differenceController,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
    ));

    _differenceOffset = Tween<double>(
      begin: 0.0,
      end: -32.0,
    ).animate(CurvedAnimation(
      parent: _differenceController,
      curve: Curves.easeOutCubic,
    ));

    _glowIntensity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeOutCubic,
    ));

    _glowRadius = Tween<double>(
      begin: 0.0,
      end: 28.0,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeOutCubic,
    ));

    _setupListeners();
  }

  void _setupListeners() {
    _pulseController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _pulseController.reverse();
      }
    });

    _glowController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _glowController.reverse();
      }
    });

    _particleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _resetState();
      }
    });
  }

  void _resetState() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          _showEffects = false;
          _isLevelUp = false;
          _scoreDifference = 0;
          _changeColor = Colors.transparent;
        });
        _particleController.reset();
      }
    });
  }

  @override
  void didUpdateWidget(covariant AmplixChangeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_isInitialized &&
        widget.amplix != oldWidget.amplix &&
        _previousScore != null &&
        _previousScore != widget.amplix) {
      _handleScoreChange(_previousScore!, widget.amplix);
      _previousScore = widget.amplix;
    }
  }

  bool _checkLevelUp(int fromScore, int toScore) {
    return _levelThresholds
        .any((threshold) => fromScore < threshold && toScore >= threshold);
  }

  void _handleScoreChange(int fromScore, int toScore) {
    final difference = toScore - fromScore;
    if (difference == 0) return;

    setState(() {
      _scoreDifference = difference;
      _isLevelUp = _checkLevelUp(fromScore, toScore);
      _showEffects = difference.abs() >= 5 || _isLevelUp;

      if (_isLevelUp) {
        _changeColor = const Color(0xFFFFD700); // Gold for level up
      } else if (difference > 0) {
        _changeColor = const Color(0xFF4CAF50); // Green for positive
      } else {
        _changeColor = const Color(0xFFFF5252); // Red for negative
      }
    });

    _triggerAnimations();
  }

  void _triggerAnimations() {
    _pulseController.forward(from: 0.0);
    _differenceController.forward(from: 0.0);

    if (_showEffects) {
      _glowController.forward(from: 0.0);
      _particleController.forward(from: 0.0);
    }
  }

  Widget _buildParticleEffect() {
    if (!_showEffects) return const SizedBox.shrink();

    final particleCount = _isLevelUp ? 14 : 7;
    final maxRadius = _isLevelUp ? 62.0 : 38.0;

    return AnimatedBuilder(
      animation: _particleAnimation,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.centerRight,
          children: List.generate(particleCount, (index) {
            final angle = (index * (360 / particleCount)) * (pi / 180);
            final progress = _particleAnimation.value;
            final distance = maxRadius * progress;
            final baseOpacity = (1.0 - progress) * 0.8;
            final size = _isLevelUp ? 7.0 : 4.0;

            // Staggered animation for more dynamic effect
            final staggeredProgress =
                ((progress - (index * 0.025)).clamp(0.0, 1.0));
            final finalOpacity = baseOpacity * staggeredProgress;

            return Transform.translate(
              offset: Offset(
                cos(angle) * distance,
                sin(angle) * distance,
              ),
              child: Opacity(
                opacity: finalOpacity,
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        _changeColor
                            .withAlpha((255 * 0.8 * staggeredProgress).round()),
                        _changeColor.withAlpha(0),
                      ],
                      stops: const [0.0, 1.0],
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildDifferenceIndicator() {
    if (!_isInitialized || _scoreDifference == 0) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _differenceController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _differenceOffset.value),
          child: Opacity(
            opacity: _differenceOpacity.value,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _changeColor.withAlpha((255 * 0.18).round()),
                    _changeColor.withAlpha((255 * 0.10).round()),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _changeColor.withAlpha((255 * 0.32).round()),
                  width: 1,
                ),
              ),
              child: Text(
                '${_scoreDifference > 0 ? '+' : ''}$_scoreDifference',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: widget.fontSize * 0.44,
                  fontWeight: FontWeight.w600,
                  color: _changeColor,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _particleController.dispose();
    _differenceController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsiveFontSize =
        (widget.fontSize * MediaQuery.of(context).textScaleFactor)
            .clamp(20.0, 72.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: widget.width ?? constraints.maxWidth,
          height: widget.height ?? responsiveFontSize * 1.7,
          alignment: Alignment.centerRight,
          child: Stack(
            alignment: Alignment.centerRight,
            clipBehavior: Clip.none,
            children: [
              // Subtle gradient glow effect (no shadows)
              if (_showEffects)
                AnimatedBuilder(
                  animation: _glowController,
                  builder: (context, child) {
                    return Container(
                      width: responsiveFontSize * 2.4,
                      height: responsiveFontSize * 1.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: RadialGradient(
                          colors: [
                            _changeColor.withAlpha(
                                (255 * 0.25 * _glowIntensity.value).round()),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 1.0],
                        ),
                      ),
                    );
                  },
                ),

              // Particle effects (minimal, gradient, no shadow)
              _buildParticleEffect(),

              // Main counter with right padding and smooth animation
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Transform.scale(
                      scale: _pulseAnimation.value,
                      alignment: Alignment.centerRight,
                      child: AnimatedFlipCounter(
                        value: widget.amplix,
                        duration:
                            Duration(milliseconds: widget.animationDuration),
                        curve: Curves.easeInOut,
                        textStyle: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: responsiveFontSize,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: -0.5,
                          height: 1.0,
                        ),
                      ),
                    ),
                  );
                },
              ),

              // Difference indicator (minimal, gradient, no shadow)
              Positioned(
                top: -8,
                right: 0,
                child: _buildDifferenceIndicator(),
              ),
            ],
          ),
        );
      },
    );
  }
}
