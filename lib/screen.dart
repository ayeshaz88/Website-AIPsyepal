import 'package:flutter/material.dart';

class AnimatedImageScreen extends StatefulWidget {
  @override
  _AnimatedImageScreenState createState() => _AnimatedImageScreenState();
}

class _AnimatedImageScreenState extends State<AnimatedImageScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0.7, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome to Our Website',
                    style: TextStyle(
                      fontFamily: 'Poppins-Regular',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Handle button 1 tap
                    },
                    child: const Text('Button 1'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Handle button 2 tap
                    },
                    child: const Text('Button 2'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: SlideTransition(
              position: _offsetAnimation,
              child: Center(
                child: Image.asset(
                  'assets/images/Started.gif', // Replace with your image path
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}