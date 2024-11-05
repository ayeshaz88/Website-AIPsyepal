import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeletePatient extends StatefulWidget {
  const DeletePatient({Key? key}) : super(key: key);

  @override
  _DeletePatientState createState() => _DeletePatientState();
}

class _DeletePatientState extends State<DeletePatient> {
  List<Map<String, dynamic>> userList = []; // Initialize userList

  @override
  void initState() {
    super.initState();
    getData(); // Fetch data when the widget initializes
  }

  Future<void> getData() async {
    try {
      // Get the collection reference
      CollectionReference users = FirebaseFirestore.instance.collection('users');

      // Get documents from the collection
      QuerySnapshot querySnapshot = await users.get();

      // Loop through documents and extract userName, userEmail, and document ID
      List<Map<String, dynamic>> usersList = []; // Temporary list to store user data

      querySnapshot.docs.forEach((doc) {
        String userName = doc['userName'];
        String userEmail = doc['userEmail'];
        String docId = doc.id;

        // Add user data to the temporary list
        usersList.add({'userName': userName, 'userEmail': userEmail, 'docId': docId});
      });

      // Update the state with the new user list
      setState(() {
        userList = usersList;
      });
    } catch (e) {
      print('Error retrieving data: $e');
    }
  }

  Future<void> deleteUser(String docId) async {
    try {
      // Get the reference to the document to delete
      DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(docId);

      // Show confirmation dialog
      bool confirm = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm Delete", style: TextStyle(
              fontFamily: 'Poppins-Regular',
            ),),
            content: const Text("Are you sure you want to delete this user?",
            style: TextStyle(
              fontFamily: 'Poppins-Regular',
            ),),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Return false when cancel is pressed
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Return true when OK is pressed
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );

      if (confirm == true) {
        // Delete the document if confirmation is true
        await userDoc.delete();

        // Update the UI by fetching data again
        getData();
      }
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 19, 19, 73), // Appbar color
        title: const Text(
          'Delete User',
          style: TextStyle(color: Colors.white,
            fontFamily: 'Poppins-Regular',
          ), // Text color
        ),
      ),
      body: Stack(
        children: [
          AnimatedSwitcher(
            // Animated transition for the list
            duration: const Duration(milliseconds: 2),
            child:
            userList.isNotEmpty ? _buildUserList() : _buildLoadingIndicator(),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Image.asset(
                'assets/images/delete.jpg', // Replace with your image path
                width: 500, // Adjust width as needed
                height: 500, // Adjust height as needed
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
        return GestureDetector(
          onTap: (){
            deleteUser(userList[index]['docId']);
          },
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0), // Adjust the horizontal padding as needed
            title: Text(userList[index]['userName'],
            style: const TextStyle(
              fontFamily: 'Poppins_Regular',
              color: Color.fromARGB(255, 19, 19, 73), // Text color
              fontWeight: FontWeight.bold,
            ),),
            subtitle: Text(userList[index]['userEmail'],
              style: const TextStyle(
                fontFamily: 'Poppins-Regular',
                color: Color.fromARGB(255, 19, 19, 73), // Text color
              ),),
            trailing: Padding(
              padding: const EdgeInsets.all(20.0),
              child: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // Call delete function when the delete button is pressed
                  deleteUser(userList[index]['docId']);
                },
              ),
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
