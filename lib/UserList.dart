import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> with SingleTickerProviderStateMixin {
  List<UserData> userList = []; // List to store user data
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    getData(); // Fetch data when the widget initializes

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Start animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose animation controller
    super.dispose();
  }

  Future<void> getData() async {
    try {
      // Get the collection reference
      CollectionReference users = FirebaseFirestore.instance.collection('users');

      // Get documents from the collection
      QuerySnapshot querySnapshot = await users.get();

      // Loop through documents and extract userName and userEmail
      List<UserData> usersList = []; // Temporary list to store user data

      querySnapshot.docs.forEach((doc) {
        String userName = doc['userName'];
        String userEmail = doc['userEmail'];

        // Add user data to the temporary list
        usersList.add(UserData(name: userName, email: userEmail));
      });

      // Update the state with the new user list
      setState(() {
        userList = usersList;
      });
    } catch (e) {
      print('Error retrieving data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User List',
          style: TextStyle(color: Colors.white,
            fontFamily: 'Poppins-Regular',
          ), // Text color
        ),
        backgroundColor: const Color.fromARGB(255, 19, 19, 73), // Appbar color
      ),
      body: Stack(
        children: [
          AnimatedSwitcher( // Animated transition for the list
            duration: const Duration(milliseconds: 2),
            child: userList.isNotEmpty ? _buildUserList() : _buildLoadingIndicator(),
          ),

           Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),

                child: Image.asset(
                  'assets/images/users.jpg', // Replace with your image path
                  width: 500,
                  height: 500,
                  fit: BoxFit.cover,
                ),
              ),
            ),

          ],
      ),
    );
  }

  Widget _buildUserList() {
    return ListView.builder(
      itemCount: userList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            userList[index].name, // Display name as title
            style: const TextStyle(
              fontFamily: 'Poppins-Regular',
              color: Color.fromARGB(255, 19, 19, 73), // Text color
              fontWeight: FontWeight.bold, // Make the name bold
            ),
          ),
          subtitle: Text(
            userList[index].email, // Display email as subtitle
            style: const TextStyle(
              fontFamily: 'Poppins-Regular',
              color: Color.fromARGB(255, 19, 19, 73), // Text color
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(), // Show loading indicator while fetching data
    );
  }
}

// Model class for user data
class UserData {
  final String name;
  final String email;

  UserData({required this.name, required this.email});
}
