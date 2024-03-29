import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'firebase_options.dart';

// import 'dart:async';
// import 'package:openfoodfacts/openfoodfacts.dart';
// import 'package:openfoodfacts/openfoodfacts.dart';
// import 'package:project_scanner/pages/scanner.dart';
// import 'package:project_scanner/off_api_config.dart';

import 'package:flutter/material.dart';
import 'package:khao/pages/route_generator.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{
  OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'Khao');
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );
  // Initialize Firestore with a specific database ID
  FirebaseFirestore firestore = FirebaseFirestore.instance;
    // app: Firebase.app(),
    // databaseURL: 'https://data-extraction-d9aaa.firebaseio.com/(default)',
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Khao',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
} 
