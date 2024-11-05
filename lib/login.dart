import 'package:flutter/material.dart';
import 'Dashboard.dart';

class ResponsiveLoginForm extends StatefulWidget {
  @override
  _ResponsiveLoginFormState createState() => _ResponsiveLoginFormState();
}

class _ResponsiveLoginFormState extends State<ResponsiveLoginForm>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text(
              'Login to Get Started',
              style: TextStyle(
                fontFamily: 'Poppins-Regular',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 19, 19, 73),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/ai.png',
                          fit: BoxFit.cover,
                          width: 500,
                          height: 800,
                          // Increased size of the image
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color.fromARGB(255, 19, 19, 73),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          TextField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color.fromARGB(255, 19, 19, 73),
                              ),
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 19, 19, 73),
                              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),

                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              _message,
              style: TextStyle(
                color: _message == 'Login successful'
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login() {
    if (_emailController.text.trim().toLowerCase() == 'admin' &&
        _passwordController.text == 'admin') {
      setState(() {
        _message = 'Login successful';
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    } else {
      setState(() {
        _message = 'Invalid credentials';
      });
    }
  }
}