import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlinkingStoryCircle extends StatefulWidget {
  final String photo;
  const BlinkingStoryCircle({required this.photo});

  @override
  _BlinkingStoryCircleState createState() => _BlinkingStoryCircleState();
}

class _BlinkingStoryCircleState extends State<BlinkingStoryCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: SweepGradient(
              colors: [
                Colors.purple.withOpacity(_controller.value),
                Colors.blue.withOpacity(_controller.value),
                Colors.pink.withOpacity(_controller.value),
                Colors.orange.withOpacity(_controller.value),
                Colors.purple.withOpacity(_controller.value),
              ],
              stops: [0.2, 0.4, 0.6, 0.8, 1.0],
            ),
          ),
          child: CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage(widget.photo),
          ),
        );
      },
    );
  }
}
class BlinkingContainer extends StatefulWidget {
  final Widget child;
  const BlinkingContainer({required this.child});

  @override
  _BlinkingContainerState createState() => _BlinkingContainerState();
}

class _BlinkingContainerState extends State<BlinkingContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            gradient: SweepGradient(
              colors: [
                Colors.purple.withOpacity(_controller.value),
                Colors.blue.withOpacity(_controller.value),
                Colors.pink.withOpacity(_controller.value),
                Colors.orange.withOpacity(_controller.value),
                Colors.purple.withOpacity(_controller.value),
              ],
              stops: [0.2, 0.4, 0.6, 0.8, 1.0],
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}
