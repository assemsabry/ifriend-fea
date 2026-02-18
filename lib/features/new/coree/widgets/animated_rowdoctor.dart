import 'package:flutter/material.dart';

class AnimatedRowDoctorScreen extends StatefulWidget {
  const AnimatedRowDoctorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedRowDoctorScreenState createState() =>
      _AnimatedRowDoctorScreenState();
}

class _AnimatedRowDoctorScreenState extends State<AnimatedRowDoctorScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1), // from top
      end: Offset.zero, // to normal position
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(opacity: _fadeAnimation),
    );
  }
}
