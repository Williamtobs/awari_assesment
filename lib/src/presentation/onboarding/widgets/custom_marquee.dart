import 'package:flutter/material.dart';

enum MarqueeDirection { leftToRight, rightToLeft }

class CustomMarquee extends StatefulWidget {
  const CustomMarquee({
    super.key,
    required this.child,
    this.speed = 50, // pixels per second
    this.spacing = 50,
    this.direction = MarqueeDirection.rightToLeft,
  });

  final Widget child;
  final double speed;
  final double spacing;
  final MarqueeDirection direction;

  @override
  State<CustomMarquee> createState() => _CustomMarqueeState();
}

class _CustomMarqueeState extends State<CustomMarquee>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double _childWidth = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAnimation();
    });
  }

  void _startAnimation() {
    if (_childWidth == 0) return;

    final duration = Duration(
      milliseconds: ((_childWidth + widget.spacing) / widget.speed * 1000)
          .round(),
    );

    _controller.duration = duration;
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return MeasureSize(
            onChange: (size) {
              if (_childWidth != size.width) {
                setState(() {
                  _childWidth = size.width;
                });
                _startAnimation();
              }
            },
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final totalWidth = _childWidth + widget.spacing;

                double offset = (_controller.value * totalWidth) % totalWidth;

                if (widget.direction == MarqueeDirection.rightToLeft) {
                  offset = -offset;
                } else {
                  offset = -(totalWidth - offset);
                }

                return ClipRect(
                  child: OverflowBox(
                    maxWidth: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: Transform.translate(
                      offset: Offset(offset, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          widget.child,
                          SizedBox(width: widget.spacing),
                          widget.child,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class MeasureSize extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onChange;

  const MeasureSize({super.key, required this.child, required this.onChange});

  @override
  State<MeasureSize> createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  Size? oldSize;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = context.size;
      if (size != null && oldSize != size) {
        oldSize = size;
        widget.onChange(size);
      }
    });

    return widget.child;
  }
}
