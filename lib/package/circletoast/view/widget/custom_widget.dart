import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

class CircularToast {
  static void show(
    BuildContext context, {
    String message = '',
    int countdownSeconds = 10,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    double radius = 50.0,
    double height = 100.0,
    double width = 100.0,
    double? stroke = 3.0,
    TextStyle? textStyle,
    bool useAnimation = true,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => CircularToastMessage(
        message: message,
        countdownSeconds: countdownSeconds,
        backgroundColor: backgroundColor,
        textColor: textColor,
        radius: radius,
        height: height,
        width: width,
        textStyle: textStyle ??
            const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
        useAnimation: useAnimation,
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(
        Duration(seconds: countdownSeconds), () => overlayEntry.remove());
  }
}

class CircularToastMessage extends StatefulWidget {
  final String message;
  final int countdownSeconds;
  final Color backgroundColor;
  final Color textColor;
  final double radius;
  final double height;
  final double width;
  final double? stroke;
  final TextStyle textStyle;
  final bool useAnimation; // New parameter to toggle animations

  const CircularToastMessage({
    super.key,
    required this.message,
    required this.countdownSeconds,
    required this.backgroundColor,
    required this.textColor,
    required this.radius,
    required this.height,
    required this.width,
    this.stroke,
    required this.textStyle,
    this.useAnimation = true, // Default is true for animation
  });

  @override
  _CircularToastMessageState createState() => _CircularToastMessageState();
}

class _CircularToastMessageState extends State<CircularToastMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late int _remainingSeconds;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  Timer? _timer; // Timer for manual countdown when animation is off

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.countdownSeconds;

    if (widget.useAnimation) {
      _controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: widget.countdownSeconds),
      )..addListener(() {
          setState(() {
            _remainingSeconds = (widget.countdownSeconds -
                    (_controller.value * widget.countdownSeconds))
                .round();
          });
        });

      _scaleAnimation =
          Tween<double>(begin: 0.4, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.slowMiddle,
      ));

      _fadeAnimation =
          Tween<double>(begin: 0.4, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ));

      _controller.forward();
    } else {
      // Manually update countdown when animation is off
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_remainingSeconds > 0) {
          setState(() {
            _remainingSeconds--;
          });
        } else {
          timer.cancel();
        }
      });
    }
  }

  @override
  void dispose() {
    if (widget.useAnimation) {
      _controller.dispose();
    } else {
      _timer?.cancel(); // Cancel the timer if animation is off
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 2 - widget.height / 2,
      left: MediaQuery.of(context).size.width / 2 - widget.width / 2,
      child: widget.useAnimation
          ? FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: _buildToastContent(),
              ),
            )
          : _buildToastContent(), // Directly show without animation
    );
  }

  Widget _buildToastContent() {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              painter: CircleProgressPainter(
                progress: widget.useAnimation
                    ? _controller.value
                    : (_remainingSeconds / widget.countdownSeconds),
                color: widget.textColor,
                stroke: widget.stroke, // Pass the stroke value here
              ),
              child: SizedBox(
                width: widget.width,
                height: widget.height,
              ),
            ),
            Text(
              '$_remainingSeconds',
              style: widget.textStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class CircleProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double? stroke; // Nullable stroke

  CircleProgressPainter({
    required this.progress,
    required this.color,
    this.stroke,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Use a default stroke width if null
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke ?? 3.0; // Default to 3.0 if stroke is null

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius =
        math.min(size.width / 2, size.height / 2) - paint.strokeWidth / 2;

    // Draw the arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CircleProgressPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
