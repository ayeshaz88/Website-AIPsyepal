import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_web/Splash%20Screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _appInitialization = Firebase.initializeApp(
    // App's Firebase configuration
    options: const FirebaseOptions(
      apiKey: "AIzaSyBAHE9XKS8xsPCcVjDVk7Sueq7VxU2sKbk",
      authDomain: "ai-psychepal.web.app",
      projectId: "ai-psychepal",
      storageBucket: "ai-psychepal.appspot.com",
      messagingSenderId: "370584542252",
      appId: "1:370584542252:web:020eca526df438dc32c589",

    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI PSYCHEPAL',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 19, 19, 73), // Set primary color here

      ),
      home: FutureBuilder(
        future: _appInitialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("App Firebase Initialization Error: ${snapshot.error}");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return FutureBuilder(
              future: Firebase.initializeApp(
                // Web's Firebase configuration
                options: const FirebaseOptions(
                  apiKey: "AIzaSyBVuT1OFtLmaeHqMVirBJVRbaqrosCOtv0",
                  authDomain: "website-demo-34890.firebaseapp.com",
                  projectId: "website-demo-34890",
                  storageBucket: "website-demo-34890.appspot.com",
                  messagingSenderId: "510032512568",
                  appId: "1:510032512568:web:73cd4f1155717a859a08cd",
                  measurementId: "G-ZJZF9HKPKD",
                ),
                name: "web",
              ),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print("Web Firebase Initialization Error: ${snapshot.error}");
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  // Return GetStartedScreen instead of MyHomePage
                  return SplashScreen();
                }
                return SplashScreen();
              },
            );
          }
          return SplashScreen();
        },
      ),
    );
  }
}
