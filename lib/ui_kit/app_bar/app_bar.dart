import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 100,
          color: Colors.blue,
          child: const Center(
            child: Text(
              'Custom AppBar',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Positioned(
          right: -40,
          top: 0,
          child: CustomPaint(
            size: const Size(100, 100),
            painter: DripPainter(),
          ),
        ),
        Positioned(
          top: 30,
          left: 0,
          right: 0,
          height: 30,
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }
}

class DripPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final ovalPath1 = Path()
      ..addOval(Rect.fromCircle(center: Offset(50, 30), radius: 30));

    final ovalPath2 = Path()
      ..addOval(Rect.fromCircle(center: Offset(50, 70), radius: 30));

    final arcPath = Path()
      ..moveTo(20, 30)
      ..quadraticBezierTo(50, 0, 80, 30);

    canvas.drawPath(ovalPath1, paint);
    canvas.drawPath(ovalPath2, paint);
    canvas.drawPath(arcPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
