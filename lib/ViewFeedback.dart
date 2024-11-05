import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewFeedback extends StatefulWidget {
  const ViewFeedback({Key? key}) : super(key: key);

  @override
  _ViewFeedbackState createState() => _ViewFeedbackState();
}

class _ViewFeedbackState extends State<ViewFeedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 19, 19, 73),
        title: const Text(
          'Feedback',
          style: TextStyle(color: Colors.white,
            fontFamily: 'Poppins-Regular',
          ),
        ),
      ),
      body: Stack(
        children: [
          FeedbackList(),

          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),

              child: Image.asset(
                'assets/images/viewfeed.jpg', // Replace with your image path
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

  }


class FeedbackList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('feedback').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No feedback available.'));
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return ListTile(
              title: Text(
              '${data['userEmail']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data['feedback'],

            ),


            );
          }).toList(),
        );
      },
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ViewFeedback(),
  ));
}
