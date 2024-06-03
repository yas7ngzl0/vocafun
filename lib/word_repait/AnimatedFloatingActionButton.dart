import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedFloatingActionButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isExpanded;

  const AnimatedFloatingActionButton({
    required this.onPressed,
    required this.isExpanded,
  });

  @override
  _AnimatedFloatingActionButtonState createState() =>
      _AnimatedFloatingActionButtonState();
}

class _AnimatedFloatingActionButtonState
    extends State<AnimatedFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant AnimatedFloatingActionButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value * -3.14 / 2, // 180 derece (pi) döndürme
          child: FloatingActionButton(
            onPressed: widget.onPressed,
            tooltip: 'Create',
            child: Icon(Icons.arrow_downward, size: 40),
            backgroundColor: Colors.white,
          ),
        );
      },
    );
  }
}