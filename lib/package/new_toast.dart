import 'package:flutter/material.dart';

class CustomToast {
  static void show(
    BuildContext context, {
    required String message,
    ToastPosition position = ToastPosition.top,
    Duration duration = const Duration(seconds: 3),
    Color backgroundColor = Colors.black87,
    Widget? image,
    Color? shadhowColor,
    TextStyle textStyle = const TextStyle(color: Colors.white),
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => ToastMessage(
        message: message,
        position: position,
        backgroundColor: backgroundColor,
        textStyle: textStyle,
        duration: duration,
        image: image,
        shadhowColor: shadhowColor,
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(duration, () => overlayEntry.remove());
  }
}

class ToastMessage extends StatefulWidget {
  final String message;
  final ToastPosition position;
  final Duration duration;
  final Color backgroundColor;
  final Widget? image;
  final TextStyle textStyle;
  final Color? shadhowColor;

  const ToastMessage({
    super.key,
    required this.message,
    required this.position,
    required this.duration,
    required this.backgroundColor,
    this.image,
    this.shadhowColor,
    required this.textStyle,
  });

  @override
  __ToastMessageState createState() => __ToastMessageState();
}

class __ToastMessageState extends State<ToastMessage>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _offsetAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _offsetAnimation = Tween<Offset>(
      begin: _getOffset(),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  Offset _getOffset() {
    switch (widget.position) {
      case ToastPosition.left:
        return const Offset(-1.0, 0.0);
      case ToastPosition.right:
        return const Offset(1.0, 0.0);
      case ToastPosition.top:
      default:
        return const Offset(0.0, -1.0); // Slide down from top
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top:
          widget.position == ToastPosition.top ? 50.0 : null, // Safe top margin
      left: widget.position == ToastPosition.left ? 20.0 : null,
      right: widget.position == ToastPosition.right ? 20.0 : null,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 40),
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 10.0,
              ),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: widget.shadhowColor == null
                        ? Colors.black.withOpacity(0.2)
                        : widget.shadhowColor!,
                    offset: const Offset(2, 4),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Keep the row compact
                children: [
                  if (widget.image != null) ...[
                    SizedBox(width: 40, height: 40, child: widget.image!),
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                    child: Text(
                      widget.message,
                      maxLines: 3, // Limit to 3 lines
                      style: widget.textStyle,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
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

enum ToastPosition {
  top,
  left,
  right,
}
