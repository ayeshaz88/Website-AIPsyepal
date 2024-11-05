import 'package:flutter/material.dart';
import 'package:flutter_web/DeletePatient.dart';
import 'package:flutter_web/GetStarted.dart';
import 'package:flutter_web/ViewFeedback.dart';
import 'UserList.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // Always return false to prevent app from closing
      },
      child: Scaffold(
        backgroundColor: Colors.white, // Dark blue color
        appBar: AppBar(
          title: const Text('Admin Panel', style: TextStyle(
            fontFamily: 'Poppins-Regular',
            color: Colors.white
          ),),
          backgroundColor: const Color.fromARGB(255, 19, 19, 73), // Light blue color
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white,),
              onPressed: () {
                // Navigate to authentication UI screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GetStartedPage(),
                  ),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const UserList()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: _buildRoundedRectangleContainer(
                            text: 'List of Patients',
                            icon: Icons.account_circle,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ViewFeedback()));
                        },
                        child: _buildRoundedRectangleContainer(
                          text: 'View Feedback',
                          icon: Icons.feedback,
                        ),
                      ),

                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const DeletePatient()));
                        },
                        child: _buildRoundedRectangleContainer(
                          text: 'Delete Patient',
                          icon: Icons.no_accounts,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              // Add some space between containers and image
              Expanded(
                child: Image.asset(
                  'assets/images/lp_image.png', // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedRectangleContainer(
      {required String text, required IconData icon}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 19, 19, 73),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      width: double.infinity,
      height: 140,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50,
            color: Colors.white, // Icon color
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Poppins-Regular',
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}