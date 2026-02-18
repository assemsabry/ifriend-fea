import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ifriend_app/features/new/config/themes/app_colors.dart';

class StylishCircularProgress extends StatefulWidget {
  final double? size;
  final Color color;
  final double? strokeWidth;

  const StylishCircularProgress({
    super.key,
    this.size,
    this.color = AppColors.primary,
    this.strokeWidth,
  });

  @override
  _StylishCircularProgressState createState() =>
      _StylishCircularProgressState();
}

class _StylishCircularProgressState extends State<StylishCircularProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get responsive size based on screen
    final screenWidth = MediaQuery.of(context).size.width;
    double effectiveSize = widget.size ?? 80.0;

    // Adjust size for different screens
    if (screenWidth < 768) {
      effectiveSize = widget.size ?? 60.0;
    } else if (screenWidth >= 768 && screenWidth < 1024) {
      effectiveSize = widget.size ?? 70.0;
    } else {
      effectiveSize = widget.size ?? 80.0;
    }

    // Calculate stroke width proportionally
    final effectiveStrokeWidth = widget.strokeWidth ?? (effectiveSize / 13.33);

    return Center(
      child: SizedBox(
        width: effectiveSize,
        height: effectiveSize,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: CircularRingsPainter(
                progress: _controller.value,
                color: widget.color,
                strokeWidth: effectiveStrokeWidth,
              ),
            );
          },
        ),
      ),
    );
  }
}

class CircularRingsPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  CircularRingsPainter({
    required this.progress,
    required this.color,
    this.strokeWidth = 6.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double radius = size.width / 2;
    final double baseOffset = strokeWidth;
    final double ringGap = strokeWidth * 1.5;

    // Outer ring
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(radius, radius),
        radius: radius - baseOffset,
      ),
      progress * 2 * pi,
      pi / 2,
      false,
      paint,
    );

    // Middle ring
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(radius, radius),
        radius: radius - baseOffset - ringGap,
      ),
      -progress * 2 * pi,
      pi / 2,
      false,
      paint,
    );

    // Inner ring
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(radius, radius),
        radius: radius - baseOffset - (ringGap * 2),
      ),
      progress * 2 * pi,
      pi / 2,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
