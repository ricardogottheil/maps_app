import 'package:flutter/material.dart';

class EndMarkerPainter extends CustomPainter {
  final int kilometers;
  final String destination;

  EndMarkerPainter({
    required this.kilometers,
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
      Offset(size.width * 0.5, size.height - circleBlackRadius),
      circleBlackRadius,
      blackPaint,
    );

    // Circle white
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height - circleBlackRadius),
      circleWhiteRadius,
      whitePaint,
    );

    // Draw white cube
    final path = Path();
    path.moveTo(10, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(10, 100);

    // Shadow
    canvas.drawShadow(path, Colors.black, 10, false);

    // Draw white box
    canvas.drawPath(path, whitePaint);

    // black box
    const blackBox = Rect.fromLTWH(10, 20, 70, 80);
    canvas.drawRect(blackBox, blackPaint);

    // Texts
    // Number Minutes
    final numberMinutesSpan = TextSpan(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w400,
      ),
      text: kilometers.toString(),
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
        10,
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
      text: 'KM(s)',
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
        10,
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
        minWidth: size.width - 95,
        maxWidth: size.width - 95,
      );

    double offsetY = (destination.length > 25) ? 35 : 48;

    destinationTextPainter.paint(
      canvas,
      Offset(
        90,
        offsetY,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
