import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FireHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Text('Firebase Initialized Successfully');
            }
            if (snapshot.hasError) {
              return Text('Error initializing Firebase');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
