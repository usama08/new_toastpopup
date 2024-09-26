import 'package:flutter/material.dart';

class CustomMessageAlert extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final double radius;
  final Widget? image;
  final Color shadowColor;
  final double shadowOpacity;
  final TextStyle textStyle;
  final double width;
  final double height;
  final double imageWidth;
  final double imageHeight;
  const CustomMessageAlert({
    super.key,
    required this.message,
    required this.textStyle,
    this.width = 220.0,
    this.height = 99.0,
    this.imageWidth = 30.0,
    this.imageHeight = 30.0,
    this.backgroundColor = Colors.white,
    this.radius = 10.0,
    this.image,
    this.shadowColor = Colors.black,
    this.shadowOpacity = 0.2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(shadowOpacity),
            offset: const Offset(2, 2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (image != null) ...[
            SizedBox(
              width: imageWidth,
              height: imageHeight,
              child: image!,
            ),
            const SizedBox(width: 8),
          ],
          const SizedBox(height: 10),
          Text(
            message,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
