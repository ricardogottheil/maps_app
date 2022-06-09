import 'package:flutter/material.dart';

class StartMarkerPainter extends CustomPainter {
  final int minutes;
  final String destination;

  StartMarkerPainter({
    required this.minutes,
    required this.destination,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final blackPaint = Paint()..color = Colors.black;
    final whitePaint = Paint()..color = Colors.white;

    const double circleBlackRadius = 20;
    const double circleWhiteRadius = 7;

    // Circle black
    canvas.drawCircle(
      Offset(circleBlackRadius, size.height - circleBlackRadius),
      circleBlackRadius,
      blackPaint,
    );

    // Circle white
    canvas.drawCircle(
      Offset(circleBlackRadius, size.height - circleBlackRadius),
      circleWhiteRadius,
      whitePaint,
    );

    // Draw white cube
    final path = Path();
    path.moveTo(40, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(40, 100);

    // Shadow
    canvas.drawShadow(path, Colors.black, 10, false);

    // Draw white box
    canvas.drawPath(path, whitePaint);

    // black box
    const blackBox = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(blackBox, blackPaint);

    // Texts
    // Number Minutes
    final numberMinutesSpan = TextSpan(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w400,
      ),
      text: minutes.toString(),
    );

    final numberMinutesPainter = TextPainter(
      text: numberMinutesSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: 70,
        maxWidth: 70,
      );

    numberMinutesPainter.paint(
      canvas,
      const Offset(
        40,
        30,
      ),
    );

    // Number text
    const textMinutesSpan = TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      text: 'Min(s)',
    );

    final textMinutesPainter = TextPainter(
      text: textMinutesSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: 70,
        maxWidth: 70,
      );

    textMinutesPainter.paint(
      canvas,
      const Offset(
        40,
        65,
      ),
    );

    // Destination text
    final destinationTextSpan = TextSpan(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      text: destination,
    );

    final destinationTextPainter = TextPainter(
      maxLines: 2,
      ellipsis: '...',
      text: destinationTextSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    )..layout(
        minWidth: size.width - 135,
        maxWidth: size.width - 135,
      );

    double offsetY = (destination.length > 25) ? 35 : 48;

    destinationTextPainter.paint(
      canvas,
      Offset(
        120,
        offsetY,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
