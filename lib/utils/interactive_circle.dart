import 'package:flutter/material.dart';
import 'dart:math';

class InteractiveCircle extends StatelessWidget {
  final int segments;
  final double size;
  final Function(int) onTap;

  InteractiveCircle({
    required this.segments,
    required this.size,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [];

    // Custom painted circle as the base
    stackChildren.add(
      CustomPaint(
        size: Size(size, size),
        painter: CirclePainter(segments),
      ),
    );
    stackChildren.add(
      Container(
        // Small white circle in the center

        width: size / 1.65,
        height: size / 1.65,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );

    // Generate interactive segments
    double segmentAngle = 2 * pi / segments;
    for (int i = 0; i < segments; i++) {
      stackChildren.add(
        Positioned.fill(
          child: Transform.rotate(
            angle: i * segmentAngle,
            child: Align(
              alignment: Alignment.topCenter,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(40),
                  onTap: () => onTap(i + 1),
                  splashColor: Colors.white.withOpacity(0.9),
                  child: ClipRRect(
                    // borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: size / 3.5,
                      height: size / 5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: stackChildren,
    );
  }
}

class CirclePainter extends CustomPainter {
  final int segments;

  CirclePainter(this.segments);

  @override
  void paint(Canvas canvas, Size size) {
    final paintFill = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final paintStroke = Paint()
      ..color = Colors.white
      ..strokeWidth = size.width / 100
      ..style = PaintingStyle.stroke;

    double segmentAngle = 2 * pi / segments;

    // Rotate the canvas by 45 degrees (pi/4 radians)
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(pi / 2.67);
    canvas.translate(-size.width / 2, -size.height / 2);

    for (int i = 0; i < segments; i++) {
      final path = Path();
      path.moveTo(size.width / 2, size.height / 2);
      path.arcTo(
          Rect.fromCenter(
              center: Offset(size.width / 2, size.height / 2),
              width: size.width,
              height: size.height),
          i * segmentAngle,
          segmentAngle,
          false);
      path.close();
      canvas.drawPath(path, paintFill); // Fill the segment with black
      canvas.drawPath(
          path, paintStroke); // Draw white stroke around the segment
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => false;
}
